class Atbash

  KEY = '0123456789zyxwvutsrqponmlkjihgfedcba'
  BASE = KEY.length
  CHUNK_SIZE = /.{1,5}/
  ALPHANUMERIC = /[a-z0-9]/

  class << self
    def encode(text)
      atbash(text).scan(CHUNK_SIZE).join(' ')
    end

    def decode(text)
      atbash(text)
    end

    private

    def atbash(text)
      letters = normalize(text)
      letters.map { |letter| KEY[letter.to_i(BASE)] }.join
    end

    def normalize(text)
      text.downcase.scan(ALPHANUMERIC)
    end
  end

end
