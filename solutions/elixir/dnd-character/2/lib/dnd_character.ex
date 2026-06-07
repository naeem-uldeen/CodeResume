defmodule DndCharacter do

  @type t :: %__MODULE__{
    strength: integer,
    dexterity: integer,
    constitution: integer,
    intelligence: integer,
    wisdom: integer,
    charisma: integer,
    hitpoints: integer
  }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(integer) :: integer
  def modifier(score) when score >= 10, do: div(score - 10, 2)
  def modifier(score), do: Integer.floor_div(score - 10, 2)

  @spec ability() :: integer
  def ability() do
    1..4
    |> Enum.map(fn _ -> Enum.random(1..6) end)
    |> Enum.sort()
    |> Enum.drop(1)
    |> Enum.sum()
  end

  @spec character() :: t()
  def character() do
    constitution = ability()

    %__MODULE__{
      strength: ability(),
      dexterity: ability(),
      constitution: constitution,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: 10 + modifier(constitution)
    }
  end
  
end
