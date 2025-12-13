import Foundation

internal enum DataEncoder {
    struct EncodedData {
        let version: QRVersion
        let errorCorrection: QRErrorCorrectionLevel
        let codewords: [UInt8]
    }

    static func encode(
        _ text: String,
        mode: QREncodingMode,
        errorCorrection: QRErrorCorrectionLevel,
        minVersion: QRVersion = .v1,
        maxVersion: QRVersion = .v40
    ) throws -> EncodedData {
        let characterCount = mode == .byte ? ByteEncoder.byteCount(text) : text.count

        guard let version = findMinimumVersion(
            characterCount: characterCount,
            mode: mode,
            errorCorrection: errorCorrection,
            minVersion: minVersion,
            maxVersion: maxVersion
        ) else {
            let maxCapacity = CapacityTable.capacity(
                version: maxVersion.number,
                errorCorrection: errorCorrection,
                mode: mode
            )
            throw QRError.dataTooLong(maxCapacity: maxCapacity, actualLength: characterCount)
        }

        let config = ErrorCorrectionTable.blockConfig(version: version.number, errorCorrection: errorCorrection)
        let totalDataCodewords = config.totalDataCodewords

        var buffer = BitBuffer()

        buffer.append(UInt32(mode.indicator), count: 4)

        let countBits = mode.characterCountBits(version: version.number)
        buffer.append(UInt32(characterCount), count: countBits)

        switch mode {
        case .numeric:
            try NumericEncoder.encode(text, into: &buffer)
        case .alphanumeric:
            try AlphanumericEncoder.encode(text, into: &buffer)
        case .byte:
            try ByteEncoder.encode(text, into: &buffer)
        }

        let terminatorLength = min(4, totalDataCodewords * 8 - buffer.bitCount)
        if terminatorLength > 0 {
            buffer.append(0, count: terminatorLength)
        }

        while buffer.bitCount % 8 != 0 {
            buffer.append(false)
        }

        let padCodewords: [UInt8] = [0xEC, 0x11]
        var padIndex = 0
        while buffer.byteCount < totalDataCodewords {
            buffer.appendByte(padCodewords[padIndex])
            padIndex = (padIndex + 1) % 2
        }

        return EncodedData(
            version: version,
            errorCorrection: errorCorrection,
            codewords: buffer.toBytes()
        )
    }

    static func encode(
        data: Data,
        errorCorrection: QRErrorCorrectionLevel,
        minVersion: QRVersion = .v1,
        maxVersion: QRVersion = .v40
    ) throws -> EncodedData {
        let characterCount = data.count

        guard let version = findMinimumVersion(
            characterCount: characterCount,
            mode: .byte,
            errorCorrection: errorCorrection,
            minVersion: minVersion,
            maxVersion: maxVersion
        ) else {
            let maxCapacity = CapacityTable.capacity(
                version: maxVersion.number,
                errorCorrection: errorCorrection,
                mode: .byte
            )
            throw QRError.dataTooLong(maxCapacity: maxCapacity, actualLength: characterCount)
        }

        let config = ErrorCorrectionTable.blockConfig(version: version.number, errorCorrection: errorCorrection)
        let totalDataCodewords = config.totalDataCodewords

        var buffer = BitBuffer()

        buffer.append(UInt32(QREncodingMode.byte.indicator), count: 4)

        let countBits = QREncodingMode.byte.characterCountBits(version: version.number)
        buffer.append(UInt32(characterCount), count: countBits)

        ByteEncoder.encode(data: data, into: &buffer)

        let terminatorLength = min(4, totalDataCodewords * 8 - buffer.bitCount)
        if terminatorLength > 0 {
            buffer.append(0, count: terminatorLength)
        }

        while buffer.bitCount % 8 != 0 {
            buffer.append(false)
        }

        let padCodewords: [UInt8] = [0xEC, 0x11]
        var padIndex = 0
        while buffer.byteCount < totalDataCodewords {
            buffer.appendByte(padCodewords[padIndex])
            padIndex = (padIndex + 1) % 2
        }

        return EncodedData(
            version: version,
            errorCorrection: errorCorrection,
            codewords: buffer.toBytes()
        )
    }

    private static func findMinimumVersion(
        characterCount: Int,
        mode: QREncodingMode,
        errorCorrection: QRErrorCorrectionLevel,
        minVersion: QRVersion,
        maxVersion: QRVersion
    ) -> QRVersion? {
        for versionNum in minVersion.number...maxVersion.number {
            let capacity = CapacityTable.capacity(
                version: versionNum,
                errorCorrection: errorCorrection,
                mode: mode
            )
            if characterCount <= capacity {
                return QRVersion(unchecked: versionNum)
            }
        }
        return nil
    }
}
