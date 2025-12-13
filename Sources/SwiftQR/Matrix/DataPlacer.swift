internal enum DataPlacer {
    static func placeData(_ codewords: [UInt8], in matrix: inout QRMatrix) {
        var bits: [Bool] = []
        for byte in codewords {
            for i in stride(from: 7, through: 0, by: -1) {
                bits.append((byte >> i) & 1 == 1)
            }
        }

        var bitIndex = 0
        var right = matrix.size - 1

        while right >= 1 && bitIndex < bits.count {
            // Skip column 6 (vertical timing pattern)
            if right == 6 {
                right = 5
            }

            // Direction based on column position: ((right + 1) & 2) == 0 means upward
            let upward = ((right + 1) & 2) == 0

            for vert in 0..<matrix.size {
                let y = upward ? matrix.size - 1 - vert : vert

                for j in 0..<2 {
                    let x = right - j
                    if x >= 0 && !matrix.isReserved(x: x, y: y) {
                        if bitIndex < bits.count {
                            matrix[x, y] = bits[bitIndex]
                            bitIndex += 1
                        }
                    }
                }
            }

            right -= 2
        }
    }

    static func countDataModules(size: Int, version: Int) -> Int {
        var count = 0

        var tempMatrix = QRMatrix(size: size)
        PatternPlacer.placeAllFunctionPatterns(in: &tempMatrix, version: version)

        for y in 0..<size {
            for x in 0..<size {
                if !tempMatrix.isReserved(x: x, y: y) {
                    count += 1
                }
            }
        }

        return count
    }
}
