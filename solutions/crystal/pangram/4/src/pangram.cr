class Pangram

  private ALPHABET = ('a'..'z')

  def self.pangram?(text : String) : Bool
    new(text).pangram?
  end

  private getter :text

  private def initialize(text : String)
    @text = text.downcase
  end

  def pangram?
    ALPHABET.all? { |letter| text.includes?(letter) }
  end

end
