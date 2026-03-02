# Reference Implementations

This package uses the following open source projects as behavioral references for API contract interpretation and edge-case handling.

License policy: only references with permissive licenses compatible with this repository's MIT license are listed.

## Primary references

| Repository | License | Why used | Notes |
|---|---|---|---|
| https://github.com/netflie/whatsapp-cloud-api | MIT | Focused WhatsApp Cloud API SDK with active maintenance and practical endpoint coverage | Useful for message payload shapes and webhook handling expectations |
| https://github.com/Bindambc/whatsapp-business-java-api | MIT | Broad WhatsApp Business Cloud API and management API scope | Useful for management endpoints and template workflows |
| https://github.com/Secreto31126/whatsapp-api-js | MIT | TypeScript-first implementation of official WhatsApp API flows | Useful for request composition and runtime error patterns |

## Usage boundaries

- Use these repositories to validate behavior and endpoint semantics.
- Preserve original design intent, but implement idiomatically in OCaml.
- Do not copy code from incompatible-license repositories.
