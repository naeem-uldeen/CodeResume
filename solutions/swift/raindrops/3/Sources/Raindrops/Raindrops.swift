private let raindropRules = [(3, "Pling"), (5, "Plang"), (7, "Plong")]

func raindrops(_ number: Int) -> String {
    let result = raindropRules
        .compactMap { number.isMultiple(of: $0) ? $1 : nil }
        .joined()

    return result.isEmpty ? String(number) : result
}
