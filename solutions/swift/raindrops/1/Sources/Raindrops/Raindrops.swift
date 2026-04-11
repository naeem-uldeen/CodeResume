let divisors = [3, 5, 7]
let sounds = ["Pling", "Plang", "Plong"]
let drops = zip(divisors, sounds)

func raindrops(_ number: Int) -> String {
    let result = drops.reduce(into: "") { result, pair in
        let (divisor, sound) = pair
        if number.isMultiple(of: divisor) {
            result += sound
        }
    }
    return result.isEmpty ? String(number) : result
}
