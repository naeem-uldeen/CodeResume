class TwoFer
  
  private DEFAULT_NAME     = "you"
  private DEFAULT_TEMPLATE = "One for %<name>s, one for me."

  def self.two_fer(name : String = DEFAULT_NAME) : String
    new(name, DEFAULT_TEMPLATE).to_s
  end

  private property name : String
  private property template : String

  private def initialize(name : String, template : String = DEFAULT_TEMPLATE)
    @name = name
    @template = template
  end

  def to_s(io : IO) : Nil
    io << (template % {name: name})
  end
  
end
