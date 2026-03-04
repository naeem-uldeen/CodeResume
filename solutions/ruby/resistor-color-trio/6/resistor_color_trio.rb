require_relative 'resistor_color'
require_relative 'resistor_color_duo'
require_relative 'label_maker'

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
