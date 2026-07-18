defmodule CustomSet do
  defstruct map: %{}

  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    # Map.new/2 builds a map by associating each element with true
    map = Map.new(enumerable, fn element -> {element, true} end)
    %__MODULE__{map: map}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set.map == %{}
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    Map.has_key?(custom_set.map, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    # set 1 is a subset of set 2 if ALL elements in set 1 are in set 2
    Enum.all?(custom_set_1.map, fn {element, _} ->
      contains?(custom_set_2, element)
    end)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    # disjoint if NO elements in set 1 are present in set 2
    Enum.all?(custom_set_1.map, fn {element, _} ->
      not contains?(custom_set_2, element)
    end)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    # Since map structural equality cares about exact keys,
    # we can just directly compare the two maps.
    custom_set_1.map == custom_set_2.map
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    updated_map = Map.put(custom_set.map, element, true)
    %__MODULE__{map: updated_map}
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    # Keep only the keys from set 1 that also exist in set 2
    intersected_map =
      Map.filter(custom_set_1.map, fn {element, _} ->
        contains?(custom_set_2, element)
      end)
    %__MODULE__{map: intersected_map}
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    # Reject keys from set 1 if they exist in set 2
    differed_map = Map.drop(custom_set_1.map, Map.keys(custom_set_2.map))
    %__MODULE__{map: differed_map}
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    # Map.merge merges keys, automatically eliminating duplicates
    joined_map = Map.merge(custom_set_1.map, custom_set_2.map)
    %__MODULE__{map: joined_map}
  end
end
