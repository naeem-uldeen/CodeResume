class Phrase
  # Regular expression for matching words with optional contractions
  # \b               - Match word boundary
  # [a-z0-9]+        - Match one or more alphanumeric characters(word stem)
  # (?:\'[a-z0-9]+)? - Optional non-capturing group for contractions:
  # \'               - Match an apostrophe
  # [a-z0-9]+        - Match one or more alphanumeric characters(contracted)
  # \b               - Match ending word boundary
  WORD_PATTERN = /\b[a-z0-9]+(?:\'[a-z0-9]+)?\b/
  private_constant :WORD_PATTERN

  private

  attr_accessor :phrase

  def initialize phrase
    self.phrase = phrase
      .downcase
      .scan WORD_PATTERN
  end

  public

  def word_count()= phrase.tally

end
