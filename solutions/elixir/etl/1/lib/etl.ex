defmodule ETL do

  def transform(old), do: transform(Map.to_list(old), %{})

  defp transform([], acc), do: acc
  defp transform([{score, letters} | rest], acc),
    do: transform(rest, transform_letters(letters, score, acc))
  defp transform_letters([], _score, acc), do: acc
  defp transform_letters([letter | rest], score, acc),
    do: transform_letters(rest, score, Map.put(acc, String.downcase(letter), score))
    
end
