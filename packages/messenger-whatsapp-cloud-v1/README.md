# messenger-whatsapp-cloud-v1

WhatsApp Cloud API client package for `ocaml-messenger-sdk`.

This package targets business messaging workflows (text/template/media send, webhook verification, and delivery status handling) while following the runtime-agnostic patterns used across the SDK.

## Reference Implementations

Detailed reference notes are maintained in `REFERENCE_IMPLEMENTATIONS.md`.

The following repositories are used as behavioral and API-contract references.

Only permissive-licensed references are listed.

| Repository | Why trusted | License |
|---|---|---|
| https://github.com/netflie/whatsapp-cloud-api | Widely used SDK focused on WhatsApp Cloud API with active maintenance | MIT |
| https://github.com/Bindambc/whatsapp-business-java-api | Comprehensive WhatsApp Business Cloud API + management coverage | MIT |
| https://github.com/Secreto31126/whatsapp-api-js | Modern TypeScript implementation focused on official WhatsApp APIs | MIT |

See `packages/messenger-whatsapp-cloud-v1/REFERENCE_IMPLEMENTATIONS.md` for trust rationale, maintenance notes, and licensing details.

## Reuse Policy

- We use reference implementations for endpoint behavior, payload shape validation, and error semantics.
- We only adapt code patterns from permissive licenses compatible with this repository's MIT license.
- We do not copy code from repositories with incompatible licenses.
