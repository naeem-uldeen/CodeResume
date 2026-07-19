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

  def self.from word
    if VOWELS.include? word.chr
      Vowel.new word: word
    elsif UNUSUAL_PAIRS.any? { |pair| word.start_with? pair }
      UnusualPair.new word: word
    else
      Consonant.from word
    end
  end

  Vowel = Data.define(:word) do
    def to_s
      word + AY
    end
  end

  UnusualPair = Data.define(:word) do
    def to_s
      word + AY
    end
  end

  module ConsonantCluster

    private

    def core
      word[cluster.length..]
    end

    def to_s
      core + cluster + AY
    end

  end

  module Consonant

    def self.from word
      leading_consonants = word.chars.reject { |letter| VOWELS.include? letter }
      q_index = leading_consonants.index 'q'

      if q_index and word[q_index.next] == 'u'
        QuCluster.from word
      elsif word.chars.drop(1).include? 'y'
        YVowel.from word
      else
        Simple.from word
      end
    end

  end

  Simple = Data.define(:word, :cluster) do
    include ConsonantCluster

    def self.from word
      cluster = word.chars.each_with_object '' do |letter, pig_word|
        break pig_word unless CONSONANTS.include? letter
        pig_word << letter
      end
      new word: word, cluster: cluster
    end
  end

  YVowel = Data.define(:word, :cluster) do
    include ConsonantCluster

    CONSONANTS_WITHOUT_Y = CONSONANTS - ['y']

    def self.from word
      cluster = word.chars.each_with_object '' do |letter, pig_word|
        break pig_word unless CONSONANTS_WITHOUT_Y.include? letter
        pig_word << letter
      end
      new word: word, cluster: cluster
    end
  end

  QuCluster = Data.define(:word, :cluster) do
    include ConsonantCluster

    def self.from word
      cluster = begin
        pig_word = ''
        word.chars.each do |letter|
          pig_word += letter
          break if pig_word.end_with? 'qu'
        end
        pig_word
      end
      new word: word, cluster: cluster
    end
  end

end
