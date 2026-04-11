enum BaseError: Error {
    case invalidInputBase
    case invalidOutputBase
    case negativeDigit
    case invalidPositiveDigit
}

struct Base {
    static func outputDigits(inputBase: Int, inputDigits: [Int], outputBase: Int) throws -> [Int] {
        guard inputBase >= 2 else { throw BaseError.invalidInputBase }
        guard outputBase >= 2 else { throw BaseError.invalidOutputBase }
        for digit in inputDigits {
            if digit < 0 { throw BaseError.negativeDigit }
            if digit >= inputBase { throw BaseError.invalidPositiveDigit }
        }

        var n = inputDigits.reduce(0) { $0 * inputBase + $1 }
        if n == 0 { return [0] }
        var result: [Int] = []
        while n > 0 { result.insert(n % outputBase, at: 0); n /= outputBase }
      
        return result
    }
}

