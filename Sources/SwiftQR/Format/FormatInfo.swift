internal enum FormatInfo {
    private static let formatMask: UInt16 = 0x5412

    static func encode(errorCorrection: QRErrorCorrectionLevel, mask: MaskPattern) -> UInt16 {
        let data = (UInt16(errorCorrection.formatBits) << 3) | UInt16(mask.formatBits)

        var remainder = data << 10

        let generator: UInt16 = 0x537

        for i in stride(from: 14, through: 10, by: -1) {
            if (remainder >> i) & 1 == 1 {
                remainder ^= generator << (i - 10)
            }
        }

        let result = (data << 10) | remainder
        return result ^ formatMask
    }

    static func place(errorCorrection: QRErrorCorrectionLevel, mask: MaskPattern, in matrix: inout QRMatrix) {
        let formatBits = encode(errorCorrection: errorCorrection, mask: mask)

        // First copy - around top-left finder pattern
        // Bits 0-5: column 8, rows 0-5
        for i in 0..<6 {
            let bit = (formatBits >> i) & 1 == 1
            matrix.setFunction(x: 8, y: i, isDark: bit)
        }
        // Bit 6: column 8, row 7 (skip row 6 - timing pattern)
        let bit6 = (formatBits >> 6) & 1 == 1
        matrix.setFunction(x: 8, y: 7, isDark: bit6)
        // Bit 7: column 8, row 8
        let bit7 = (formatBits >> 7) & 1 == 1
        matrix.setFunction(x: 8, y: 8, isDark: bit7)
        // Bit 8: column 7, row 8
        let bit8 = (formatBits >> 8) & 1 == 1
        matrix.setFunction(x: 7, y: 8, isDark: bit8)
        // Bits 9-14: columns 5-0, row 8 (skip column 6 - timing pattern)
        for i in 9..<15 {
            let bit = (formatBits >> i) & 1 == 1
            matrix.setFunction(x: 14 - i, y: 8, isDark: bit)
        }

        // Second copy - around bottom-left and top-right finder patterns
        // Bits 0-7: row 8, columns (size-1) down to (size-8)
        for i in 0..<8 {
            let bit = (formatBits >> i) & 1 == 1
            matrix.setFunction(x: matrix.size - 1 - i, y: 8, isDark: bit)
        }
        // Bits 8-14: column 8, rows (size-7) to (size-1)
        for i in 8..<15 {
            let bit = (formatBits >> i) & 1 == 1
            matrix.setFunction(x: 8, y: matrix.size - 15 + i, isDark: bit)
        }
        // Dark module (always black)
        matrix.setFunction(x: 8, y: matrix.size - 8, isDark: true)
    }
}
