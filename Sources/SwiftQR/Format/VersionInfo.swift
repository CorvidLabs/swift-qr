internal enum VersionInfo {
    static func encode(version: Int) -> UInt32? {
        guard version >= 7 && version <= 40 else { return nil }

        var remainder = UInt32(version) << 12

        let generator: UInt32 = 0x1F25

        for i in stride(from: 17, through: 12, by: -1) {
            if (remainder >> i) & 1 == 1 {
                remainder ^= generator << (i - 12)
            }
        }

        return (UInt32(version) << 12) | remainder
    }

    static func place(version: Int, in matrix: inout QRMatrix) {
        guard let versionBits = encode(version: version) else { return }

        var bitIndex = 0
        for i in 0..<6 {
            for j in 0..<3 {
                let bit = (versionBits >> bitIndex) & 1 == 1
                matrix.setFunction(x: matrix.size - 11 + j, y: i, isDark: bit)
                matrix.setFunction(x: i, y: matrix.size - 11 + j, isDark: bit)
                bitIndex += 1
            }
        }
    }
}
