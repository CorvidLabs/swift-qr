public struct QRVersion: Sendable, Comparable, Hashable {
    public let number: Int

    public init?(number: Int) {
        guard number >= 1 && number <= 40 else { return nil }
        self.number = number
    }

    internal init(unchecked number: Int) {
        self.number = number
    }

    public var size: Int {
        return 21 + (number - 1) * 4
    }

    public static func minimum(
        for characterCount: Int,
        mode: QREncodingMode,
        errorCorrection: QRErrorCorrectionLevel
    ) -> QRVersion? {
        for version in 1...40 {
            let capacity = CapacityTable.capacity(
                version: version,
                errorCorrection: errorCorrection,
                mode: mode
            )
            if characterCount <= capacity {
                return QRVersion(unchecked: version)
            }
        }
        return nil
    }

    public static func < (lhs: QRVersion, rhs: QRVersion) -> Bool {
        return lhs.number < rhs.number
    }

    public static let v1 = QRVersion(unchecked: 1)
    public static let v2 = QRVersion(unchecked: 2)
    public static let v3 = QRVersion(unchecked: 3)
    public static let v4 = QRVersion(unchecked: 4)
    public static let v5 = QRVersion(unchecked: 5)
    public static let v6 = QRVersion(unchecked: 6)
    public static let v7 = QRVersion(unchecked: 7)
    public static let v8 = QRVersion(unchecked: 8)
    public static let v9 = QRVersion(unchecked: 9)
    public static let v10 = QRVersion(unchecked: 10)
    public static let v40 = QRVersion(unchecked: 40)
}
