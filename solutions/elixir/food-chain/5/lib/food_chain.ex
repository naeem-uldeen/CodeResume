defmodule FoodChain do

  @animals [
    %{name: "fly", comment: nil, catch_phrase: "fly"},
    %{name: "spider", comment: "It wriggled and jiggled and tickled inside her.",
      catch_phrase: "spider that wriggled and jiggled and tickled inside her"},
    %{name: "bird", comment: "How absurd to swallow a bird!", catch_phrase: "bird"},
    %{name: "cat", comment: "Imagine that, to swallow a cat!", catch_phrase: "cat"},
    %{name: "dog", comment: "What a hog, to swallow a dog!", catch_phrase: "dog"},
    %{name: "goat", comment: "Just opened her throat and swallowed a goat!", catch_phrase: "goat"},
    %{name: "cow", comment: "I don't know how she swallowed a cow!", catch_phrase: "cow"},
    %{name: "horse", comment: "She's dead, of course!", catch_phrase: nil}
  ]

  @fly_ending "I don't know why she swallowed the fly. Perhaps she'll die.\n"

  def recite(start, stop) do
    Enum.map_join(start..stop, "\n", &verse/1)
  end

  # The horse is the only one that breaks the pattern. Give it its own room.
  defp verse(8) do
    "I know an old lady who swallowed a horse.\nShe's dead, of course!\n"
  end

  defp verse(n) when n in 1..7 do
    animal = Enum.at(@animals, n - 1)

    intro = "I know an old lady who swallowed a #{animal.name}.\n"
    comment_line = if animal.comment, do: "#{animal.comment}\n", else: ""
    chase = build_chase(n)

    intro <> comment_line <> chase <> @fly_ending
  end

  defp build_chase(1), do: ""

  defp build_chase(n) do
    for i <- n..2 do
      predator = Enum.at(@animals, i - 1)
      prey = Enum.at(@animals, i - 2)
      "She swallowed the #{predator.name} to catch the #{prey.catch_phrase}.\n"
    end
    |> Enum.join()
  end
  
end
