import Testing
@testable import SwiftQR

@Suite("SwiftQR Tests")
struct SwiftQRTests {
    @Test("Encode simple text")
    func encodeSimpleText() throws {
        let qr = try QRCode.encode("Hello, World!")
        #expect(qr.size > 0)
        #expect(qr.version.number >= 1)
    }

    @Test("Encode numeric text uses numeric mode")
    func encodeNumeric() throws {
        let qr = try QRCode.encode("12345678901234567890", mode: .numeric, errorCorrection: .low)
        #expect(qr.version.number >= 1)
    }

    @Test("Encode alphanumeric text")
    func encodeAlphanumeric() throws {
        let qr = try QRCode.encode("HELLO WORLD", mode: .alphanumeric, errorCorrection: .medium)
        #expect(qr.version.number >= 1)
    }

    @Test("Encode URL")
    func encodeURL() throws {
        let qr = try QRCode.encode("https://example.com", errorCorrection: .high)
        #expect(qr.size > 0)
    }

    @Test("Generate SVG output")
    func generateSVG() throws {
        let qr = try QRCode.encode("Test")
        let svg = qr.svg()
        #expect(svg.contains("<svg"))
        #expect(svg.contains("</svg>"))
        #expect(svg.contains("<rect"))
    }

    @Test("SVG with custom configuration")
    func svgWithConfig() throws {
        let qr = try QRCode.encode("Test")
        let svg = qr.svg(
            moduleSize: 5,
            quietZone: 2,
            foregroundColor: "#FF0000",
            backgroundColor: "#00FF00"
        )
        #expect(svg.contains("<svg"))
    }

    @Test("Generate PNG output")
    func generatePNG() throws {
        let qr = try QRCode.encode("Test")
        let png = qr.png()
        #expect(png.count > 0)
        // PNG magic bytes
        #expect(png[0] == 0x89)
        #expect(png[1] == 0x50)  // P
        #expect(png[2] == 0x4E)  // N
        #expect(png[3] == 0x47)  // G
    }

    @Test("PNG with custom options")
    func pngWithOptions() throws {
        let qr = try QRCode.encode("Hello")
        let png = qr.png(moduleSize: 5, quietZone: 2)
        #expect(png.count > 0)
    }

    @Test("Version size calculation")
    func versionSize() {
        let v1 = QRVersion(number: 1)!
        #expect(v1.size == 21)

        let v2 = QRVersion(number: 2)!
        #expect(v2.size == 25)

        let v10 = QRVersion(number: 10)!
        #expect(v10.size == 57)

        let v40 = QRVersion(number: 40)!
        #expect(v40.size == 177)
    }

    @Test("Error correction levels")
    func errorCorrectionLevels() throws {
        for level in QRErrorCorrectionLevel.allCases {
            let qr = try QRCode.encode("Test", errorCorrection: level)
            #expect(qr.errorCorrectionLevel == level)
        }
    }

    @Test("Encoding mode detection")
    func encodingModeDetection() {
        #expect(QREncodingMode.optimal(for: "12345") == .numeric)
        #expect(QREncodingMode.optimal(for: "HELLO") == .alphanumeric)
        #expect(QREncodingMode.optimal(for: "hello") == .byte)
        #expect(QREncodingMode.optimal(for: "Hello123") == .byte)
    }

    @Test("Module access")
    func moduleAccess() throws {
        let qr = try QRCode.encode("A")

        // Check finder pattern corners (should be dark)
        #expect(qr.module(at: 0, y: 0) == true)
        #expect(qr.module(at: qr.size - 1, y: 0) == true)
        #expect(qr.module(at: 0, y: qr.size - 1) == true)
    }

    @Test("Invalid version returns nil")
    func invalidVersion() {
        #expect(QRVersion(number: 0) == nil)
        #expect(QRVersion(number: 41) == nil)
        #expect(QRVersion(number: -1) == nil)
    }

    @Test("Modules iterator")
    func modulesIterator() throws {
        let qr = try QRCode.encode("X")
        let modules = qr.modules()

        #expect(modules.count == qr.size * qr.size)

        let darkModules = modules.filter { $0.isDark }
        #expect(darkModules.count > 0)
    }
}

@Suite("BitBuffer Tests")
struct BitBufferTests {
    @Test("Append bits")
    func appendBits() {
        var buffer = BitBuffer()
        buffer.append(0b1010, count: 4)
        #expect(buffer.bitCount == 4)
        #expect(buffer.getBit(at: 0) == true)
        #expect(buffer.getBit(at: 1) == false)
        #expect(buffer.getBit(at: 2) == true)
        #expect(buffer.getBit(at: 3) == false)
    }

    @Test("Append byte")
    func appendByte() {
        var buffer = BitBuffer()
        buffer.appendByte(0xFF)
        #expect(buffer.bitCount == 8)
        #expect(buffer.toBytes() == [0xFF])
    }
}

@Suite("GaloisField Tests")
struct GaloisFieldTests {
    @Test("Multiply by zero")
    func multiplyByZero() {
        #expect(GF256.multiply(0, 5) == 0)
        #expect(GF256.multiply(5, 0) == 0)
    }

    @Test("Multiply by one")
    func multiplyByOne() {
        #expect(GF256.multiply(1, 5) == 5)
        #expect(GF256.multiply(5, 1) == 5)
    }

    @Test("Power of zero")
    func powerOfZero() {
        #expect(GF256.power(5, 0) == 1)
    }
}

@Suite("Reed-Solomon Tests")
struct ReedSolomonTests {
    @Test("Generate EC codewords")
    func generateECCodewords() {
        let data: [UInt8] = [32, 91, 11, 120, 209, 114, 220, 77, 67, 64, 236, 17, 236, 17, 236, 17]
        let ec = ReedSolomon.encode(data: data, ecCodewords: 10)
        #expect(ec.count == 10)
    }

    @Test("Generator polynomial degree")
    func generatorPolynomialDegree() {
        let gen10 = ReedSolomon.generatorPolynomial(degree: 10)
        #expect(gen10.degree == 10)

        let gen20 = ReedSolomon.generatorPolynomial(degree: 20)
        #expect(gen20.degree == 20)
    }
}

@Suite("Format Info Tests")
struct FormatInfoTests {
    @Test("Format info encoding for M/0")
    func formatInfoM0() {
        // EC level M (00) with mask 0 (000) should produce known value
        let encoded = FormatInfo.encode(errorCorrection: .medium, mask: .pattern0)
        // After XOR with 0x5412, M/0 should be 0x5412 (since data is 0)
        #expect(encoded == 0x5412)
    }

    @Test("Format info encoding for M/1")
    func formatInfoM1() {
        let encoded = FormatInfo.encode(errorCorrection: .medium, mask: .pattern1)
        // M (00) + mask 1 (001) = 0b00001, after BCH and XOR
        #expect(encoded == 0x5125)
    }
}

@Suite("Encoding Mode Tests")
struct EncodingModeTests {
    @Test("Numeric mode validation")
    func numericValidation() {
        #expect(QREncodingMode.numeric.isValid(for: "0123456789"))
        #expect(!QREncodingMode.numeric.isValid(for: "123ABC"))
        #expect(!QREncodingMode.numeric.isValid(for: "12.34"))
    }

    @Test("Alphanumeric mode validation")
    func alphanumericValidation() {
        #expect(QREncodingMode.alphanumeric.isValid(for: "HELLO WORLD"))
        #expect(QREncodingMode.alphanumeric.isValid(for: "ABC123"))
        #expect(QREncodingMode.alphanumeric.isValid(for: "HTTP://TEST"))
        #expect(!QREncodingMode.alphanumeric.isValid(for: "hello"))
    }

    @Test("Byte mode accepts all")
    func byteAcceptsAll() {
        #expect(QREncodingMode.byte.isValid(for: "Hello, World!"))
        #expect(QREncodingMode.byte.isValid(for: "日本語"))
        #expect(QREncodingMode.byte.isValid(for: ""))
    }

    @Test("Character count bits by version")
    func characterCountBits() {
        // Numeric: 10 bits for v1-9, 12 for v10-26, 14 for v27-40
        #expect(QREncodingMode.numeric.characterCountBits(version: 1) == 10)
        #expect(QREncodingMode.numeric.characterCountBits(version: 9) == 10)
        #expect(QREncodingMode.numeric.characterCountBits(version: 10) == 12)
        #expect(QREncodingMode.numeric.characterCountBits(version: 26) == 12)
        #expect(QREncodingMode.numeric.characterCountBits(version: 27) == 14)

        // Alphanumeric: 9, 11, 13
        #expect(QREncodingMode.alphanumeric.characterCountBits(version: 1) == 9)
        #expect(QREncodingMode.alphanumeric.characterCountBits(version: 10) == 11)
        #expect(QREncodingMode.alphanumeric.characterCountBits(version: 27) == 13)

        // Byte: 8, 16, 16
        #expect(QREncodingMode.byte.characterCountBits(version: 1) == 8)
        #expect(QREncodingMode.byte.characterCountBits(version: 10) == 16)
    }
}

@Suite("QR Code Size Tests")
struct QRCodeSizeTests {
    @Test("Higher EC level produces larger QR for same data")
    func ecLevelAffectsSize() throws {
        let text = "This is a test message for QR code generation"

        let qrL = try QRCode.encode(text, errorCorrection: .low)
        let qrH = try QRCode.encode(text, errorCorrection: .high)

        // High EC should require same or higher version
        #expect(qrH.version.number >= qrL.version.number)
    }

    @Test("Longer text produces larger QR")
    func longerTextLargerQR() throws {
        let short = try QRCode.encode("Hi", errorCorrection: .low)
        let long = try QRCode.encode("This is a much longer message that will require more space", errorCorrection: .low)

        #expect(long.version.number >= short.version.number)
    }

    @Test("Numeric mode more efficient than byte")
    func numericMoreEfficient() throws {
        let numbers = "12345678901234567890123456789012345678901234567890"

        let qrNumeric = try QRCode.encode(numbers, mode: .numeric, errorCorrection: .low)
        let qrByte = try QRCode.encode(numbers, mode: .byte, errorCorrection: .low)

        // Numeric should use smaller or equal version
        #expect(qrNumeric.version.number <= qrByte.version.number)
    }
}

@Suite("Edge Case Tests")
struct EdgeCaseTests {
    @Test("Single character")
    func singleCharacter() throws {
        let qr = try QRCode.encode("A")
        #expect(qr.version.number == 1)
    }

    @Test("Maximum numeric for version 1")
    func maxNumericV1() throws {
        // Version 1-L numeric capacity is 41 characters
        let qr = try QRCode.encode("12345678901234567890123456789012345678901", mode: .numeric, errorCorrection: .low)
        #expect(qr.version.number == 1)
    }

    @Test("URL encoding")
    func urlEncoding() throws {
        let urls = [
            "https://google.com",
            "https://example.com/path?query=value",
            "http://test.org"
        ]

        for url in urls {
            let qr = try QRCode.encode(url)
            #expect(qr.size > 0)
        }
    }

    @Test("Special characters in byte mode")
    func specialCharacters() throws {
        let special = "Hello! @#$%^&*()_+-=[]{}|;':\",./<>?"
        let qr = try QRCode.encode(special)
        #expect(qr.size > 0)
    }
}
