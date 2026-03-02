(lang dune 3.16)
(name ocaml-messenger-sdk)

(generate_opam_files true)

(source (github makerprism-bot/ocaml-messenger-sdk))
(license MIT)
(authors "Sabine Schmaltz")
(maintainers "sabine@makerprism.com")
(documentation "https://github.com/makerprism-bot/ocaml-messenger-sdk")
(bug_reports "https://github.com/makerprism-bot/ocaml-messenger-sdk/issues")

(package
 (name messenger-whatsapp-cloud-v1)
 (synopsis "WhatsApp Cloud API v1 client")
 (description
  "WhatsApp Cloud API connector for business messaging workflows, including text/template/media sends and webhook-oriented delivery semantics")
 (depends
  (ocaml (>= 4.14))
  yojson
  uri
  ptime
  digestif
  base64))

(package
 (name messenger-telegram-bot-v1)
 (synopsis "Telegram Bot API v1 connector")
 (description
  "Telegram Bot API connector for bot and channel or group messaging workflows with deterministic send behavior")
 (depends
  (ocaml (>= 4.14))
  yojson
  uri
  str))

(package
 (name messenger-signal-bridge-v1)
 (synopsis "Signal bridge API v1 client")
 (description
  "Signal bridge connector targeting signal-cli compatible HTTP bridges with send operations and event parsing")
 (depends
  (ocaml (>= 4.14))
  yojson
  uri
  ptime
  base64))
