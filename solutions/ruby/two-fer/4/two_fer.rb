class TwoFer

  def self.two_fer name = 'you'
    new(name).to_s
  end

  attr_reader :name

  def initialize name
    @name = name
  end

  def to_s
    'One for %<name>s, one for me.' % {name:}
  end

end
