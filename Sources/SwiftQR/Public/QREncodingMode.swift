public enum QREncodingMode: Sendable {
    case numeric
    case alphanumeric
    case byte

    internal var indicator: UInt8 {
        switch self {
        case .numeric: return 0b0001
        case .alphanumeric: return 0b0010
        case .byte: return 0b0100
        }
    }

    public static func optimal(for text: String) -> QREncodingMode {
        if text.allSatisfy({ $0.isNumber }) {
            return .numeric
        }
        if text.allSatisfy({ AlphanumericEncoder.characterValue($0) != nil }) {
            return .alphanumeric
        }
        return .byte
    }

    public func isValid(for text: String) -> Bool {
        switch self {
        case .numeric:
            return text.allSatisfy { $0.isNumber }
        case .alphanumeric:
            return text.allSatisfy { AlphanumericEncoder.characterValue($0) != nil }
        case .byte:
            return true
        }
    }

    internal func characterCountBits(version: Int) -> Int {
        switch self {
        case .numeric:
            if version <= 9 { return 10 }
            if version <= 26 { return 12 }
            return 14
        case .alphanumeric:
            if version <= 9 { return 9 }
            if version <= 26 { return 11 }
            return 13
        case .byte:
            if version <= 9 { return 8 }
            return 16
        }
    }
}
