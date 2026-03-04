open Lwt.Infix

let to_cohttp_method = function
  | Messenger_core.Http_client.GET -> `GET
  | Messenger_core.Http_client.POST -> `POST
  | Messenger_core.Http_client.PUT -> `PUT
  | Messenger_core.Http_client.DELETE -> `DELETE
  | Messenger_core.Http_client.PATCH -> `PATCH

let response_of_cohttp response body =
  { Messenger_core.Http_client.status =
      Cohttp.Response.status response |> Cohttp.Code.code_of_status
  ; headers = Cohttp.Response.headers response |> Cohttp.Header.to_list
  ; body
  }

let run_async ~on_error work =
  Lwt.async (fun () ->
      Lwt.catch
        work
        (fun exn ->
          on_error (Printexc.to_string exn);
          Lwt.return_unit))

let encode_multipart ~boundary parts =
  let encode_part part =
    let disposition =
      match part.Messenger_core.Http_client.filename with
      | Some filename ->
          Printf.sprintf
            "Content-Disposition: form-data; name=\"%s\"; filename=\"%s\"\r\n"
            part.name filename
      | None ->
          Printf.sprintf "Content-Disposition: form-data; name=\"%s\"\r\n" part.name
    in
    let content_type =
      match part.content_type with
      | Some value -> "Content-Type: " ^ value ^ "\r\n"
      | None -> ""
    in
    Printf.sprintf "--%s\r\n%s%s\r\n%s\r\n" boundary disposition content_type part.body
  in
  String.concat "" (List.map encode_part parts) ^ Printf.sprintf "--%s--\r\n" boundary

module Make : Messenger_core.Http_client.HTTP_CLIENT = struct
  let request ~meth ?headers ?body url on_success on_error =
    let headers =
      match headers with
      | Some values -> Cohttp.Header.of_list values
      | None -> Cohttp.Header.init ()
    in
    let body =
      match body with
      | Some value -> Cohttp_lwt.Body.of_string value
      | None -> Cohttp_lwt.Body.empty
    in
    run_async ~on_error (fun () ->
        Cohttp_lwt_unix.Client.call ~headers ~body (to_cohttp_method meth) (Uri.of_string url)
        >>= fun (response, response_body) ->
        Cohttp_lwt.Body.to_string response_body >|= fun body_text ->
        on_success (response_of_cohttp response body_text))

  let get ?headers url on_success on_error =
    request ~meth:Messenger_core.Http_client.GET ?headers url on_success on_error

  let post ?headers ?body url on_success on_error =
    request ~meth:Messenger_core.Http_client.POST ?headers ?body url on_success on_error

  let post_multipart ?headers ~parts url on_success on_error =
    let boundary = Printf.sprintf "----MessengerBoundary%d" (Random.int 1_000_000) in
    let content_type =
      ( "Content-Type"
      , Printf.sprintf "multipart/form-data; boundary=%s" boundary )
    in
    let headers =
      match headers with
      | Some values -> content_type :: values
      | None -> [ content_type ]
    in
    let body = encode_multipart ~boundary parts in
    request
      ~meth:Messenger_core.Http_client.POST
      ~headers
      ~body
      url
      on_success
      on_error

  let put ?headers ?body url on_success on_error =
    request ~meth:Messenger_core.Http_client.PUT ?headers ?body url on_success on_error

  let delete ?headers url on_success on_error =
    request ~meth:Messenger_core.Http_client.DELETE ?headers url on_success on_error
end
