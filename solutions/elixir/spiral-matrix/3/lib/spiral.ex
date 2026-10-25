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
  @moduledoc false

  alias Spiral.Grid

  @enforce_keys [:grid]
  defstruct [:grid, row: 0, column: 0, heading: :right]

  def new(%Grid{} = grid), do: %__MODULE__{grid: grid}

  defp delta(:right), do: {0, 1}
  defp delta(:down), do: {1, 0}
  defp delta(:left), do: {0, -1}
  defp delta(:up), do: {-1, 0}

  defp clockwise(:right), do: :down
  defp clockwise(:down), do: :left
  defp clockwise(:left), do: :up
  defp clockwise(:up), do: :right

  defp cell_ahead(%__MODULE__{row: row, column: column, heading: heading}) do
    {d_row, d_column} = delta(heading)
    {row + d_row, column + d_column}
  end

  defp blocked_ahead?(%__MODULE__{grid: grid} = walker) do
    {row, column} = cell_ahead(walker)
    not Grid.open?(grid, row, column)
  end

  defp turn_right(%__MODULE__{heading: heading} = walker),
    do: %{walker | heading: clockwise(heading)}

  defp avoid_wall(walker) do
    if blocked_ahead?(walker), do: turn_right(walker), else: walker
  end

  defp step(walker) do
    {row, column} = cell_ahead(walker)
    %{walker | row: row, column: column}
  end

  defp mark(%__MODULE__{grid: grid, row: row, column: column} = walker, number),
    do: %{walker | grid: Grid.mark(grid, row, column, number)}

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
