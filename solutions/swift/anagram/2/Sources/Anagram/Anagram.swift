class Anagram {
  
    let lowercasedWord: String
    let sortedWord: [Character]

    init(word: String) {
        self.lowercasedWord = word.lowercased()
        self.sortedWord = lowercasedWord.sorted()
    }

    func match(_ words: [String]) -> [String] {
        words.filter { candidate in
            let lowercasedCandidate = candidate.lowercased()
            return lowercasedCandidate != lowercasedWord
                && lowercasedCandidate.sorted() == sortedWord
        }
    }
}
