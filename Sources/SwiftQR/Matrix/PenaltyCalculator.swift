internal enum PenaltyCalculator {
    static func calculate(matrix: QRMatrix) -> Int {
        return penaltyRule1(matrix: matrix)
            + penaltyRule2(matrix: matrix)
            + penaltyRule3(matrix: matrix)
            + penaltyRule4(matrix: matrix)
    }

    static func penaltyRule1(matrix: QRMatrix) -> Int {
        var penalty = 0

        for y in 0..<matrix.size {
            var runLength = 1
            var lastColor = matrix[0, y]

            for x in 1..<matrix.size {
                let currentColor = matrix[x, y]
                if currentColor == lastColor {
                    runLength += 1
                } else {
                    if runLength >= 5 {
                        penalty += 3 + (runLength - 5)
                    }
                    runLength = 1
                    lastColor = currentColor
                }
            }
            if runLength >= 5 {
                penalty += 3 + (runLength - 5)
            }
        }

        for x in 0..<matrix.size {
            var runLength = 1
            var lastColor = matrix[x, 0]

            for y in 1..<matrix.size {
                let currentColor = matrix[x, y]
                if currentColor == lastColor {
                    runLength += 1
                } else {
                    if runLength >= 5 {
                        penalty += 3 + (runLength - 5)
                    }
                    runLength = 1
                    lastColor = currentColor
                }
            }
            if runLength >= 5 {
                penalty += 3 + (runLength - 5)
            }
        }

        return penalty
    }

    static func penaltyRule2(matrix: QRMatrix) -> Int {
        var penalty = 0

        for y in 0..<(matrix.size - 1) {
            for x in 0..<(matrix.size - 1) {
                let color = matrix[x, y]
                if matrix[x + 1, y] == color
                    && matrix[x, y + 1] == color
                    && matrix[x + 1, y + 1] == color {
                    penalty += 3
                }
            }
        }

        return penalty
    }

    static func penaltyRule3(matrix: QRMatrix) -> Int {
        var penalty = 0

        let pattern1: [Bool] = [true, false, true, true, true, false, true, false, false, false, false]
        let pattern2: [Bool] = [false, false, false, false, true, false, true, true, true, false, true]

        for y in 0..<matrix.size {
            for x in 0..<(matrix.size - 10) {
                var match1 = true
                var match2 = true

                for i in 0..<11 {
                    if matrix[x + i, y] != pattern1[i] {
                        match1 = false
                    }
                    if matrix[x + i, y] != pattern2[i] {
                        match2 = false
                    }
                }

                if match1 || match2 {
                    penalty += 40
                }
            }
        }

        for x in 0..<matrix.size {
            for y in 0..<(matrix.size - 10) {
                var match1 = true
                var match2 = true

                for i in 0..<11 {
                    if matrix[x, y + i] != pattern1[i] {
                        match1 = false
                    }
                    if matrix[x, y + i] != pattern2[i] {
                        match2 = false
                    }
                }

                if match1 || match2 {
                    penalty += 40
                }
            }
        }

        return penalty
    }

    static func penaltyRule4(matrix: QRMatrix) -> Int {
        var darkCount = 0
        let totalModules = matrix.size * matrix.size

        for y in 0..<matrix.size {
            for x in 0..<matrix.size {
                if matrix[x, y] {
                    darkCount += 1
                }
            }
        }

        let percentDark = (darkCount * 100) / totalModules
        let prevMultiple = (percentDark / 5) * 5
        let nextMultiple = prevMultiple + 5

        let deviation1 = abs(prevMultiple - 50) / 5
        let deviation2 = abs(nextMultiple - 50) / 5

        return min(deviation1, deviation2) * 10
    }

    static func selectBestMask(for baseMatrix: QRMatrix, version: Int, errorCorrection: QRErrorCorrectionLevel) -> MaskPattern {
        var bestMask = MaskPattern.pattern0
        var bestPenalty = Int.max

        for mask in MaskPattern.allCases {
            var testMatrix = baseMatrix.copy()
            mask.apply(to: &testMatrix)
            FormatInfo.place(errorCorrection: errorCorrection, mask: mask, in: &testMatrix)

            if version >= 7 {
                VersionInfo.place(version: version, in: &testMatrix)
            }

            let penalty = calculate(matrix: testMatrix)
            if penalty < bestPenalty {
                bestPenalty = penalty
                bestMask = mask
            }
        }

        return bestMask
    }
}
