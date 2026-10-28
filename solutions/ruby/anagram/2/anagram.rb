class Anagram

  private

  attr_accessor :subject, :original

  def initialize(subject)
    self.original = subject.downcase
    self.subject  = original.chars.sort
  end

  def anagram?(word)
    word = word.downcase
    word != original && word.chars.sort == subject
  end

  public

  def match(candidates)
    candidates.each_with_object(Array.new) do |word, matches|
      matches << word if anagram?(word)
    end
  end

end
