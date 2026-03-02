# Reference Implementations

This package uses the following open source projects as behavioral references for Telegram Bot API contract interpretation and runtime behavior.

License policy: only references with permissive licenses compatible with this repository's MIT license are listed.

## Primary references

| Repository | License | Why used | Notes |
|---|---|---|---|
| https://github.com/tdlib/telegram-bot-api | BSL-1.0 | Official Telegram Bot API server implementation | Authoritative source for protocol-level behavior |
| https://github.com/telegraf/telegraf | MIT | Large production ecosystem and broad API coverage | Useful for handler semantics and edge-case patterns |
| https://github.com/yagop/node-telegram-bot-api | MIT | Long-running, battle-tested Telegram bot library | Useful for stable request/response expectations |
| https://github.com/go-telegram-bot-api/telegram-bot-api | MIT | Clear and minimal mapping of bot endpoints | Useful for endpoint option defaults and payload fields |
| https://github.com/aiogram/aiogram | MIT | Mature async framework with strong API parity discipline | Useful for update/event model behavior |

## Usage boundaries

- Use these repositories to validate behavior and endpoint semantics.
- Preserve original design intent, but implement idiomatically in OCaml.
- Do not copy code from incompatible-license repositories.
