defmodule FoodChain do

  @animals [
    {"fly", nil, "fly"},
    {"spider", "It wriggled and jiggled and tickled inside her.",
     "spider that wriggled and jiggled and tickled inside her"},
    {"bird", "How absurd to swallow a bird!", "bird"},
    {"cat", "Imagine that, to swallow a cat!", "cat"},
    {"dog", "What a hog, to swallow a dog!", "dog"},
    {"goat", "Just opened her throat and swallowed a goat!", "goat"},
    {"cow", "I don't know how she swallowed a cow!", "cow"},
    {"horse", "She's dead, of course!", nil}
  ]

  def recite(start, stop) do
    start..stop
    |> Enum.map_join("\n", &verse/1)
  end

  defp verse(8) do
    {animal, comment, _} = Enum.at(@animals, 7)
    "I know an old lady who swallowed a #{animal}.\n#{comment}\n"
  end

  defp verse(n) do
    {animal, comment, _} = Enum.at(@animals, n - 1)
    [
      "I know an old lady who swallowed a #{animal}.\n",
      if(comment, do: comment <> "\n", else: ""),
      chase_lines(n),
      "I don't know why she swallowed the fly. Perhaps she'll die.\n"
    ]
    |> IO.iodata_to_binary()
  end

  defp chase_lines(n) do
    for i <- n..2//-1 do
      {predator, _, _} = Enum.at(@animals, i - 1)
      {_, _, prey} = Enum.at(@animals, i - 2)
      "She swallowed the #{predator} to catch the #{prey}.\n"
    end
  end
  
end
