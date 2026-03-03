module Reverser

  def self.reverse text
    text.chars.each_with_object '' do |character, reversed|
      reversed.prepend character
    end
  end

end
