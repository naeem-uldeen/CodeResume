class PigLatin {

    static func translate(_ word: String) -> String {
        let words = word.split(separator: " ").map { String($0) }
        if words.count > 1 {
            return words.map { translateWord($0) }.joined(separator: " ")
        }
        return translateWord(word)
    }

    private static func leadingConsonantCluster(_ word: String) -> String {
        let vowels: [Character] = ["a", "e", "i", "o", "u"]
        var cluster = ""
        for (i, character) in word.enumerated() {
            if vowels.contains(character) { break }
            if character == "y" && i > 0 { break }
            cluster.append(character)
            if character == "q" && word.dropFirst(i + 1).first == "u" {
                cluster.append("u")
                break
            }
        }
        return cluster
    }

    private static func translateWord(_ word: String) -> String {
        let vowels: [Character] = ["a", "e", "i", "o", "u"]
        let startsWithVowelPair = ["xr", "yt"]

        if let first = word.first, vowels.contains(first) {
            return word + "ay"
        }

        for pair in startsWithVowelPair {
            if word.hasPrefix(pair) {
                return word + "ay"
            }
        }

        let leadingCluster = leadingConsonantCluster(word)
        let core = String(word.dropFirst(leadingCluster.count))
        return core + leadingCluster + "ay"
    }
}
