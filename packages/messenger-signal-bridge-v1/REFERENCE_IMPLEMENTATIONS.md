# Reference Implementations

This package uses the following open source projects as behavioral references for Signal bridge integrations.

License policy: only references with permissive licenses compatible with this repository's MIT license are listed.

## Primary references

| Repository | License | Why used | Notes |
|---|---|---|---|
| https://github.com/openclaw/openclaw | MIT | Large-scale, actively maintained Signal integration via `signal-cli` | Useful for JSON-RPC and SSE bridge integration behavior |
| https://github.com/bbernhard/signal-cli-rest-api | MIT | Widely used HTTP bridge around `signal-cli` | Useful for bridge endpoint conventions and operations |

## Scope constraints

- This package intentionally targets bridge-compatible Signal APIs (for example `signal-cli` daemon or REST wrapper surfaces).
- It is not an official first-party Signal cloud API SDK.

## Usage boundaries

- Use these repositories to validate behavior and integration semantics.
- Preserve original design intent, but implement idiomatically in OCaml.
- Do not copy code from incompatible-license repositories.
