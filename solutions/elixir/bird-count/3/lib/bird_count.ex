defmodule BirdCount do

  @doc """
  Empty list     → no items.
  Non-empty list → return first item.
  """
  def today([]),                do: nil
  def today([today | _]),       do: today

  @doc """
  Empty list     → new list with single count.
  Non-empty list → match first element, increment it,
    keep tail unchanged.
  """
  def increment_day_count([]),    do: [1]
  def increment_day_count([todays_count | remaining_days]),
    do: [todays_count + 1 | remaining_days]

  @doc """
  Empty list     → no zero found.
  Non-empty list → if first item is 0 → found a zero;
                 → else skip first item, recursively check rest.
  """
  def has_day_without_birds?([]),                   do: false
  def has_day_without_birds?([0 | _]),              do: true
  def has_day_without_birds?([_ | remaining_days]),
    do: has_day_without_birds?(remaining_days)

  @doc """
  Empty list     → sum is 0.
  Non-empty list → add the first item to the recursive sum of the rest.
  """
  def total([]), do: 0
  def total([bird_count | remaining_days]), do: bird_count + total(remaining_days)

  @doc """
  Empty list     → no busy days.
  Non-empty list → check condition for first item:
                   - busy day equals 1 or 0
                   - add it to the recursive count of the rest.
  """
  def busy_days([]), do: 0
  def busy_days([bird_count | remaining_days]) do
    busy_day = if bird_count >= 5, do: 1, else: 0
    busy_day + busy_days(remaining_days)
  end

end
