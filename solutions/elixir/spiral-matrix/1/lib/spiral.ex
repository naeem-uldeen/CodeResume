defmodule Spiral.Grid do
  defstruct size: 0, cells: %{}

  def new(size), do: %__MODULE__{size: size}
  # Bounds check must come first: a missing key in the map would
  # read as "open" even for a cell that is off the board.
  def open?(%__MODULE__{size: size}, row, column)
      when row < 0 or column < 0 or row >= size or column >= size,
      do: false
  def open?(%__MODULE__{cells: cells}, row, column),
    do: not Map.has_key?(cells, {row, column})

  def mark(%__MODULE__{cells: cells} = grid, row, column, number),
    do: %{grid | cells: Map.put(cells, {row, column}, number)}

  def to_rows(%__MODULE__{size: size} = grid), do: rows(grid, size - 1, [])

  defp rows(_grid, row, acc) when row < 0, do: acc
  defp rows(%__MODULE__{size: size} = grid, row, acc),
    do: rows(grid, row - 1, [columns(grid, row, size - 1, []) | acc])

  defp columns(_grid, _row, column, acc) when column < 0, do: acc
  defp columns(%__MODULE__{cells: cells} = grid, row, column, acc),
    do: columns(grid, row, column - 1, [Map.fetch!(cells, {row, column}) | acc])
end

defmodule Spiral.Walker do
  alias Spiral.Grid

  defstruct [:grid, row: 0, column: 0, heading: :right]

  def new(%Grid{} = grid), do: %__MODULE__{grid: grid}

  def walk_spiral(%__MODULE__{grid: %Grid{size: size}} = walker),
    do: walk(walker, 1, size * size)

  defp walk(%__MODULE__{grid: grid}, number, last) when number > last, do: grid
  defp walk(walker, number, last) do
    walker
    |> mark(number)
    |> avoid_wall()
    |> step()
    |> walk(number + 1, last)
  end

  defp avoid_wall(walker), do: turn_if_blocked(walker, blocked_ahead?(walker))

  defp turn_if_blocked(walker, true), do: turn_right(walker)
  defp turn_if_blocked(walker, false), do: walker

  defp blocked_ahead?(%__MODULE__{grid: grid} = walker) do
    {row, column} = cell_ahead(walker)
    not Grid.open?(grid, row, column)
  end

  defp cell_ahead(%__MODULE__{row: row, column: column, heading: heading}) do
    {d_row, d_column} = delta(heading)
    {row + d_row, column + d_column}
  end

  defp turn_right(%__MODULE__{heading: heading} = walker),
    do: %{walker | heading: clockwise(heading)}

  defp step(walker) do
    {row, column} = cell_ahead(walker)
    %{walker | row: row, column: column}
  end

  defp mark(%__MODULE__{grid: grid, row: row, column: column} = walker, number),
    do: %{walker | grid: Grid.mark(grid, row, column, number)}

  defp delta(:right), do: {0, 1}
  defp delta(:down), do: {1, 0}
  defp delta(:left), do: {0, -1}
  defp delta(:up), do: {-1, 0}

  defp clockwise(:right), do: :down
  defp clockwise(:down), do: :left
  defp clockwise(:left), do: :up
  defp clockwise(:up), do: :right
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
