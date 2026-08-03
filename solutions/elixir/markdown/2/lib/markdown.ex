defmodule Markdown do
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&html_for_line/1)
    |> join_with_groups("")
  end

  defp html_for_line("# " <> rest), do: tag("h1", rest)
  defp html_for_line("## " <> rest), do: tag("h2", rest)
  defp html_for_line("### " <> rest), do: tag("h3", rest)
  defp html_for_line("#### " <> rest), do: tag("h4", rest)
  defp html_for_line("##### " <> rest), do: tag("h5", rest)
  defp html_for_line("###### " <> rest), do: tag("h6", rest)
  defp html_for_line("* " <> rest), do: tag("li", rest)
  defp html_for_line(line), do: tag("p", line)

  defp tag(name, content), do: "<#{name}>#{format_inline(content)}</#{name}>"

  defp format_inline(text), do: do_format_inline(text, [{:root, ""}])

  defp do_format_inline("", [{:root, content}]), do: content
  defp do_format_inline("__" <> rest, [{:bold, content} | stack]),
    do: close_inline(rest, stack, "strong", content)
  defp do_format_inline("__" <> rest, stack),
    do: do_format_inline(rest, [{:bold, ""} | stack])
  defp do_format_inline("_" <> rest, [{:italic, content} | stack]),
    do: close_inline(rest, stack, "em", content)
  defp do_format_inline("_" <> rest, stack),
    do: do_format_inline(rest, [{:italic, ""} | stack])
  defp do_format_inline(<<char, rest::binary>>, [{tag, content} | stack]),
    do: do_format_inline(rest, [{tag, content <> <<char>>} | stack])

  defp close_inline(rest, [{outer, content} | stack], tag, inner), do:
    do_format_inline(rest, [{outer, content <> "<#{tag}>" <> inner <> "</#{tag}>"} | stack])

  defp join_with_groups([], acc), do: acc
  defp join_with_groups(["<li>" <> _ = line | rest], acc) do
    {items, remaining} = Enum.split_while([line | rest], fn item -> match?("<li>" <> _, item) end)
    join_with_groups(remaining, acc <> "<ul>" <> Enum.join(items) <> "</ul>")
  end
  defp join_with_groups([line | rest], acc),
    do: join_with_groups(rest, acc <> line)
end
