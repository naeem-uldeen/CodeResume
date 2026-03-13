module Pangram

  ALPHABET = ('a'..'z')

  def self.pangram?(text : String) : Bool
    ALPHABET.all? { |letter| text.downcase.includes?(letter) }
  end

end
