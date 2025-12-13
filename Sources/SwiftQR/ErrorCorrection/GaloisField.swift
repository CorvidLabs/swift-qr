internal enum GF256 {
    static let primitive: UInt16 = 0x11D

    static let expTable: [UInt8] = {
        var exp = [UInt8](repeating: 0, count: 512)
        var x: UInt16 = 1
        for i in 0..<255 {
            exp[i] = UInt8(x)
            x <<= 1
            if x >= 256 {
                x ^= primitive
            }
        }
        for i in 255..<512 {
            exp[i] = exp[i - 255]
        }
        return exp
    }()

    static let logTable: [UInt8] = {
        var log = [UInt8](repeating: 0, count: 256)
        for i in 0..<255 {
            log[Int(expTable[i])] = UInt8(i)
        }
        return log
    }()

    static func multiply(_ a: UInt8, _ b: UInt8) -> UInt8 {
        if a == 0 || b == 0 {
            return 0
        }
        let logSum = Int(logTable[Int(a)]) + Int(logTable[Int(b)])
        return expTable[logSum]
    }

    static func divide(_ a: UInt8, _ b: UInt8) -> UInt8 {
        precondition(b != 0, "Division by zero in GF(256)")
        if a == 0 {
            return 0
        }
        var logDiff = Int(logTable[Int(a)]) - Int(logTable[Int(b)])
        if logDiff < 0 {
            logDiff += 255
        }
        return expTable[logDiff]
    }

    static func power(_ base: UInt8, _ exponent: Int) -> UInt8 {
        if exponent == 0 {
            return 1
        }
        if base == 0 {
            return 0
        }
        let logResult = (Int(logTable[Int(base)]) * exponent) % 255
        return expTable[logResult]
    }

    static func exp(_ power: Int) -> UInt8 {
        return expTable[power % 255]
    }
}
