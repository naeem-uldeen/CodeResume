class Grains

  private CHESSBOARD_SQUARES = 64
  private property square : Int32
  property count : UInt64

  private def initialize(@square : Int32)
    raise InvalidSquareError.new(@square) if
      @square < 1 || @square > CHESSBOARD_SQUARES
    @count = compute_count(@square)
  end

  private def compute_count(square : Int32) : UInt64
    grains = 1_u64
    (square - 1).times { grains *= 2 }
    grains
  end

  def self.all : Array(Grains)
    (1..CHESSBOARD_SQUARES).map { |number| new(number) }
  end

  # --- Public Class-level API ---

  def self.square(number : Int) : UInt64
    new(number.to_i32).count
  end

  def self.total : UInt64
    all.sum(&.count)
  end

end

class InvalidSquareError < ArgumentError
  def initialize(number : Int)
    super("Square number must be between 1 and 64, got #{number}")
  end
end
