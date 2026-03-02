# Agent Workspace Rules

These rules apply to all coding agents working in this repository.

## Building

```bash
dune build
```

If dependency metadata is stale, regenerate lock data first:

```bash
dune pkg lock
dune build
```

## Dune Lockfile Workflow

- If dependencies changed, or Dune reports stale lock data, run `dune pkg lock`.
- Do not manually edit files under `dune.lock/`.
- Regenerate lock data only via `dune pkg lock`.

## Dependency Policy

- `dune` must not be listed as a package dependency in `dune-project` package stanzas.

## Build Directory Safety

- Never run `dune clean`.
- Never delete or mutate `_build/` manually.

## Security and Sensitive Data

- Never print or commit real API tokens, bot secrets, phone numbers, chat IDs, or webhook secrets.
- Redact token-like strings in logs and surfaced errors.
- Treat message payloads as sensitive user data; prefer minimal structured logs.
