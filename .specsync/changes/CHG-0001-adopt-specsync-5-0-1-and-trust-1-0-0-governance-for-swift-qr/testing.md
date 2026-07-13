---
change: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-qr
artifact: testing
---

# Testing

Run `specsync check --strict --force` at threshold 0, `specsync agents status`, `fledge trust doctor`, and `fledge lanes run verify`. The lane must build the package, pass all 34 tests, and run the QR CLI help smoke test.
