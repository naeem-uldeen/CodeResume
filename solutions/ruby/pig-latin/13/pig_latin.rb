module PigLatin

  def self.translate words
    words
      .split
      .map { |word| PigWord.from word }
      .join ' '
  end

end

module PigWord

  VOWELS        = %w[a e i o u]
  CONSONANTS    = ('a'..'z').to_a - VOWELS
  UNUSUAL_PAIRS = %w[xr yt]
  AY            = 'ay'
  private_constant :VOWELS, :CONSONANTS, :UNUSUAL_PAIRS, :AY

  def self.from word
    case word
    when Vowel       then Vowel.new word: word
    when UnusualPair then UnusualPair.new word: word
    else Consonant.from word
    end
  end

  Vowel = Data.define :word do
    def self(word) = VOWELS.include? word.chr
    def to_s()= word + AY
  end

  UnusualPair = Data.define :word do
    def self.===(word) = UNUSUAL_PAIRS.any? { |pair|
      word.start_with? pair
    }
    def to_s()= word + AY
  end

  module ConsonantCluster

    private

    def core()= word[cluster.length..]

    public

    def to_s()= core << cluster << AY

  end

  module Consonant

    def self.from word
      case word
      when QuCluster then QuCluster.from word
      when YVowel    then YVowel.from word
      else Simple.from word
      end
    end

  end

  Simple = Data.define :word, :cluster do
    include ConsonantCluster

    def self.from word
      cluster = word.chars.each_with_object '' do |letter, pig_word|
        break pig_word unless CONSONANTS.include? letter
        pig_word << letter
      end
      new word: word, cluster: cluster
    end
  end

  YVowel = Data.define :word, :cluster do
    include ConsonantCluster

    CONSONANTS_WITHOUT_Y = CONSONANTS - ['y']

    def self.===(word) = word.chars.drop(1).include? 'y'

    def self.from word
      cluster = word.chars.each_with_object '' do |letter, pig_word|
        break pig_word unless CONSONANTS_WITHOUT_Y.include? letter
        pig_word << letter
      end
      new word: word, cluster: cluster
    end
  end

  QuCluster = Data.define :word, :cluster do
    include ConsonantCluster

    def self.===(word)
      letters = word.chars
      leading = letters.take_while { |letter| CONSONANTS.include? letter }
      q_index = leading.index('q')
      q_index && letters[q_index.next] == 'u'
    end

    def self.from word
      cluster = word.chars.each_with_object '' do |letter, pig_word|
        pig_word << letter
        break pig_word if pig_word.end_with? 'qu'
      end
      new word: word, cluster: cluster
    end
  end

end
