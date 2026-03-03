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

module ResistorColorDuo

  def self.value(colors)
    digits = colors.first(2).map { |color|
      ResistorColor::BAND[color.to_sym]
    }
    digits.first * 10 + digits.last
  end

end

module LabelMaker

  UNITS = ['ohms', 'kiloohms', 'megaohms', 'gigaohms']

  def self.label(value)
    i = 0
    i += 1 and value /= 1000 while value >= 1000
    '%<value>d %<unit>s' % { value: value, unit: UNITS[i] }
  end

end

class ResistorColorTrio

  private

  attr_accessor :number

  def initialize(colors)
    main_value = ResistorColorDuo.value(colors)
    zeros = ResistorColor::BAND[colors[2].to_sym].to_i
    self.number = main_value * (10 ** zeros)
  end

  public

  def label
    'Resistor value: %<label>s' % { label: LabelMaker.label(number) }
  end

end
