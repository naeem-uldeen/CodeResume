defmodule RPG do

  defmodule Character,   do: defstruct health: 100, mana: 0
  defmodule LoafOfBread, do: defstruct []
  defmodule ManaPotion,  do: defstruct strength: 10
  defmodule Poison,      do: defstruct []
  defmodule EmptyBottle, do: defstruct []

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread, do:
    def eat(_, %{health: health} = character),
      do: {nil, %{character | health: min(health + 5, 110)}}

  defimpl Edible, for: ManaPotion, do:
    def eat(%{strength: strength}, %{mana: mana} = character),
      do: {%EmptyBottle{}, %{character | mana: mana + strength}}

  defimpl Edible, for: Poison, do:
    def eat(_, character),
      do: {%EmptyBottle{}, %{character | health: 0}}

  defimpl Edible, for: EmptyBottle, do:
    def eat(item, character),
      do: {item, character}
      
end
