defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    pattern
    |> context(flags, files)
    |> scan_files(files)
    |> result()
  end

  defp context(pattern, flags, files) do
    %{
      pattern: pattern,
      flag_case_insensitive: "-i" in flags,
      flag_match_entire_line: "-x" in flags,
      flag_match_inverse: "-v" in flags,
      flag_just_filename: "-l" in flags,
      flag_line_number: "-n" in flags,
      multiple_files: length(files) > 1,
      acc: ""
    }
  end

  defp scan_files(context, []), do: context
  defp scan_files(context, [file | files]) do
    context
    |> Map.put(:current_file, file)
    |> scan_lines(lines_with_numbers(file))
    |> Map.delete(:current_file)
    |> scan_files(files)
  end

  defp scan_lines(context, []), do: context
  defp scan_lines(context, [{line, line_number} | lines]) do
    context
    |> append({line, line_number})
    |> scan_lines(lines)
  end

  defp lines_with_numbers(file) do
    content = File.read!(file)

    lines =
      if String.ends_with?(content, "\n") do
        String.split(content, "\n") |> Enum.drop(-1)
      else
        String.split(content, "\n")
      end

    Enum.with_index(lines, 1)
  end

  defp matches?(_, ""), do: false
  defp matches?(%{flag_match_inverse: true} = context, line),
    do: not matches?(%{context | flag_match_inverse: false}, line)
  defp matches?(
         %{pattern: pattern, flag_match_entire_line: true, flag_case_insensitive: true},
         line
       ),
       do: String.downcase(pattern) == String.downcase(String.trim(line))
  defp matches?(%{pattern: pattern, flag_match_entire_line: true}, line),
    do: pattern == String.trim(line)
  defp matches?(%{pattern: pattern, flag_case_insensitive: true}, line),
    do: String.contains?(String.downcase(line), String.downcase(pattern))
  defp matches?(%{pattern: pattern}, line),
    do: String.contains?(line, pattern)

  defp append(context, {line, line_number}) do
    if matches?(context, line) do
      append_match(context, line, line_number)
    else
      context
    end
  end

  defp append_match(
         %{flag_just_filename: true, current_file: file} = context,
         _line,
         _line_number
       ) do
    context
    |> Map.update!(:acc, &(&1 <> file <> "\n"))
    |> Map.delete(:current_file)
  end
  defp append_match(%{flag_just_filename: true} = context, _line, _line_number), do: context
  defp append_match(
         %{acc: acc, current_file: file, multiple_files: true, flag_line_number: true} = context,
         line,
         line_number
       ),
       do: %{context | acc: acc <> "#{file}:#{line_number}:#{line}\n"}
  defp append_match(
         %{acc: acc, current_file: file, multiple_files: true} = context,
         line,
         _line_number
       ),
       do: %{context | acc: acc <> "#{file}:#{line}\n"}
  defp append_match(%{acc: acc, flag_line_number: true} = context, line, line_number),
    do: %{context | acc: acc <> "#{line_number}:#{line}\n"}
  defp append_match(%{acc: acc} = context, line, _line_number),
    do: %{context | acc: acc <> "#{line}\n"}

  defp result(%{acc: ""}), do: ""
  defp result(%{acc: acc}), do: acc
end
