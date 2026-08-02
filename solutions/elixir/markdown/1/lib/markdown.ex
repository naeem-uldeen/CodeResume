defmodule Markdown do
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> to_blocks()
    |> Enum.map(&render_block/1)
    |> Enum.join()
  end

  defp to_blocks([]), do: []
  defp to_blocks([line | rest]) do
    case parse_header(line) do
      {level, text} ->
        [{:header, level, text} | to_blocks(rest)]
      nil ->
        case parse_list_item(line) do
          text when is_binary(text) ->
            {items, remaining} = collect_list_items(rest, [text])
            [{:list, items} | to_blocks(remaining)]
          nil ->
            [{:paragraph, line} | to_blocks(rest)]
        end
    end
  end

  defp collect_list_items([line | rest], acc) do
    case parse_list_item(line) do
      text when is_binary(text) -> collect_list_items(rest, [text | acc])
      nil -> {Enum.reverse(acc), [line | rest]}
    end
  end
  defp collect_list_items([], acc), do: {Enum.reverse(acc), []}

  defp parse_header(line) do
    case Regex.run(~r/^(\#{1,6})\s+(.*)/, line) do
      [_, hashes, text] -> {String.length(hashes), text}
      _ -> nil
    end
  end

  defp parse_list_item(line) do
    case Regex.run(~r/^\*\s+(.*)/, line) do
      [_, text] -> text
      _ -> nil
    end
  end

  defp render_block({:header, level, text}) do
    "<h#{level}>#{format_text(text)}</h#{level}>"
  end
  defp render_block({:paragraph, text}) do
    "<p>#{format_text(text)}</p>"
  end
  defp render_block({:list, items}) do
    items_html =
      items
      |> Enum.map(&"<li>#{format_text(&1)}</li>")
      |> Enum.join()
    "<ul>#{items_html}</ul>"
  end

  defp format_text(text) do
    text
    |> String.replace(~r/__(.+?)__/, "<strong>\\1</strong>")
    |> String.replace(~r/(?<!_)_(.+?)_(?!_)/, "<em>\\1</em>")
  end
end
