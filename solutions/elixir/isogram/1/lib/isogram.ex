defmodule Isogram do

  @non_letters ~r/[^a-z]/

  def isogram?(sentence) do
    sentence =
      sentence
      |> String.downcase()
      |> String.replace(@non_letters, "")
      |> String.graphemes()
    (sentence -- Enum.uniq(sentence)) == []
  end

end
