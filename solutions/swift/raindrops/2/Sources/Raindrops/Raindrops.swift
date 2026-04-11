func raindrops(_ number: Int) -> String {
    let result = zip([3, 5, 7], ["Pling", "Plang", "Plong"])
        .compactMap { number.isMultiple(of: $0) ? $1 : nil }
        .joined()
  
    return result.isEmpty ? String(number) : result
}
