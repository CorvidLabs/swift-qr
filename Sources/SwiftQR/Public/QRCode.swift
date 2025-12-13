import Foundation

public struct QRCode: Sendable {
    public let version: QRVersion
    public let errorCorrectionLevel: QRErrorCorrectionLevel
    public let size: Int

    internal let matrix: QRMatrix

    public static func encode(
        _ text: String,
        errorCorrection: QRErrorCorrectionLevel = .medium
    ) throws -> QRCode {
        let mode = QREncodingMode.optimal(for: text)
        return try encode(
            text,
            mode: mode,
            errorCorrection: errorCorrection,
            minVersion: .v1,
            maxVersion: .v40
        )
    }

    public static func encode(
        data: Data,
        errorCorrection: QRErrorCorrectionLevel = .medium
    ) throws -> QRCode {
        let encoded = try DataEncoder.encode(
            data: data,
            errorCorrection: errorCorrection,
            minVersion: .v1,
            maxVersion: .v40
        )

        return try buildQRCode(
            dataCodewords: encoded.codewords,
            version: encoded.version,
            errorCorrection: encoded.errorCorrection
        )
    }

    public static func encode(
        _ text: String,
        mode: QREncodingMode,
        errorCorrection: QRErrorCorrectionLevel,
        minVersion: QRVersion = .v1,
        maxVersion: QRVersion = .v40
    ) throws -> QRCode {
        let encoded = try DataEncoder.encode(
            text,
            mode: mode,
            errorCorrection: errorCorrection,
            minVersion: minVersion,
            maxVersion: maxVersion
        )

        return try buildQRCode(
            dataCodewords: encoded.codewords,
            version: encoded.version,
            errorCorrection: encoded.errorCorrection
        )
    }

    private static func buildQRCode(
        dataCodewords: [UInt8],
        version: QRVersion,
        errorCorrection: QRErrorCorrectionLevel
    ) throws -> QRCode {
        let interleavedCodewords = ReedSolomon.interleaveBlocks(
            dataCodewords: dataCodewords,
            version: version.number,
            errorCorrection: errorCorrection
        )

        let size = version.size
        var matrix = QRMatrix(size: size)

        PatternPlacer.placeAllFunctionPatterns(in: &matrix, version: version.number)

        DataPlacer.placeData(interleavedCodewords, in: &matrix)

        let bestMask = PenaltyCalculator.selectBestMask(
            for: matrix,
            version: version.number,
            errorCorrection: errorCorrection
        )

        bestMask.apply(to: &matrix)

        FormatInfo.place(errorCorrection: errorCorrection, mask: bestMask, in: &matrix)

        if version.number >= 7 {
            VersionInfo.place(version: version.number, in: &matrix)
        }

        return QRCode(
            version: version,
            errorCorrectionLevel: errorCorrection,
            size: size,
            matrix: matrix
        )
    }

    public func module(at x: Int, y: Int) -> Bool {
        return matrix[x, y]
    }

    public func modules() -> [(x: Int, y: Int, isDark: Bool)] {
        return matrix.allModules()
    }

    public func svg(
        moduleSize: Int = 10,
        quietZone: Int = 4,
        foregroundColor: String = "#000000",
        backgroundColor: String = "#FFFFFF"
    ) -> String {
        let config = SVGConfiguration(
            moduleSize: moduleSize,
            quietZone: quietZone,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor
        )
        return svg(config: config)
    }

    public func svg(config: SVGConfiguration) -> String {
        return SVGOutput.render(qrCode: self, config: config)
    }

    public func png(moduleSize: Int = 10, quietZone: Int = 4) -> [UInt8] {
        return PNGOutput.render(qrCode: self, moduleSize: moduleSize, quietZone: quietZone)
    }
}

extension QRCode {
    public struct SVGConfiguration: Sendable {
        public var moduleSize: Int
        public var quietZone: Int
        public var foregroundColor: String
        public var backgroundColor: String?

        public init(
            moduleSize: Int = 10,
            quietZone: Int = 4,
            foregroundColor: String = "#000000",
            backgroundColor: String? = "#FFFFFF"
        ) {
            self.moduleSize = moduleSize
            self.quietZone = quietZone
            self.foregroundColor = foregroundColor
            self.backgroundColor = backgroundColor
        }

        public static let `default` = SVGConfiguration()
    }
}
