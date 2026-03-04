# Changelog

## Unreleased

- Initial package scaffold.
- Add `Cohttp_http_client.Make` as a concrete `cohttp-lwt-unix` backend for
  `Messenger_core.Http_client.HTTP_CLIENT`.
- Keep `Http_client_stub` for deterministic tests and explicit injection.
