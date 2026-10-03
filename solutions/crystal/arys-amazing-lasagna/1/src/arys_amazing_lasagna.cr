abstract class Pasta
  include Comparable(Pasta)

  protected getter cook_time : Int32
  protected getter preparation_time : Int32

  def initialize(@cook_time : Int32, @preparation_time : Int32)
  end

  def <=>(other : Pasta) : Int32
    cook_time <=> other.cook_time
  end

  def remaining_minutes_in_oven(actual_minutes_in_oven : Int32) : Int32
    cook_time - actual_minutes_in_oven
  end

  def preparation_time_in_minutes(number_of_layers : Int32) : Int32
    preparation_time * number_of_layers
  end

  def total_time_in_minutes(number_of_layers : Int32, actual_minutes_in_oven : Int32) : Int32
    preparation_time_in_minutes(number_of_layers) + actual_minutes_in_oven
  end

  def to_s(io : IO) : Nil
    io << self.class << ": " << cook_time << " minutes in the oven, " \
          << preparation_time << " minutes prep time"
  end
end

class Lasagna < Pasta
  EXPECTED_MINUTES_IN_OVEN = 40

  def initialize(cook_time : Int32 = EXPECTED_MINUTES_IN_OVEN, preparation_time : Int32 = 2)
    super
  end
end

class Penne < Pasta
  def initialize(cook_time : Int32 = 25, preparation_time : Int32 = 1)
    super
  end
end

class AngelHair < Pasta
  def initialize(cook_time : Int32 = 7, preparation_time : Int32 = 1)
    super
  end
end
