require_relative 'resistor_color'

module ResistorColorDuo

  def self.value(colors)
    digits = colors.first(2).map { |color|
      ResistorColor::BAND[color.to_sym]
    }

    digits.first * 10 + digits.last
  end

end
