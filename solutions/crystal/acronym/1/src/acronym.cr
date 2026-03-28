module Acronym

  def self.abbreviate(phrase : String) : String
    String.build do |acronym|
      # Regex matches one or more whitespace,
      # hyphen, or underscore characters
      phrase.split(/[\s\-_]+/).each { |word|
        first_letter = word.chars.find(&.ascii_letter?)
        acronym << first_letter.upcase if first_letter
      }
    end
  end

end
