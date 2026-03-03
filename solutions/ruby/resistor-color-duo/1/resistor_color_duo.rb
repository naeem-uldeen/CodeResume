module ResistorColor

  def self.colors
    %w[black brown red orange yellow green blue violet grey white]
  end

  COLORS = colors

  BAND = {
    black:  0,
    brown:  1,
    red:    2,
    orange: 3,
    yellow: 4,
    green:  5,
    blue:   6,
    violet: 7,
    grey:   8,
    white:  9
  }

  def self.color_code(color)
    BAND[color.to_sym]
  end

end

#require_relative 'resistor_color'

module ResistorColorDuo

  def self.value(colors)
    digits = colors.first(2).map { |color|
      ResistorColor::BAND[color.to_sym]
    }

    digits.first * 10 + digits.last
  end

end
