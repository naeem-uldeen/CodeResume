class PigLatin
  def self.translate(words)
    words
      .split(' ')
      .map { |word| PigWord.from(word) }
      .join(' ')
  end
end

class PigWord
  VOWELS              = %w[a e i o u]
  UNUSUAL_VOWEL_PAIRS = %w[xr yt]
  AY                  = 'ay'
  private_constant :VOWELS, :UNUSUAL_VOWEL_PAIRS, :AY

  def initialize(word)
    @word = word
  end

  def self.from(word)
    if VOWELS.include?(word[0])
      VowelWord.new(word)
    elsif UNUSUAL_VOWEL_PAIRS.any? { |pair| word.start_with?(pair) }
      UnusualPairWord.new(word)
    else
      ConsonantWord.from(word)
    end
  end

  attr_reader :word
  private :word
end

# Rule 1 — "apple" → "appleay"
class VowelWord < PigWord
  def to_s
    word + AY
  end
end

# Rule 1 — "xray" → "xrayay"
class UnusualPairWord < PigWord
  def to_s
    word + AY
  end
end

# Shared shape for all consonant-cluster cases
class ConsonantWord < PigWord
  def self.from(word)
    leading_consonants = word.chars.take_while { |char| !VOWELS.include?(char) }
    q_index = leading_consonants.index('q')

    if q_index && word[q_index + 1] == 'u'
      QuClusterWord.new(word)       # Rule 4 — "queen", "square"
    elsif word.chars.drop(1).include?('y')
      YVowelWord.new(word)          # Rule 3 — "rhythm", "my"
    else
      SimpleConsonantWord.new(word) # Rule 2 — "pig", "qat"
    end
  end

  def to_s
    core + cluster + AY
  end

  private

  def core
    word[cluster.length..]
  end
end

# Rule 2 — "pig" → "igpay", "glove" → "oveglay"
class SimpleConsonantWord < ConsonantWord
  private

  def cluster
    @cluster ||= word.chars.take_while { |char| !VOWELS.include?(char) }.join
  end
end

# Rule 3 — "rhythm" → "ythmrhay", "my" → "ymay"
class YVowelWord < ConsonantWord
  private

  def cluster
    @cluster ||= word.chars.take_while { |char| !VOWELS.include?(char) && char != 'y' }.join
  end
end

# Rule 4 — "queen" → "eenquay", "square" → "aresquay"
class QuClusterWord < ConsonantWord
  private

  def cluster
    @cluster ||= begin
      result = ''
      word.chars.each do |char|
        result += char
        break if result.end_with?('qu')
      end
      result
    end
  end
end