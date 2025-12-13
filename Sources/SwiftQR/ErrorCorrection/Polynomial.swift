internal struct Polynomial: Sendable {
    let coefficients: [UInt8]

    init(coefficients: [UInt8]) {
        var trimmed = coefficients
        while trimmed.count > 1 && trimmed.first == 0 {
            trimmed.removeFirst()
        }
        self.coefficients = trimmed
    }

    init(fromMonomial coefficient: UInt8, degree: Int) {
        var coeffs = [UInt8](repeating: 0, count: degree + 1)
        coeffs[0] = coefficient
        self.coefficients = coeffs
    }

    var degree: Int {
        return coefficients.count - 1
    }

    var isZero: Bool {
        return coefficients.allSatisfy { $0 == 0 }
    }

    func coefficient(at degree: Int) -> UInt8 {
        let index = coefficients.count - 1 - degree
        guard index >= 0 && index < coefficients.count else { return 0 }
        return coefficients[index]
    }

    var leadingCoefficient: UInt8 {
        return coefficients.first ?? 0
    }

    func multiply(by other: Polynomial) -> Polynomial {
        if isZero || other.isZero {
            return Polynomial(coefficients: [0])
        }

        var product = [UInt8](repeating: 0, count: coefficients.count + other.coefficients.count - 1)

        for (i, a) in coefficients.enumerated() {
            for (j, b) in other.coefficients.enumerated() {
                product[i + j] ^= GF256.multiply(a, b)
            }
        }

        return Polynomial(coefficients: product)
    }

    func multiply(by scalar: UInt8) -> Polynomial {
        if scalar == 0 {
            return Polynomial(coefficients: [0])
        }

        let result = coefficients.map { GF256.multiply($0, scalar) }
        return Polynomial(coefficients: result)
    }

    func multiplyByMonomial(degree: Int) -> Polynomial {
        if isZero {
            return self
        }
        var result = coefficients
        result.append(contentsOf: [UInt8](repeating: 0, count: degree))
        return Polynomial(coefficients: result)
    }

    func add(_ other: Polynomial) -> Polynomial {
        if isZero {
            return other
        }
        if other.isZero {
            return self
        }

        var smaller = coefficients
        var larger = other.coefficients
        if smaller.count > larger.count {
            swap(&smaller, &larger)
        }

        var result = larger
        let offset = larger.count - smaller.count
        for i in 0..<smaller.count {
            result[offset + i] ^= smaller[i]
        }

        return Polynomial(coefficients: result)
    }

    func divide(by divisor: Polynomial) -> (quotient: Polynomial, remainder: Polynomial) {
        precondition(!divisor.isZero, "Division by zero polynomial")

        if degree < divisor.degree {
            return (Polynomial(coefficients: [0]), self)
        }

        var remainder = coefficients
        let divisorLeadingCoeff = divisor.leadingCoefficient
        let degreeDiff = degree - divisor.degree

        var quotient = [UInt8](repeating: 0, count: degreeDiff + 1)

        for i in 0...degreeDiff {
            let coeff = GF256.divide(remainder[i], divisorLeadingCoeff)
            quotient[i] = coeff

            if coeff != 0 {
                for j in 0..<divisor.coefficients.count {
                    remainder[i + j] ^= GF256.multiply(divisor.coefficients[j], coeff)
                }
            }
        }

        let remainderStart = degreeDiff + 1
        let remainderCoeffs = Array(remainder[remainderStart...])

        return (
            Polynomial(coefficients: quotient),
            Polynomial(coefficients: remainderCoeffs.isEmpty ? [0] : remainderCoeffs)
        )
    }
}
