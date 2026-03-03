module Acronym

  def self.abbreviate(expansion)
    expansion
      .then(&method(:replace_hyphens))
      .then(&method(:upcase_string))
      .then(&method(:remove_punctuation))
      .then(&method(:split_words))
      .then(&method(:extract_first_letters))
      .join
  end

  private

  def self.replace_hyphens(text) = text.tr("-", ' ')
  def self.upcase_string(text) = text.upcase
  def self.remove_punctuation(text) = text.gsub(/[[:punct:]]/, '')
  def self.split_words(text) = text.split
  def self.extract_first_letters(words) = words.map(&:chr)

end
