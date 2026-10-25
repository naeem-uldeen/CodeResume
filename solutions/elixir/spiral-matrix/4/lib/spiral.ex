defmodule Spiral.Grid do
  @moduledoc false
  @enforce_keys [:size]

  defstruct [:size, cells: %{}]

  def new(size) when is_integer(size) and size >= 0, do: %__MODULE__{size: size}

  def cell_count(%__MODULE__{size: size}), do: size * size

  # Bounds check must come first: a missing key in the map would
  # read as "open" even for a cell that is off the board.
  def open?(%__MODULE__{size: size}, row, column)
      when row < 0 or column < 0 or row >= size or column >= size,
      do: false
  def open?(%__MODULE__{cells: cells}, row, column),
    do: not Map.has_key?(cells, {row, column})

  def mark(%__MODULE__{cells: cells} = grid, row, column, number),
    do: %{grid | cells: Map.put(cells, {row, column}, number)}

  def to_rows(%__MODULE__{size: size, cells: cells}) do
    for row <- 0..(size - 1)//1 do
      for column <- 0..(size - 1)//1, do: Map.fetch!(cells, {row, column})
    end
  end
end

defmodule Spiral.Walker do
  @moduledoc """
  Walks a `Spiral.Grid` like a turtle: mark the current cell, turn right if
  the cell ahead is blocked, then step forward.

  ## The vector math

  A position is a `{row, column}` pair. Rows grow downward, as on a screen,
  so this is a screen-coordinate plane: the vertical axis is flipped
  relative to a maths textbook.

  The heading is a unit step vector `{d_row, d_column}`. Moving forward is
  plain vector addition:

      {row, column} + {d_row, d_column} = the cell ahead

  Turning right is a 90-degree clockwise rotation (on screen) of that
  vector. A rotation matrix has cos and sin entries; at 90 degrees cos is 0
  and sin is 1, so every entry is 0, 1 or -1 and the arithmetic stays in
  exact integers, with no floats:

      | d_row'    |   |  0  1 |   | d_row    |
      | d_column' | = | -1  0 | * | d_column |

  which is the same as `{d_row', d_column'} = {d_column, -d_row}`.

  Equivalently, write the heading as the complex number `d_column + d_row*i`
  (the column step is the real part, the row step the imaginary part).
  Multiplying by `i` gives `-d_row + d_column*i`, the same rotation.

  Four turns multiply by `i^4 = 1`, a full circle, so the heading cycles
  with no lookup table and no modulo:

      {0, 1}   right
      {1, 0}   down
      {0, -1}  left
      {-1, 0}  up
      {0, 1}   right again

  Turning the other way (counterclockwise on screen) would be
  `{-d_column, d_row}`, which is multiplication by `-i`.
  """

  alias Spiral.Grid

  @enforce_keys [:grid]

  defstruct [:grid, row: 0, column: 0, heading: {0, 1}]

  @typedoc """
  A unit step `{d_row, d_column}`: the direction the walker faces. Only the
  four quarter-turn rotations of `{0, 1}` (right) ever occur.
  """
  @type heading :: {0, 1} | {1, 0} | {0, -1} | {-1, 0}
  @type position :: {row :: integer(), column :: integer()}
  @type t :: %__MODULE__{
          grid: %Grid{},
          row: integer(),
          column: integer(),
          heading: heading()
        }

  @spec new(%Grid{}) :: t()
  def new(%Grid{} = grid), do: %__MODULE__{grid: grid}

  # Vector addition: position + heading.
  @spec cell_ahead(t()) :: position()
  defp cell_ahead(%__MODULE__{row: row, column: column, heading: {d_row, d_column}}),
    do: {row + d_row, column + d_column}

  @spec blocked_ahead?(t()) :: boolean()
  defp blocked_ahead?(%__MODULE__{grid: grid} = walker) do
    {row, column} = cell_ahead(walker)
    not Grid.open?(grid, row, column)
  end

  # Rows grow downward, so this rotation turns right (clockwise on screen):
  # {0, 1} right -> {1, 0} down -> {0, -1} left -> {-1, 0} up -> {0, 1}
  # See the moduledoc for the matrix and complex-number forms.
  @spec turn_right(t()) :: t()
  defp turn_right(%__MODULE__{heading: {d_row, d_column}} = walker),
    do: %{walker | heading: {d_column, -d_row}}

  @spec avoid_wall(t()) :: t()
  defp avoid_wall(walker) do
    if blocked_ahead?(walker), do: turn_right(walker), else: walker
  end

  @spec step(t()) :: t()
  defp step(walker) do
    {row, column} = cell_ahead(walker)
    %{walker | row: row, column: column}
  end

  @spec mark(t(), pos_integer()) :: t()
  defp mark(%__MODULE__{grid: grid, row: row, column: column} = walker, number),
    do: %{walker | grid: Grid.mark(grid, row, column, number)}

  @spec walk_spiral(t()) :: %Grid{}
  def walk_spiral(%__MODULE__{grid: grid} = walker) do
    final_walker =
      Enum.reduce(1..Grid.cell_count(grid)//1, walker, fn number, walker ->
        walker
        |> mark(number)
        |> avoid_wall()
        |> step()
      end)

    final_walker.grid
  end
end

defmodule Spiral do
  alias Spiral.{Grid, Walker}

  def matrix(size) do
    size
    |> Grid.new()
    |> Walker.new()
    |> Walker.walk_spiral()
    |> Grid.to_rows()
  end
end
