class Zhang

  def self.bank_number_part(secret_modifier)
    zhang_part = 8_541
    zhang_part * secret_modifier % 10_000
  end

  class Red  def self.code_fragment = 512 end
  class Blue def self.code_fragment = 677 end

end

class Khan

  def self.bank_number_part(secret_modifier)
    khan_part = 4_142
    khan_part * secret_modifier % 10_000
  end

  class Red  def self.code_fragment = 148 end
  class Blue def self.code_fragment = 875 end

end

class Garcia

  def self.bank_number_part(secret_modifier)
    garcia_part = 4_023
    garcia_part * secret_modifier % 10_000
  end

  class Red def self.code_fragment  = 118 end
  class Blue def self.code_fragment = 923 end

end

module EstateExecutor
  extend self

  FAMILIES = [Zhang, Khan, Garcia]

  def assemble_account_number(secret_modifier)
    FAMILIES.sum { |family| family.bank_number_part(secret_modifier) }
  end

  def assemble_code
    red_sum = FAMILIES.sum  { |family| family::Red.code_fragment }
    blue_sum = FAMILIES.sum { |family| family::Blue.code_fragment }
    red_sum * blue_sum
  end

end
