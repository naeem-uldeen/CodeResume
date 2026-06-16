defmodule FoodChain do

  @animals [
    {"fly", nil, "fly"},
    {"spider",
    "It wriggled and jiggled and tickled inside her.",
    "spider that wriggled and jiggled and tickled inside her"},
    {"bird", "How absurd to swallow a bird!", "bird"},
    {"cat", "Imagine that, to swallow a cat!", "cat"},
    {"dog", "What a hog, to swallow a dog!", "dog"},
    {"goat", "Just opened her throat and swallowed a goat!", "goat"},
    {"cow",  "I don't know how she swallowed a cow!", "cow"},
    {"horse", "She's dead, of course!", nil}
  ]

  def recite(start, stop) do
    start..stop
    |> Enum.map(&verse/1)
    |> Enum.intersperse("\n")
    |> IO.iodata_to_binary()
  end

  defp verse(8) do
    {name, comment, _} = Enum.at(@animals, 7)
    ["I know an old lady who swallowed a ", name, ".\n", comment, "\n"]
  end

  defp verse(n) do
    {name, comment, _} = Enum.at(@animals, n - 1)
    [
      "I know an old lady who swallowed a ", name, ".\n",
      comment_lines(comment),
      chase_lines(n),
      "I don't know why she swallowed the fly. Perhaps she'll die.\n"
    ]
  end

  defp comment_lines(nil), do: []
  defp comment_lines(comment), do: [comment, "\n"]

  defp chase_lines(1), do: []
  defp chase_lines(n) do
    for i <- n..2 do
      {predator_name, _, _} = Enum.at(@animals, i - 1)
      {_, _, prey_phrase} = Enum.at(@animals, i - 2)
      ["She swallowed the ", predator_name, " to catch the ", prey_phrase, ".\n"]
    end
  end

end
