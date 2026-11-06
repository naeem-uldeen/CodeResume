module Anagram
  def self.anagram?(word : String, subject : String) : Bool
    word = word.downcase
    subject = subject.downcase

    word != subject && word.chars.sort == subject.chars.sort
  end

  def self.find(subject : String, candidates : Array(String)) : Array(String)
    candidates.select { |word| anagram?(word, subject) }
  end
end