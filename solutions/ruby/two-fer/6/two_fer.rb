class TwoFer

  DEFAULT_NAME = 'you'
  DEFAULT_TEMPLATE = 'One for %<name>s, one for me.'
  private_constant :DEFAULT_NAME, :DEFAULT_TEMPLATE

  def self.two_fer(name = DEFAULT_NAME)
    new(name, DEFAULT_TEMPLATE).to_s
  end

  private

  attr_accessor :name, :template

  def initialize(name, template = DEFAULT_TEMPLATE)
    self.name = name
    self.template = template
  end

  public

  def to_s
    format(template, name: name)
  end

end

if $PROGRAM_NAME == __FILE__
  my_two_fer = TwoFer.two_fer('Bob')
  puts my_two_fer
  puts my_two_fer.to_s
end
