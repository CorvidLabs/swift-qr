internal enum AlphanumericEncoder {
    private static let characterMap: [Character: Int] = {
        var map: [Character: Int] = [:]
        for i in 0...9 {
            map[Character("\(i)")] = i
        }
        for (i, char) in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".enumerated() {
            map[char] = 10 + i
        }
        map[" "] = 36
        map["$"] = 37
        map["%"] = 38
        map["*"] = 39
        map["+"] = 40
        map["-"] = 41
        map["."] = 42
        map["/"] = 43
        map[":"] = 44
        return map
    }()

    static func characterValue(_ char: Character) -> Int? {
        return characterMap[char]
    }

    static func characterValueUppercased(_ char: Character) -> Int? {
        return characterMap[char.uppercased().first ?? char]
    }

    static func encode(_ text: String, into buffer: inout BitBuffer) throws {
        let chars = Array(text.uppercased())

        var index = 0
        while index < chars.count {
            let remaining = chars.count - index

            if remaining >= 2 {
                guard let v1 = characterValueUppercased(chars[index]),
                      let v2 = characterValueUppercased(chars[index + 1]) else {
                    let invalidChar = characterValueUppercased(chars[index]) == nil ? chars[index] : chars[index + 1]
                    throw QRError.invalidCharacter(invalidChar, mode: .alphanumeric)
                }
                let value = v1 * 45 + v2
                buffer.append(UInt32(value), count: 11)
                index += 2
            } else {
                guard let v1 = characterValueUppercased(chars[index]) else {
                    throw QRError.invalidCharacter(chars[index], mode: .alphanumeric)
                }
                buffer.append(UInt32(v1), count: 6)
                index += 1
            }
        }
    }

    static func isValid(_ text: String) -> Bool {
        return text.allSatisfy { characterValue($0) != nil }
    }
}
