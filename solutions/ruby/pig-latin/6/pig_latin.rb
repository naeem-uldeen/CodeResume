class PigLatin

  def self.translate words
    words
      .split
      .map { |word| PigWord.from word }
      .join ' '
  end

end

class PigWord

  VOWELS              = %w[a e i o u]
  CONSONANTS = ('a'..'z').to_a - VOWELS
  UNUSUAL_PAIRS = %w[xr yt]
  AY                  = 'ay'

  private_constant :VOWELS, :UNUSUAL_PAIRS, :AY

  def initialize word
    @word = word
  end

  def self.from word
    if VOWELS.include? word.chr
      VowelWord.new word
    elsif UNUSUAL_PAIRS.any? { |pair| word.start_with? pair }
      UnusualPairWord.new word
    else
      ConsonantWord.from word
    end
  end

  attr_reader :word
  private :word
end

class VowelWord < PigWord

  def to_s
    word << AY
  end

end

class UnusualPairWord < PigWord

  def to_s
    word << AY
  end

end

class ConsonantWord < PigWord

  def self.from word
    leading_consonants = word.chars.reject { |letter| VOWELS.include? letter }
    q_index = leading_consonants.index 'q'

    if q_index and word[q_index.next] == 'u'
      QuClusterWord.new word
    elsif word.chars.drop(1).include? 'y'
      YVowelWord.new word
    else
      SimpleConsonantWord.new word
    end
  end

  def to_s
    core << cluster << AY
  end

  private

  def core
    word[cluster.length..]
  end

end

class SimpleConsonantWord < ConsonantWord

  def cluster
    cluster ||= word.chars.each_with_object '' do |letter, pig_word|
      break pig_word unless CONSONANTS.include? letter
      pig_word << letter
    end
  end

end

class YVowelWord < ConsonantWord

  CONSONANTS_WITHOUT_Y = CONSONANTS - ['y']

  def cluster
    cluster ||= word.chars.each_with_object '' do |letter, pig_word|
      break pig_word unless CONSONANTS_WITHOUT_Y.include? letter
      pig_word << letter
    end
  end

end

class QuClusterWord < ConsonantWord

  def cluster
    cluster ||= begin
      pig_word = ''
      word.chars.each do |letter|
        pig_word += letter
        break if pig_word.end_with? 'qu'
      end
      pig_word
    end
  end

end
