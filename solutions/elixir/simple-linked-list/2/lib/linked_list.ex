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
  def push(list, element), do: {element, list}

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list), do: count(list, 0)

  defp count({}, total), do: total
  defp count({_element, rest}, total), do: count(rest, total + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({}), do: true
  def empty?({_element, _rest}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({element, _rest}), do: {:ok, element}
  def peek({}), do: {:error, :empty_list}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({_element, rest}), do: {:ok, rest}
  def tail({}), do: {:error, :empty_list}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({element, rest}), do: {:ok, element, rest}
  def pop({}), do: {:error, :empty_list}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(elements), do: from_list(elements, new())

  defp from_list([], built), do: reverse(built)
  defp from_list([head | tail], built), do: from_list(tail, {head, built})

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: list |> reverse() |> to_list([])

  defp to_list({}, collected), do: collected
  defp to_list({element, rest}, collected), do: to_list(rest, [element | collected])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: reverse(list, new())

  defp reverse({}, built), do: built
  defp reverse({element, rest}, built), do: reverse(rest, {element, built})
end
