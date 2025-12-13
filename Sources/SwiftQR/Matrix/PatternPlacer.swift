internal enum PatternPlacer {
    static func placeFinderPattern(in matrix: inout QRMatrix, centerX: Int, centerY: Int) {
        for dy in -3...3 {
            for dx in -3...3 {
                let x = centerX + dx
                let y = centerY + dy

                let isDark: Bool
                // Finder pattern is concentric squares: 7x7 dark, 5x5 light, 3x3 dark
                if abs(dx) == 3 || abs(dy) == 3 {
                    // Outer 7x7 border
                    isDark = true
                } else if abs(dx) == 2 || abs(dy) == 2 {
                    // 5x5 border (inside outer, outside center)
                    isDark = false
                } else {
                    // Inner 3x3 center
                    isDark = true
                }

                matrix.setFunction(x: x, y: y, isDark: isDark)
            }
        }
    }

    static func placeFinderPatterns(in matrix: inout QRMatrix) {
        placeFinderPattern(in: &matrix, centerX: 3, centerY: 3)
        placeFinderPattern(in: &matrix, centerX: matrix.size - 4, centerY: 3)
        placeFinderPattern(in: &matrix, centerX: 3, centerY: matrix.size - 4)
    }

    static func placeSeparators(in matrix: inout QRMatrix) {
        for i in 0...7 {
            matrix.setFunction(x: 7, y: i, isDark: false)
            matrix.setFunction(x: i, y: 7, isDark: false)

            matrix.setFunction(x: matrix.size - 8, y: i, isDark: false)
            matrix.setFunction(x: matrix.size - 1 - i, y: 7, isDark: false)

            matrix.setFunction(x: 7, y: matrix.size - 1 - i, isDark: false)
            matrix.setFunction(x: i, y: matrix.size - 8, isDark: false)
        }
    }

    static func placeTimingPatterns(in matrix: inout QRMatrix) {
        for i in 8..<(matrix.size - 8) {
            let isDark = i % 2 == 0
            matrix.setFunction(x: i, y: 6, isDark: isDark)
            matrix.setFunction(x: 6, y: i, isDark: isDark)
        }
    }

    static func placeAlignmentPattern(in matrix: inout QRMatrix, centerX: Int, centerY: Int) {
        for dy in -2...2 {
            for dx in -2...2 {
                let x = centerX + dx
                let y = centerY + dy

                let isDark: Bool
                let maxDist = max(abs(dx), abs(dy))
                if maxDist == 0 || maxDist == 2 {
                    isDark = true
                } else {
                    isDark = false
                }

                matrix.setFunction(x: x, y: y, isDark: isDark)
            }
        }
    }

    static func placeAlignmentPatterns(in matrix: inout QRMatrix, version: Int) {
        let centers = AlignmentPatternTable.centers(for: version)
        for center in centers {
            placeAlignmentPattern(in: &matrix, centerX: center.x, centerY: center.y)
        }
    }

    static func reserveFormatAreas(in matrix: inout QRMatrix) {
        for i in 0...8 {
            if i != 6 {
                matrix.reserve(x: i, y: 8)
                matrix.reserve(x: 8, y: i)
            }
        }

        for i in 0...7 {
            matrix.reserve(x: matrix.size - 1 - i, y: 8)
            matrix.reserve(x: 8, y: matrix.size - 1 - i)
        }
    }

    static func reserveVersionAreas(in matrix: inout QRMatrix, version: Int) {
        guard version >= 7 else { return }

        for i in 0..<6 {
            for j in 0..<3 {
                matrix.reserve(x: matrix.size - 11 + j, y: i)
                matrix.reserve(x: i, y: matrix.size - 11 + j)
            }
        }
    }

    static func placeDarkModule(in matrix: inout QRMatrix, version: Int) {
        let x = 8
        let y = 4 * version + 9
        matrix.setFunction(x: x, y: y, isDark: true)
    }

    static func placeAllFunctionPatterns(in matrix: inout QRMatrix, version: Int) {
        placeFinderPatterns(in: &matrix)
        placeSeparators(in: &matrix)
        placeTimingPatterns(in: &matrix)
        placeAlignmentPatterns(in: &matrix, version: version)
        reserveFormatAreas(in: &matrix)
        reserveVersionAreas(in: &matrix, version: version)
        placeDarkModule(in: &matrix, version: version)
    }
}
