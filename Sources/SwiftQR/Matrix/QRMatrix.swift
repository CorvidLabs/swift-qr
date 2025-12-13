internal struct QRMatrix: Sendable {
    let size: Int
    private var modules: [Bool]
    private var isFunction: [Bool]

    init(size: Int) {
        self.size = size
        self.modules = [Bool](repeating: false, count: size * size)
        self.isFunction = [Bool](repeating: false, count: size * size)
    }

    private func index(x: Int, y: Int) -> Int {
        return y * size + x
    }

    subscript(x: Int, y: Int) -> Bool {
        get {
            guard x >= 0 && x < size && y >= 0 && y < size else { return false }
            return modules[index(x: x, y: y)]
        }
        set {
            guard x >= 0 && x < size && y >= 0 && y < size else { return }
            modules[index(x: x, y: y)] = newValue
        }
    }

    func isReserved(x: Int, y: Int) -> Bool {
        guard x >= 0 && x < size && y >= 0 && y < size else { return true }
        return isFunction[index(x: x, y: y)]
    }

    mutating func setFunction(x: Int, y: Int, isDark: Bool) {
        guard x >= 0 && x < size && y >= 0 && y < size else { return }
        let idx = index(x: x, y: y)
        modules[idx] = isDark
        isFunction[idx] = true
    }

    mutating func reserve(x: Int, y: Int) {
        guard x >= 0 && x < size && y >= 0 && y < size else { return }
        isFunction[index(x: x, y: y)] = true
    }

    func allModules() -> [(x: Int, y: Int, isDark: Bool)] {
        var result: [(x: Int, y: Int, isDark: Bool)] = []
        for y in 0..<size {
            for x in 0..<size {
                result.append((x: x, y: y, isDark: self[x, y]))
            }
        }
        return result
    }

    func copy() -> QRMatrix {
        var copy = QRMatrix(size: size)
        copy.modules = self.modules
        copy.isFunction = self.isFunction
        return copy
    }
}
