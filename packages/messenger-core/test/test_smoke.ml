let () =
  let open Messenger_core in
  let message : Platform_types.outbound_message =
    {
      recipient = Platform_types.User_id "user-1";
      text = "hello";
      media_urls = [];
      metadata = [];
    }
  in
  match Connector_intf.validate_outbound_message message with
  | Ok () -> ()
  | Error _ -> failwith "expected valid message"

let () =
  let open Messenger_core in
  let request : Platform_types.read_request =
    { cursor = None; limit = Some 5; webhook_payload = None; metadata = [] }
  in
  match Connector_intf.validate_read_request request with
  | Ok () -> ()
  | Error _ -> failwith "expected valid read_request"
