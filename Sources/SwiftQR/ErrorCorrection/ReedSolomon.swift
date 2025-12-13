internal enum ReedSolomon {
    static func encode(data: [UInt8], ecCodewords: Int) -> [UInt8] {
        let generator = generatorPolynomial(degree: ecCodewords)

        var remainder = [UInt8](repeating: 0, count: ecCodewords)

        for byte in data {
            let factor = byte ^ remainder[0]
            remainder.removeFirst()
            remainder.append(0)

            for i in 0..<ecCodewords {
                remainder[i] ^= GF256.multiply(generator.coefficients[i + 1], factor)
            }
        }

        return remainder
    }

    static func generatorPolynomial(degree: Int) -> Polynomial {
        var result = Polynomial(coefficients: [1])

        for i in 0..<degree {
            let factor = Polynomial(coefficients: [1, GF256.exp(i)])
            result = result.multiply(by: factor)
        }

        return result
    }

    static func interleaveBlocks(
        dataCodewords: [UInt8],
        version: Int,
        errorCorrection: QRErrorCorrectionLevel
    ) -> [UInt8] {
        let config = ErrorCorrectionTable.blockConfig(version: version, errorCorrection: errorCorrection)

        var dataBlocks: [[UInt8]] = []
        var ecBlocks: [[UInt8]] = []

        var offset = 0

        for _ in 0..<config.group1Blocks {
            let blockData = Array(dataCodewords[offset..<(offset + config.group1DataCodewords)])
            let ec = encode(data: blockData, ecCodewords: config.ecCodewordsPerBlock)
            dataBlocks.append(blockData)
            ecBlocks.append(ec)
            offset += config.group1DataCodewords
        }

        for _ in 0..<config.group2Blocks {
            let blockData = Array(dataCodewords[offset..<(offset + config.group2DataCodewords)])
            let ec = encode(data: blockData, ecCodewords: config.ecCodewordsPerBlock)
            dataBlocks.append(blockData)
            ecBlocks.append(ec)
            offset += config.group2DataCodewords
        }

        var result: [UInt8] = []

        let maxDataLength = max(config.group1DataCodewords, config.group2DataCodewords)
        for i in 0..<maxDataLength {
            for block in dataBlocks {
                if i < block.count {
                    result.append(block[i])
                }
            }
        }

        for i in 0..<config.ecCodewordsPerBlock {
            for block in ecBlocks {
                if i < block.count {
                    result.append(block[i])
                }
            }
        }

        return result
    }
}
