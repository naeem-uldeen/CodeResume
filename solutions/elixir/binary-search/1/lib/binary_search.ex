defmodule BinarySearch do

  def search({}, _target), do: :not_found

  def search(numbers, target) when is_tuple(numbers) do
    index_of(numbers, target, 0, tuple_size(numbers) - 1)
  end

  defp index_of(_numbers, _target, lo, hi) when lo > hi, do: :not_found

  defp index_of(numbers, target, lo, hi) do
    mid = div(lo + hi, 2)

    case elem(numbers, mid) do
      ^target -> {:ok, mid}
      too_small when too_small < target -> index_of(numbers, target, mid + 1, hi)
      _too_large -> index_of(numbers, target, lo, mid - 1)
    end
  end
  
end

