defmodule FoodChain do
  @animal_attribute_sentiment [
    {"fly", "", "I don't know why she swallowed the fly. Perhaps she'll die."},
    {"spider", " that wriggled and jiggled and tickled inside her",
     "It wriggled and jiggled and tickled inside her."},
    {"bird", "", "How absurd to swallow a bird!"},
    {"cat", "", "Imagine that, to swallow a cat!"},
    {"dog", "", "What a hog, to swallow a dog!"},
    {"goat", "", "Just opened her throat and swallowed a goat!"},
    {"cow", "", "I don't know how she swallowed a cow!"},
    {:immediate_end, {"horse", "", "She's dead, of course!"}},
  ]

  def recite(first_verse, last_verse),
    do: Enum.map_join(first_verse..last_verse, "\n", &verse/1)

  defp verse(verse_number) do
    case Enum.at(@animal_attribute_sentiment, verse_number - 1) do
      {:immediate_end, {animal, attribute, sentiment}} ->
        """
        I know an old lady who swallowed a #{animal}#{attribute}.
        #{sentiment}
        """
      {animal, attribute, sentiment} ->
        "I know an old lady who swallowed a #{animal}.\n" <>
        "#{if verse_number > 1, do: sentiment <> "\n"}" <>
        (@animal_attribute_sentiment
         |> Enum.take(verse_number)
         |> Enum.reverse()
         |> Enum.chunk_every(2, 1, :discard)
         |> Enum.map_join("", fn [{animal1, _, _}, {animal2, attribute2, _}] ->
           "She swallowed the #{animal1} to catch the #{animal2}#{attribute2}.\n"
         end)) <>
        (case @animal_attribute_sentiment do
           [{_animal, _attribute, sentiment} | _] -> sentiment <> "\n"
         end)
    end
  end
end
