internal struct BitBuffer: Sendable {
    private(set) var bytes: [UInt8] = []
    private(set) var bitCount: Int = 0

    init() {}

    mutating func append(_ value: UInt32, count: Int) {
        for i in stride(from: count - 1, through: 0, by: -1) {
            append((value >> i) & 1 == 1)
        }
    }

    mutating func append(_ bit: Bool) {
        let byteIndex = bitCount / 8
        let bitIndex = 7 - (bitCount % 8)

        if byteIndex >= bytes.count {
            bytes.append(0)
        }

        if bit {
            bytes[byteIndex] |= (1 << bitIndex)
        }

        bitCount += 1
    }

    mutating func append(contentsOf other: BitBuffer) {
        for i in 0..<other.bitCount {
            let byteIndex = i / 8
            let bitIndex = 7 - (i % 8)
            let bit = (other.bytes[byteIndex] >> bitIndex) & 1 == 1
            append(bit)
        }
    }

    mutating func appendByte(_ byte: UInt8) {
        append(UInt32(byte), count: 8)
    }

    func getBit(at index: Int) -> Bool {
        guard index < bitCount else { return false }
        let byteIndex = index / 8
        let bitIndex = 7 - (index % 8)
        return (bytes[byteIndex] >> bitIndex) & 1 == 1
    }

    func toBytes() -> [UInt8] {
        return bytes
    }

    var byteCount: Int {
        return (bitCount + 7) / 8
    }
}
