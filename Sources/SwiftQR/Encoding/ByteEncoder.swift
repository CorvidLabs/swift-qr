import Foundation

internal enum ByteEncoder {
    static func encode(_ text: String, into buffer: inout BitBuffer) throws {
        guard let data = text.data(using: .utf8) else {
            throw QRError.encodingFailed("Failed to encode string as UTF-8")
        }

        for byte in data {
            buffer.appendByte(byte)
        }
    }

    static func encode(data: Data, into buffer: inout BitBuffer) {
        for byte in data {
            buffer.appendByte(byte)
        }
    }

    static func byteCount(_ text: String) -> Int {
        return text.utf8.count
    }
}
