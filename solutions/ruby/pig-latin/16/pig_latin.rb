module PigLatin
  # Matches words beginning with a vowel sound:
  # - \A       = start of string anchor
  # - [aeiou]  = any single vowel (a, e, i, o, u)
  # - xr|yt    = OR the special clusters "xr" and "yt" (treated as vowel sounds)
  # Examples: "apple", "xray", "yttria"
  VOWEL_SOUND                = /\A([aeiou]|xr|yt)/

  # Matches consonant clusters ending in "qu":
  # - \A           = start of string
  # - [^aeiou]*qu  = zero or more non-vowels followed by "qu" (capture group 1)
  # - .*           = the remainder of the word (capture group 2)
  # Examples: "square" → $1="squ", $2="are" → "aresquay"
  #           "quit"   → $1="qu",  $2="it"  → "itquay"
  CONSONANT_CLUSTER_WITH_QU  = /\A([^aeiou]*qu)(.*)/

  # Matches consonant clusters where 'y' acts as the first vowel sound:
  # - \A         = start of string
  # - [^aeiouy]+ = one or more non-vowels AND non-y characters (capture group 1)
  # - y.*        = 'y' plus the rest of the word (capture group 2)
  # Examples: "rhythm" → $1="rh", $2="ythm" → "ythmrhay"
  #           "my"     → $1="m",  $2="y"    → "ymay"
  CONSONANT_CLUSTER_BEFORE_Y = /\A([^aeiouy]+)(y.*)/

  # Matches a standard leading consonant cluster:
  # - \A         = start of string
  # - [^aeiou]+  = one or more non-vowel characters (capture group 1)
  # - .*         = the remainder of the word (capture group 2)
  # Examples: "chair"  → $1="ch", $2="air" → "airchay"
  #           "strength" → $1="str", $2="ength" → "engthstray"
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
