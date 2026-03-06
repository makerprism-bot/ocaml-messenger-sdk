module type S = sig
  val platform : Platform_types.platform
  val supports_explicit_read_ack : bool

  val send_message :
    account_id:string ->
    Platform_types.outbound_message ->
    ((Platform_types.message_id, Error_types.error) result -> unit) ->
    unit

  (** Sends posts sequentially.
      Returns [Ok thread_result] even when a later post fails; in that case
      [failed_at_index] is [Some idx] and [posted_ids] contains successful sends before idx. *)
  val send_thread :
    account_id:string ->
    Platform_types.thread_request ->
    ((Platform_types.thread_result, Error_types.error) result -> unit) ->
    unit

  val validate_access :
    account_id:string ->
    ((unit, Error_types.error) result -> unit) ->
    unit

  val read_messages :
    account_id:string ->
    Platform_types.read_request ->
    ((Platform_types.read_result, Error_types.error) result -> unit) ->
    unit

  val acknowledge_read :
    account_id:string ->
    message_id:Platform_types.message_id ->
    ((unit, Error_types.error) result -> unit) ->
    unit
end

let validate_outbound_message (msg : Platform_types.outbound_message) =
  let errors = ref [] in
  if String.length (String.trim msg.text) = 0 && msg.media_urls = [] then
    errors := { Error_types.field = "text"; message = "must not be empty when no media is attached" } :: !errors;
  if msg.media_urls <> [] && String.length msg.text > 1024 then
    errors := { Error_types.field = "text"; message = "caption too long (max 1024 for media messages)" } :: !errors;
  if String.length msg.text > 4096 then
    errors := { Error_types.field = "text"; message = "message too long (max 4096)" } :: !errors;
  if !errors = [] then Ok () else Error (List.rev !errors)

let validate_read_request (request : Platform_types.read_request) =
  let errors = ref [] in
  (match request.limit with
   | Some value when value <= 0 ->
       errors := { Error_types.field = "limit"; message = "must be greater than 0" } :: !errors
   | Some value when value > 100 ->
       errors := { Error_types.field = "limit"; message = "must be less than or equal to 100" } :: !errors
   | _ -> ());
  (match request.webhook_payload with
   | Some payload when String.trim payload = "" ->
       errors := { Error_types.field = "webhook_payload"; message = "must not be empty" } :: !errors
   | _ -> ());
  if !errors = [] then Ok () else Error (List.rev !errors)
