defmodule BirdCount do

  @doc "Empty list     → no items."
  @doc "Non-empty list → return first item."
  def today([]),         do: nil
  def today([head | _]), do: head

  @doc "Empty list     → new list with single count."
  @doc "Non-empty list → match first element, increment it,
  keep tail unchanged."
  def increment_day_count([]),    do: [1]
  def increment_day_count([head | tail]),
    do: [head + 1 | tail]

  @doc "Empty list     → no zero found."
  @doc "Non-empty list → If first item is 0 → found a zero."
  @doc " → else skip first item, recursively check rest."
  def has_day_without_birds?([]),      do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | tail]),
    do:  has_day_without_birds?(tail)

  @doc "Empty list     → sum is 0."
  @doc "Non-empty list → add the first item to recursive sum of rest."
  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  @doc "Empty list → no busy days."
  @doc "Non-empty list → Check condition for first item:
          - busy days equals 1 or 0
          - add it to recursive count of rest"
  def busy_days([]), do: 0
  def busy_days([count | tail]) do
    busy_day = if count >= 5, do: 1, else: 0
    busy_day + busy_days(tail)
  end

end
