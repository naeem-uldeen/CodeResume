module AtbashCipher
  extend self

  private ALPHABET = "abcdefghijklmnopqrstuvwxyz"
  private REVERSED = "zyxwvutsrqponmlkjihgfedcba"

  def self.encode(message : String) : String
    message
      .downcase
      .tr(ALPHABET, REVERSED)
      .chars
      .select { |c| c.ascii_lowercase? || c.ascii_number? }
      .join
      .chars
      .each_slice(5)
      .map(&.join)
      .join(" ")
  end

  def self.decode(message : String) : String
    message
      .gsub(" ", "")
      .tr(REVERSED, ALPHABET)
  end

end
