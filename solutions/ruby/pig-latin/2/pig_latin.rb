class PigLatin

  def self.translate(words)
    words
      .split(' ')
      .map { |word| PigWord.from(word) }
      .join(' ')
  end

end

class PigWord

  VOWELS = %w[a e i o u]
  UNUSUAL_VOWEL_PAIRS = %w[xr yt]
  AY = 'ay'
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
      ConsonantWord.new(word)
    end
  end

  attr_reader :word
  private :word
end

# "apple" → "appleay"
class VowelWord < PigWord
  def to_s
    word + AY
  end
end

class UnusualPairWord < PigWord
  def to_s
    word + AY
  end
end

class ConsonantWord < PigWord
  def to_s
    core + cluster + AY
  end

  private

  def cluster
    @cluster ||= begin
      result = ''
      word.chars.each_with_index do |char, i|
        break if VOWELS.include?(char)
        break if char == 'y' && i > 0
        result += char
        if char == 'q' && word[i + 1] == VOWELS.last
          result += VOWELS.last
          break
        end
      end
      result
    end
  end

  def core
    word[cluster.length..]
  end

end
