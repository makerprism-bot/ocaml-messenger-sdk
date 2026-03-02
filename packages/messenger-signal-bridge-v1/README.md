# messenger-signal-bridge-v1

Signal bridge connector package for `ocaml-messenger-sdk`.

This package targets Signal integration through bridge/daemon APIs (for example `signal-cli` HTTP bridges), not a direct official cloud API.

## Reference Implementations

Detailed reference notes are maintained in `REFERENCE_IMPLEMENTATIONS.md`.

The following repositories are used as behavioral and integration-contract references.

Only permissive-licensed references are listed.

| Repository | Why trusted | License |
|---|---|---|
| https://github.com/openclaw/openclaw | Very high-adoption production-grade integration that uses Signal via `signal-cli` JSON-RPC + SSE | MIT |
| https://github.com/bbernhard/signal-cli-rest-api | Widely used Signal bridge surface for HTTP-based automation workflows | MIT |

See `packages/messenger-signal-bridge-v1/REFERENCE_IMPLEMENTATIONS.md` for trust rationale, maintenance notes, and licensing details.

## Scope Note

- This package is intentionally named `signal-bridge` because it integrates with bridge-compatible APIs.
- It does not claim to be an official first-party Signal cloud SDK.

## Reuse Policy

- We use reference implementations for runtime behavior, bridge protocol semantics, and error handling expectations.
- We only adapt code patterns from permissive licenses compatible with this repository's MIT license.
- We do not copy code from repositories with incompatible licenses.
