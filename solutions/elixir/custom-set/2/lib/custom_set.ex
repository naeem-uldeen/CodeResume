defmodule CustomSet do
  defstruct map: %{}

  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    map = Map.new(enumerable, fn element -> {element, true} end)
    %__MODULE__{map: map}
  end

  @spec empty?(t) :: boolean
  def empty?(%__MODULE__{map: map}), do: map == %{}

  @spec contains?(t, any) :: boolean
  def contains?(%__MODULE__{map: map}, element), do: Map.has_key?(map, element)

  @spec subset?(t, t) :: boolean
  def subset?(%__MODULE__{map: map1}, %__MODULE__{map: map2}),
    do: Enum.all?(Map.keys(map1), &Map.has_key?(map2, &1))

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%__MODULE__{map: map1}, %__MODULE__{map: map2}),
    do: not Enum.any?(Map.keys(map1), &Map.has_key?(map2, &1))

  @spec equal?(t, t) :: boolean
  def equal?(%__MODULE__{map: map1}, %__MODULE__{map: map2}), do: map1 == map2

  @spec add(t, any) :: t
  def add(%__MODULE__{map: map}, element), do: %__MODULE__{map: Map.put(map, element, true)}

  @spec intersection(t, t) :: t
  def intersection(%__MODULE__{map: map1}, %__MODULE__{map: map2}),
    do: %__MODULE__{map: Map.filter(map1, fn {key, _} -> Map.has_key?(map2, key) end)}

  @spec difference(t, t) :: t
  def difference(%__MODULE__{map: map1}, %__MODULE__{map: map2}),
    do: %__MODULE__{map: Map.drop(map1, Map.keys(map2))}

  @spec union(t, t) :: t
  def union(%__MODULE__{map: map1}, %__MODULE__{map: map2}),
    do: %__MODULE__{map: Map.merge(map1, map2)}
end
