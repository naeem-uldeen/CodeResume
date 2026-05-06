defmodule RPG.CharacterSheet do

  @welcome      "Welcome! Let's fill out your character sheet together."
  @name_prompt  "What is your character's name?"
  @class_prompt "What is your character's class?"
  @level_prompt "What is your character's level?"

  def run(),
    do:
      new_character()
      |> prompt(&welcome/0)
      |> ask_property(:name,  &ask_name/0)
      |> ask_property(:class, &ask_class/0)
      |> ask_property(:level, &ask_level/0)
      |> prompt(&character_description/1)

  defp new_character(), do: %{}

  def welcome(), do: IO.puts(@welcome)

  defp character_description(character),
    do: IO.inspect(character, label: "Your character")

  def ask_name(),  do: ask_for_string(@name_prompt)
  def ask_class(), do: ask_for_string(@class_prompt)
  def ask_level(),
    do: String.to_integer(ask_for_string(@level_prompt))

  defp ask_for_string(prompt),
    do: String.trim(IO.gets(prompt <> "\n"))

  defp ask_property(map, property, ask_fn),
    do: Map.put(map, property, ask_fn.())

  defp prompt(value, fun) when
    is_function(fun, 0),
    do: (fun.(); value)

  defp prompt(value, fun) when
    is_function(fun, 1),
    do: tap(value, fun)

end
