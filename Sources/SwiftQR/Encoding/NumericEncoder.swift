internal enum NumericEncoder {
    static func encode(_ text: String, into buffer: inout BitBuffer) throws {
        let digits = Array(text)

        var index = 0
        while index < digits.count {
            let remaining = digits.count - index

            if remaining >= 3 {
                let d1 = try digitValue(digits[index])
                let d2 = try digitValue(digits[index + 1])
                let d3 = try digitValue(digits[index + 2])
                let value = d1 * 100 + d2 * 10 + d3
                buffer.append(UInt32(value), count: 10)
                index += 3
            } else if remaining == 2 {
                let d1 = try digitValue(digits[index])
                let d2 = try digitValue(digits[index + 1])
                let value = d1 * 10 + d2
                buffer.append(UInt32(value), count: 7)
                index += 2
            } else {
                let d1 = try digitValue(digits[index])
                buffer.append(UInt32(d1), count: 4)
                index += 1
            }
        }
    }

    private static func digitValue(_ char: Character) throws -> Int {
        guard let value = char.wholeNumberValue, value >= 0 && value <= 9 else {
            throw QRError.invalidCharacter(char, mode: .numeric)
        }
        return value
    }

    static func isValid(_ text: String) -> Bool {
        return text.allSatisfy { $0.isNumber }
    }
}
