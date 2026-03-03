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

## Upstream PR Workflow

- Canonical upstream is `makerprism/ocaml-messenger-sdk`.
- Before opening/updating a PR to `upstream/main`, rebase your branch onto `upstream/main`.
- If already pushed, update with `git push --force-with-lease`.

## Package Changelog and Docs

- For behavior or API changes in a package, update that package's `CHANGES.md` under `## Unreleased`.
- Keep package `README.md` feature/status notes aligned with actual implementation state.
- If adding or changing reference-source guidance, update `REFERENCE_IMPLEMENTATIONS.md` in the same package.

## Reference Implementation Policy

- Port behavior from reference implementations, but avoid copying code verbatim.
- Prefer permissive-license references (MIT/BSL-compatible) for close adaptation.
- Do not add incompatible-license source code to this repository.

## Testing Expectations

- For non-trivial behavior changes, add or update package-local tests in `packages/<name>/test/`.
- Before proposing a PR, run:
  - `dune build`
  - `dune runtest`
