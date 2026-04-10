class Anagram {

    let wordToMatch: String

    init(word: String) {
        self.wordToMatch = word
    }

    func match(_ words: [String]) -> [String] {
        var matches: [String] = []
        for candidate in words {
            if notTheSameWord(wordA: candidate, wordB: wordToMatch) &&
               haveSameLengths(wordA: candidate, wordB: wordToMatch) &&
               sortedLettersEqual(wordA: candidate, wordB: wordToMatch){
               matches.append(candidate)
            }
        }
        return matches
    }

    private func haveSameLengths(wordA: String, wordB: String) -> Bool {
      wordA.count == wordB.count
    }

    private func sortedLettersEqual(wordA: String, wordB: String) -> Bool {
      wordA.lowercased().sorted() == wordB.lowercased().sorted()
    }

    private func notTheSameWord(wordA: String, wordB: String) -> Bool {
      wordA.lowercased() != wordB.lowercased()
    }
}
