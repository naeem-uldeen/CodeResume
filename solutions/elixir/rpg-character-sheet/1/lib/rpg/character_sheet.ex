defmodule RPG.CharacterSheet do

  @welcome "Welcome! Let's fill out your character sheet together."
  @name_prompt "What is your character's name?"
  @class_prompt "What is your character's class?"
  @level_prompt "What is your character's level?"

  def welcome() do
    IO.puts(@welcome)
    :ok
  end

  def ask_name() do
    IO.puts(@name_prompt)
    String.trim(IO.gets(""))
  end

  def ask_class() do
    IO.puts(@class_prompt)
    String.trim(IO.gets(""))
  end

  def ask_level() do
    IO.puts(@level_prompt)
    String.to_integer(String.trim(IO.gets("")))
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()
    character = %{name: name, class: class, level: level}
    IO.puts("Your character: " <> inspect(character))
    character
  end
  
end