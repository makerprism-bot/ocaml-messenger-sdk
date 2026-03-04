open Lwt.Infix

let fail msg = raise (Failure msg)

module Good_http : Messenger_core.Http_client.HTTP_CLIENT = struct
  let request ~meth:_ ?headers:_ ?body:_ _url on_success _on_error =
    on_success { Messenger_core.Http_client.status = 200; headers = []; body = "ok" }

  let get ?headers:_ _url on_success _on_error =
    on_success { Messenger_core.Http_client.status = 200; headers = []; body = "get" }

  let post ?headers:_ ?body:_ _url on_success _on_error =
    on_success { Messenger_core.Http_client.status = 201; headers = []; body = "post" }

  let post_multipart ?headers:_ ~parts:_ _url on_success _on_error =
    on_success { Messenger_core.Http_client.status = 201; headers = []; body = "multipart" }

  let put ?headers:_ ?body:_ _url on_success _on_error =
    on_success { Messenger_core.Http_client.status = 200; headers = []; body = "put" }

  let delete ?headers:_ _url on_success _on_error =
    on_success { Messenger_core.Http_client.status = 204; headers = []; body = "" }
end

module Bad_http : Messenger_core.Http_client.HTTP_CLIENT = struct
  let request ~meth:_ ?headers:_ ?body:_ _url _on_success on_error = on_error "boom"
  let get ?headers:_ _url _on_success on_error = on_error "boom"
  let post ?headers:_ ?body:_ _url _on_success on_error = on_error "boom"
  let post_multipart ?headers:_ ~parts:_ _url _on_success on_error = on_error "boom"
  let put ?headers:_ ?body:_ _url _on_success on_error = on_error "boom"
  let delete ?headers:_ _url _on_success on_error = on_error "boom"
end

module Good_lwt = Messenger_lwt.Adapt_http_client (Good_http)
module Bad_lwt = Messenger_lwt.Adapt_http_client (Bad_http)

let with_test_server handler f =
  let open Cohttp_lwt_unix in
  let stop, stopper = Lwt.wait () in
  let callback _conn req body = handler req body in
  let server = Server.make ~callback () in
  let socket = Lwt_unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
  Lwt_unix.bind socket (Unix.ADDR_INET (Unix.inet_addr_loopback, 0)) >>= fun () ->
  let port =
    match Lwt_unix.getsockname socket with
    | Unix.ADDR_INET (_, p) -> p
    | _ -> fail "unexpected socket family"
  in
  Lwt_unix.close socket >>= fun () ->
  Lwt.async (fun () -> Server.create ~mode:(`TCP (`Port port)) ~stop server);
  let base_url = Printf.sprintf "http://127.0.0.1:%d" port in
  Lwt.finalize
    (fun () -> Lwt_unix.sleep 0.02 >>= fun () -> f base_url)
    (fun () ->
      Lwt.wakeup_later stopper ();
      Lwt.return_unit)

let test_adapter_success () =
  match Lwt_main.run (Good_lwt.get "http://example.test" ()) with
  | Ok response ->
      if response.status <> 200 then fail "expected status 200 from adapted client"
  | Error err -> fail ("expected successful response, got error: " ^ err)

let test_adapter_error () =
  match Lwt_main.run (Bad_lwt.get "http://example.test" ()) with
  | Ok _ -> fail "expected error from adapted failing client"
  | Error "boom" -> ()
  | Error err -> fail ("unexpected error string: " ^ err)

let test_cohttp_get_roundtrip () =
  let handler _req _body =
    Cohttp_lwt_unix.Server.respond_string
      ~status:`Accepted
      ~headers:(Cohttp.Header.of_list [ ("X-Test", "yes") ])
      ~body:"pong"
      ()
  in
  let result =
    with_test_server handler (fun base_url ->
        let promise, resolver = Lwt.wait () in
        Messenger_lwt.Cohttp_http_client.Make.get
          (base_url ^ "/ping")
          (fun response -> Lwt.wakeup_later resolver (Ok response))
          (fun err -> Lwt.wakeup_later resolver (Error err));
        promise)
    |> Lwt_main.run
  in
  match result with
  | Ok response ->
      if response.status <> 202 then fail "expected status 202 from local server";
      if response.body <> "pong" then fail "expected response body pong";
      if not (List.mem ("x-test", "yes") (List.map (fun (k, v) -> (String.lowercase_ascii k, v)) response.headers)) then
        fail "expected x-test header to propagate"
  | Error err -> fail ("expected successful cohttp roundtrip, got error: " ^ err)

let () =
  test_adapter_success ();
  test_adapter_error ();
  test_cohttp_get_roundtrip ()
