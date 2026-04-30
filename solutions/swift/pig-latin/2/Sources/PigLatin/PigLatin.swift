class PigLatin {
    private static let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
    private static let vowelStartPairs = ["xr", "yt"]

    static func translate(_ phrase: String) -> String {
        return phrase.split(separator: " ")
            .map { translateWord(String($0)) }
            .joined(separator: " ")
    }

    private static func leadingConsonantCluster(_ word: String) -> String {
        let characters = Array(word)
        var cluster = ""

        for i in 0..<characters.count {
            let char = characters[i]
            if vowels.contains(char) || (char == "y" && i > 0) { break }

            cluster.append(char)

            if char == "q" && i + 1 < characters.count && characters[i + 1] == "u" {
                cluster.append("u")
                break
            }
        }
        return cluster
    }

    private static func translateWord(_ word: String) -> String {
        if let first = word.first,
           vowels.contains(first) || vowelStartPairs.contains(where: { word.hasPrefix($0) }) {
            return word + "ay"
        }

        let leadingCluster = leadingConsonantCluster(word)

        return word.dropFirst(leadingCluster.count) + leadingCluster + "ay"
    }
}
