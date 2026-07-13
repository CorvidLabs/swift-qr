---
id: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-qr
state: accepted
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
