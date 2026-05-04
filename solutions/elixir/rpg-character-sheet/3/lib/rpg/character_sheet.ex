defmodule RPG.CharacterSheet do

  @welcome "Welcome! Let's fill out your character sheet together."
  @name_prompt "What is your character's name?"
  @class_prompt "What is your character's class?"
  @level_prompt "What is your character's level?"

  def run() do
    welcome()
    %{}
    |> ask_property(:name, &ask_name/0)
    |> ask_property(:class, &ask_class/0)
    |> ask_property(:level, &ask_level/0)
    |> IO.inspect(label: "Your character")
  end

  def welcome(),
    do: IO.puts(@welcome)

  def ask_name(),
    do: ask_for_string(@name_prompt)

  def ask_class(),
    do: ask_for_string(@class_prompt)

  def ask_level(),
    do: (IO.puts(@level_prompt);
      String.to_integer(String.trim(IO.gets(""))))

  defp ask_for_string(prompt),
    do: (IO.puts(prompt); String.trim(IO.gets("")))

  defp ask_property(map, property, ask_fn),
    do: Map.put(map, property, ask_fn.())

end
