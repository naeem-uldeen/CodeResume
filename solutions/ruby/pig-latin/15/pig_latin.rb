module PigLatin

  VOWEL_SOUND                = /\A([aeiou]|xr|yt)/
  CONSONANT_CLUSTER_WITH_QU  = /\A([^aeiou]*qu)(.*)/
  CONSONANT_CLUSTER_BEFORE_Y = /\A([^aeiouy]+)(y.*)/
  CONSONANT_CLUSTER          = /\A([^aeiou]+)(.*)/

  def self.translate(words)
    words.split.map { |word| translate_word(word) }.join ' '
  end

  def self.translate_word(word)
    case word
    when VOWEL_SOUND then "#{word}ay"
    when CONSONANT_CLUSTER_WITH_QU then "#{$2}#{$1}ay"
    when CONSONANT_CLUSTER_BEFORE_Y then "#{$2}#{$1}ay"
    when CONSONANT_CLUSTER then "#{$2}#{$1}ay"
    else word
    end
  end
  private_class_method :translate_word

end
