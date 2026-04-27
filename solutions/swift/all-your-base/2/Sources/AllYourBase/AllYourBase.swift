enum BaseError: Error {
    case invalidInputBase
    case invalidOutputBase
    case negativeDigit
    case invalidPositiveDigit
}

struct Base {
    static func outputDigits(inputBase:    Int,
                             inputDigits: [Int],
                             outputBase:   Int) throws -> [Int] {
        guard inputBase  >= 2 else { throw BaseError.invalidInputBase }
        guard outputBase >= 2 else { throw BaseError.invalidOutputBase }

        // Single pass: validate and convert to decimal simultaneously
        var decimalValue = 0
        for digit in inputDigits {
            if digit < 0          { throw BaseError.negativeDigit }
            if digit >= inputBase { throw BaseError.invalidPositiveDigit }
            decimalValue = decimalValue * inputBase + digit
        }

        if decimalValue == 0 { return [0] }
        // O(1) appends + one reverse, instead of O(n²) front-insertions
        var result: [Int] = []
        while decimalValue > 0 {
            result.append(decimalValue % outputBase)
            decimalValue /= outputBase
        }
        return result.reversed()
    }
}
