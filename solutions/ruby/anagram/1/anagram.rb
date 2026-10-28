class Anagram

  private

  attr_accessor :subject

  def initialize(subject)
    self.subject = subject.downcase
  end

  def anagram?(word, subject)
    word = word.downcase
    word != subject and word.chars.sort == subject.chars.sort
  end

  public

  def match(candidates)
    candidates.each_with_object(Array.new) do |word, matches|
      matches << word if anagram?(word, subject)
    end
  end

end
