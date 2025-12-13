internal enum MaskPattern: Int, CaseIterable, Sendable {
    case pattern0 = 0
    case pattern1 = 1
    case pattern2 = 2
    case pattern3 = 3
    case pattern4 = 4
    case pattern5 = 5
    case pattern6 = 6
    case pattern7 = 7

    func shouldInvert(x: Int, y: Int) -> Bool {
        switch self {
        case .pattern0:
            return (x + y) % 2 == 0
        case .pattern1:
            return y % 2 == 0
        case .pattern2:
            return x % 3 == 0
        case .pattern3:
            return (x + y) % 3 == 0
        case .pattern4:
            return (y / 2 + x / 3) % 2 == 0
        case .pattern5:
            return (x * y) % 2 + (x * y) % 3 == 0
        case .pattern6:
            return ((x * y) % 2 + (x * y) % 3) % 2 == 0
        case .pattern7:
            return ((x + y) % 2 + (x * y) % 3) % 2 == 0
        }
    }

    func apply(to matrix: inout QRMatrix) {
        for y in 0..<matrix.size {
            for x in 0..<matrix.size {
                if !matrix.isReserved(x: x, y: y) && shouldInvert(x: x, y: y) {
                    matrix[x, y].toggle()
                }
            }
        }
    }

    var formatBits: UInt8 {
        return UInt8(rawValue)
    }
}
