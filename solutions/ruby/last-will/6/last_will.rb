module Zhang

  def self.bank_number_part(secret_modifier)
    zhang_part = 8_541
    zhang_part * secret_modifier % 10_000
  end

  module Red  def self.code_fragment = 512 end

  module Blue def self.code_fragment = 677 end

end

module Khan

  def self.bank_number_part(secret_modifier)
    khan_part = 4_142
    khan_part * secret_modifier % 10_000
  end

  module Red  def self.code_fragment = 148 end

  module Blue def self.code_fragment = 875 end

end

module Garcia

  def self.bank_number_part(secret_modifier)
    garcia_part = 4_023
    garcia_part * secret_modifier % 10_000
  end

  module Red def self.code_fragment  = 118 end

  module Blue def self.code_fragment = 923 end

end

module EstateExecutor
  extend self

  FAMILIES = Zhang, Khan, Garcia
  RED  = FAMILIES.sum { |family| family::Red.code_fragment  }
  BLUE = FAMILIES.sum { |family| family::Blue.code_fragment }
  private_constant :FAMILIES, :RED, :BLUE

  def assemble_account_number(secret_modifier)
    FAMILIES.sum { |family| family.bank_number_part(secret_modifier) }
  end

  def assemble_code = RED * BLUE

end
