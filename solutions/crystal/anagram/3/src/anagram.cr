module Anagram
  def self.anagram?(word : String, subject : String) : Bool
    normalized_word = word.downcase
    normalized_subject = subject.downcase

    normalized_word != normalized_subject &&
      normalized_word.chars.sort! == normalized_subject.chars.sort!
  end

  def self.find(subject : String, candidates : Array(String)) : Array(String)
    candidates.select { |word| anagram?(word, subject) }
  end
end
