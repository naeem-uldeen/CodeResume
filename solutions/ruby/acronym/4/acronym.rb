module Acronym

  class << self # opens up the singleton class (also called the metaclass or eigenclass)
    def abbreviate(expansion)
      expansion
        .then(&method(:replace_hyphens))
        .then(&method(:upcase_string))
        .then(&method(:remove_punctuation))
        .then(&method(:split_words))
        .then(&method(:extract_first_letters))
        .join
    end

    private # use inside this block, applies to every method defined thereafter

    def replace_hyphens(text)        = text.tr("-", ' ')
    def upcase_string(text)          = text.upcase
    def remove_punctuation(text)     = text.gsub(/[[:punct:]]/, '')
    def split_words(text)            = text.split
    def extract_first_letters(words) = words.map(&:chr)
  end

end
      