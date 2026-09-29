---
id: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-qr
state: archived
type: migration
base_commit: a31faef63a7d2e170d0f03de43cc8ee8e0985efa
---

# Adopt SpecSync 5.0.1 and Trust 1.0.0 governance for Swift QR

## Intent

Adopt SpecSync 5.0.1 and Trust 1.0.0 governance for Swift QR

## Affected Canonical Specs

- None

## Acceptance Criteria

- SpecSync advisory coverage passes; all four agent integrations are installed; Trust doctor passes; Swift QR builds, all 34 tests pass, and the qr-gen CLI smoke check passes; existing Linux, macOS, and documentation workflows remain green.

## No-spec Rationale

This migration adds governance configuration and CI orchestration without changing Swift QR behavior; future meaningful implementation changes must add or update canonical specifications.

## Migration Note

Migrated by hand to SpecSync 6 per Leif's decision (2026-09-28); the 6.0.0 tool refused to archive this legacy record (`` exact-only delivery input `.github/workflows/trust.yml` changed after acceptance and requires an audited reopen; run `specsync change reopen CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-qr` to re-verify the accepted change, or supersede it from a later change under a module granted the path by `owns` in `.specsync/config.toml` ``).

- Workflow v1 (SpecSync 5) record, accepted on 2026-07-13 by the closing approval already stored in `approvals.json`. Its accepted evidence went stale when later commits changed its delivery inputs.
- Moved by hand from `.specsync/changes/CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-qr/` into the layout `specsync change archive` writes: `accepted-state.json` is the unchanged accepted `state.json`, `state.json` is marked `archived`, and this file's front matter says `archived`.
- `approvals.json`, `verification.json` and every other artifact are the original SpecSync 5 evidence, unchanged. `verification.json` verifies commit `43f1f0ec0f1f2232a2c1ec8eef7d59de0dd87519`, not the tree this record was archived from.
- There is no `verification-attempts.json`: SpecSync 5 did not write one for this record, and this migration does not invent attempt history.
- This migration added no verification evidence, test result, attempt history, or approval. It is a manual migration, not a fresh re-verification.
- Closing it through the tool takes `specsync change reopen`, `specsync change verify`, then `specsync change accept`, which writes a new closing approval. Per Leif's decision it was archived by hand instead, so no reopen or new approval is recorded.
