defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: {elem, list}

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list), do: do_count(list, 0)

  defp do_count({}, total), do: total
  defp do_count({_value, rest}, total), do: do_count(rest, total + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({}), do: true
  def empty?({_value, _rest}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: {:error, :empty_list}
  def peek({value, _rest}), do: {:ok, value}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: {:error, :empty_list}
  def tail({_value, rest}), do: {:ok, rest}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: {:error, :empty_list}
  def pop({value, rest}), do: {:ok, value, rest}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(elements), do: do_from_list(do_flip(elements, []), new())

  defp do_from_list([], built), do: built
  defp do_from_list([head | tail], built), do: do_from_list(tail, push(built, head))

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: do_flip(do_to_list(list, []), [])

  defp do_to_list({}, collected), do: collected
  defp do_to_list({value, rest}, collected), do: do_to_list(rest, [value | collected])

  defp do_flip([], acc), do: acc
  defp do_flip([head | tail], acc), do: do_flip(tail, [head | acc])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list, new())

  defp do_reverse({}, built), do: built
  defp do_reverse({value, rest}, built), do: do_reverse(rest, push(built, value))
end
