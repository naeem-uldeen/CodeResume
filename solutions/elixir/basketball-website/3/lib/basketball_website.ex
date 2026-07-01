defmodule BasketballWebsite do

  def extract_from_path(data, path) when is_binary(path) do
    case String.split(path, ".", parts: 2) do
      [key] -> data[key]
      [key, rest] -> extract_from_path(data[key], rest)
    end
  end

  def get_in_path(data, path) when is_binary(path), do: get_in(data, String.split(path, "."))

end
