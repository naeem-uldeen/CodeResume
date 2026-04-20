defmodule HighScore do

  @initial_points 0

  def new(), do: %{}

  # put_new adds a new player if they don't already exist,
  # preventing accidental overwrites
  def add_player(scores, name, score \\ @initial_points),
    do: Map.put_new(scores, name, score)

  def remove_player(scores, name),
    do: Map.delete(scores, name)

  def reset_score(scores, name),
    do: Map.put(scores, name, @initial_points)

  # For new players, score_to_add becomes their initial score.
  # For existing players, it is added to their current score.
  def update_score(scores, name, score_to_add),
    do: Map.update(scores, name, score_to_add, &(&1 + score_to_add))

  def get_score(scores, name),
    do: Map.get(scores, name, @initial_points)

  def get_players(scores),
    do: Map.keys(scores)
    
end
