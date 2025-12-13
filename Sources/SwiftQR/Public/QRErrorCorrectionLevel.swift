public enum QRErrorCorrectionLevel: String, Sendable, CaseIterable {
    case low = "L"
    case medium = "M"
    case quartile = "Q"
    case high = "H"

    internal var formatBits: UInt8 {
        switch self {
        case .low: return 0b01
        case .medium: return 0b00
        case .quartile: return 0b11
        case .high: return 0b10
        }
    }

    internal var tableIndex: Int {
        switch self {
        case .low: return 0
        case .medium: return 1
        case .quartile: return 2
        case .high: return 3
        }
    }
}
