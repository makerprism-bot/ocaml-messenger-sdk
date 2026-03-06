type platform =
  | Telegram_bot
  | Whatsapp_cloud
  | Signal_bridge
  | Custom of string

type recipient =
  | User_id of string
  | Phone_number of string
  | Channel_id of string

type outbound_message = {
  recipient : recipient;
  text : string;
  media_urls : string list;
  metadata : (string * string) list;
}

type message_id = string

type inbound_message = {
  id : message_id;
  sender_id : string option;
  text : string option;
  raw_payload : string;
  metadata : (string * string) list;
}

type read_request = {
  cursor : string option;
  limit : int option;
  webhook_payload : string option;
  metadata : (string * string) list;
}

type read_result = {
  messages : inbound_message list;
  next_cursor : string option;
  has_more : bool;
}

type thread_request = {
  posts : outbound_message list;
}

type thread_result = {
  posted_ids : message_id list;
  failed_at_index : int option;
  total_requested : int;
}
