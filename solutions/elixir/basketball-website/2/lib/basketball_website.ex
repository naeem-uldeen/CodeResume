defmodule BasketballWebsite do

  def extract_from_path(data, path) when is_binary(path) do
    path
    |> String.split(".")
    |> walk(data)
  end

  def get_in_path(data, path) when is_binary(path) do
    get_in(data, String.split(path, "."))
  end

  defp walk([], data), do: data
  defp walk([key | rest], data), do: walk(rest, data[key])
  
end
