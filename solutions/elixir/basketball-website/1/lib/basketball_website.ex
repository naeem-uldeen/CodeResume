defmodule BasketballWebsite do
  def extract_from_path(data, path) when is_binary(path) do
    tokens =
      path
      |> String.split(".")
      |> Enum.map(&annotate_token/1)
    walk(data, tokens)
  end

  def get_in_path(data, path) when is_binary(path) do
    accessors =
      path
      |> String.split(".")
      |> Enum.map(&annotate_token/1)
      |> Enum.map(&dynamic_accessor/1)
    get_in(data, accessors)
  end

  defp walk(nil, _tokens), do: nil
  defp walk(data, []), do: data
  defp walk(data, [tok | rem]), do: walk(step(data, tok), rem)

  defp dynamic_accessor(tok), do: fn :get, data, next -> next.(step(data, tok)) end

  defp step(nil, _tok), do: nil
  defp step(data, {_raw, index}) when is_list(data) and is_integer(index), do: Enum.at(data, index)
  defp step(data, {raw, _index}) when is_map(data), do: Map.get(data, raw)

  defp annotate_token(raw), do: annotate_token(raw, Integer.parse(raw))
  defp annotate_token(raw, {index, ""}), do: {raw, index}
  defp annotate_token(raw, _unparsed), do: {raw, nil}
end
