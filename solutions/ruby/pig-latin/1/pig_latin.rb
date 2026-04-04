class PigLatin

  VOWELS = %w[a e i o u]
  UNUSUAL_VOWEL_PAIRS = %w[xr yt]
  AY = 'ay'
  private_constant :VOWELS, :UNUSUAL_VOWEL_PAIRS, :AY

  def self.leading_consonant_cluster(word)
    cluster = ''
    word.chars.each_with_index do |character, i|
      break if VOWELS.include?(character)
      break if character == 'y' && i > 0
      cluster += character
      if character == 'q' && word[i + 1] == VOWELS.last
        cluster += VOWELS.last
        break
      end
    end

    cluster
  end

  def self.translate_word(word)
    return word + AY if VOWELS.include?(word[0])
    return word + AY if UNUSUAL_VOWEL_PAIRS.any? { |pair| word.start_with?(pair) }

    cluster = leading_consonant_cluster(word)
    core = word[cluster.length..]
    core + cluster + AY
  end
  private_class_method :leading_consonant_cluster, :translate_word

  public

  def self.translate(words)
    words.split(' ').map { |word| translate_word(word) }.join(' ')
  end

end
