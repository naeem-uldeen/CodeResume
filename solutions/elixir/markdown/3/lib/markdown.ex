defmodule Markdown do
  md_line_prefixes_and_tags = [
    {"#", "h1"},
    {"##", "h2"},
    {"###", "h3"},
    {"####", "h4"},
    {"#####", "h5"},
    {"######", "h6"},
    {"*", "li"}
  ]

  html_tag_for_unprefixed_lines = "p"

  md_formats_and_tags = [ {"__", "strong"}, {"_", "em"}]

  html_item_and_group_tags = [{"li", "ul"}]

  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&html_for_line/1)
    |> join_with_groups("")
  end

  for {prefix, tag_name} <- md_line_prefixes_and_tags do
    defp html_for_line(unquote(prefix) <> " " <> rest), do: tag(unquote(tag_name), rest)
  end

  defp html_for_line(line), do: tag(unquote(html_tag_for_unprefixed_lines), line)

  defp tag(tag_name, content), do: "<#{tag_name}>#{format_inline(content)}</#{tag_name}>"

  defp format_inline(text, stack \\ [], html \\ "")
  defp format_inline("", [], html), do: html

  for {markdown, tag_name} <- md_formats_and_tags do
    defp format_inline(
           unquote(markdown) <> rest,
           [unquote(tag_name) | stack],
           html
         ),
         do: format_inline(rest, stack, html <> "</#{unquote(tag_name)}>")
    defp format_inline(
           unquote(markdown) <> rest,
           stack,
           html
         ),
         do: format_inline(rest, [unquote(tag_name) | stack], html <> "<#{unquote(tag_name)}>")
  end
  defp format_inline(<<char, rest::binary>>, stack, html), do: format_inline(rest, stack, html <> <<char>>)

  for {item_tag, group_tag} <- html_item_and_group_tags do
    defp join_with_groups(
           ["<#{unquote(item_tag)}>" <> _ | _] = lines,
           html
         ) do
      {list_items, lines} =
        Enum.split_while(
          lines,
          &match?("<#{unquote(item_tag)}>" <> _, &1)
        )

      join_with_groups(
        lines,
        Enum.reduce(
          list_items,
          html <> "<#{unquote(group_tag)}>",
          &(&2 <> &1)
        ) <> "</#{unquote(group_tag)}>"
      )
    end
  end
  defp join_with_groups([], html), do: html
  defp join_with_groups([line | rest], html), do: join_with_groups(rest, html <> line)
end
