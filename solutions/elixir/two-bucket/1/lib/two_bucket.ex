defprotocol BreadthFirstSearchable do

  def initial_node(problem)
  def goal?(problem, node)
  def next_generation(problem, nodes)
end

defmodule BreadthFirstSearch do
  def solve(problem) do
    start = BreadthFirstSearchable.initial_node(problem)
    bfs(problem, [start], MapSet.new([start]), 0)
  end

  defp bfs(_problem, [], _visited, _moves), do: {:error, :impossible}
  defp bfs(problem, frontier, visited, moves),
    do: frontier
        |> Enum.find(&BreadthFirstSearchable.goal?(problem, &1))
        |> check_goal(problem, frontier, visited, moves)

  defp check_goal(nil, problem, frontier, visited, moves) do
    next =
      BreadthFirstSearchable.next_generation(problem, frontier)
      |> Enum.reject(&MapSet.member?(visited, &1))
      |> Enum.uniq()
    bfs(problem, next, MapSet.union(visited, MapSet.new(next)), moves + 1)
  end
  defp check_goal(goal_node, _problem, _frontier, _visited, moves),
    do: {:ok, moves, goal_node}
end

defmodule TwoBucket.Problem do
  defstruct [:capacity_one, :capacity_two, :goal, :start_bucket]
end

defmodule TwoBucket do
  defstruct [:bucket_one, :bucket_two, :moves]

  def measure(capacity_one, capacity_two, goal, start_bucket) do
    %TwoBucket.Problem{
      capacity_one: capacity_one,
      capacity_two: capacity_two,
      goal: goal,
      start_bucket: start_bucket
    }
    |> BreadthFirstSearch.solve()
    |> to_result()
  end

  defp to_result({:ok, moves, {one, two}}),
    do: {:ok, %TwoBucket{bucket_one: one, bucket_two: two, moves: moves}}
  defp to_result({:error, _}),
    do: {:error, :impossible}
end

defimpl BreadthFirstSearchable, for: TwoBucket.Problem do
  @transitions [
    {:pour, :one, :two},
    {:pour, :two, :one},
    {:fill, :one},
    {:fill, :two},
    {:empty, :one},
    {:empty, :two},
  ]

  defp transition(transition, capacity_tuple, content_tuple)
  defp transition({:empty, :one}, {_, _}, {0, _}), do: nil
  defp transition({:empty, :one}, {_, _}, {_one, two}), do: {0, two}
  defp transition({:empty, :two}, {_, _}, {_, 0}), do: nil
  defp transition({:empty, :two}, {_, _}, {one, _two}), do: {one, 0}
  defp transition({:fill, :one}, {cap, _}, {cap, _}), do: nil
  defp transition({:fill, :one}, {cap, _}, {_one, two}), do: {cap, two}
  defp transition({:fill, :two}, {_, cap}, {_, cap}), do: nil
  defp transition({:fill, :two}, {_, cap}, {one, _two}), do: {one, cap}
  defp transition({:pour, :one, :two}, {_, cap}, {_, cap}), do: nil
  defp transition({:pour, :one, :two}, {_, _}, {0, _}), do: nil
  defp transition({:pour, :one, :two}, {_, cap}, {one, two}),
    do: with(poured = min(cap - two, one), do: {one - poured, two + poured})
  defp transition({:pour, :two, :one}, {cap, _}, {cap, _}), do: nil
  defp transition({:pour, :two, :one}, {_, _}, {_, 0}), do: nil
  defp transition({:pour, :two, :one}, {cap, _}, {one, two}),
    do: with(poured = min(cap - one, two), do: {one + poured, two - poured})

  defp invalid?(%TwoBucket.Problem{capacity_two: cap, start_bucket: :one}, {0, cap}), do: true
  defp invalid?(%TwoBucket.Problem{capacity_one: cap, start_bucket: :two}, {cap, 0}), do: true
  defp invalid?(_, _), do: false

  def initial_node(%TwoBucket.Problem{}), do: {0, 0}

  def goal?(%TwoBucket.Problem{goal: goal}, {goal, _}), do: true
  def goal?(%TwoBucket.Problem{goal: goal}, {_, goal}), do: true
  def goal?(%TwoBucket.Problem{}, _), do: false

  def next_generation(p = %TwoBucket.Problem{capacity_one: capacity_one, capacity_two: capacity_two}, nodes) when is_list(nodes),
    do: for(
      predecessor <- nodes,
      transition <- @transitions,
      new_node = transition(transition, {capacity_one, capacity_two}, predecessor),
      not is_nil(new_node), not invalid?(p, new_node),
      do: new_node
    )
    
end
