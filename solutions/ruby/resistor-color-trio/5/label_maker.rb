module LabelMaker

  UNITS = ['ohms', 'kiloohms', 'megaohms', 'gigohms']

  def self.label(value)
    i = 0
    i += 1 and value = value.divmod(1000)[0] while value >= 1000
    '%<value>d %<unit>s' % { value: value, unit: UNITS[i] }
  end

end
