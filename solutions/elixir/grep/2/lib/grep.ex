defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files),
    do:
      context(pattern, flags, files)
      |> scan(files)
      |> result()

  # Builds the context used throughout the scanning process.
  defp context(pattern, flags, files) do
    flags = MapSet.new(flags)
    %{
      pattern: pattern,
      flag_case_insensitive: MapSet.member?(flags, "-i"),
      flag_match_entire_line: MapSet.member?(flags, "-x"),
      flag_match_inverse: MapSet.member?(flags, "-v"),
      flag_just_filename: MapSet.member?(flags, "-l"),
      flag_line_number: MapSet.member?(flags, "-n"),
      multiple_files: length(files) > 1,
      acc: ""
    }
  end

  # Scans recursively through the files and their lines.
  defp scan(context, []), do: context
  defp scan(context, [file | files]) when is_binary(file),
    do:
      context
      |> Map.put(:current_file, file)
      |> scan(lines_with_numbers(file))
      |> Map.delete(:current_file)
      |> scan(files)
  defp scan(context, [] = _lines), do: context
  defp scan(context, [{line, line_number} | lines]),
    do:
      context
      |> append({line, line_number})
      |> scan(lines)

  # Reads a file and attaches line numbers.
  defp lines_with_numbers(file) do
    content = File.read!(file)
    lines = String.split(content, "\n")
    lines =
      if String.ends_with?(content, "\n") do
        Enum.drop(lines, -1)
      else
        lines
      end
    Enum.with_index(lines, 1)
  end

  # Checks if a line matches according to the context's pattern and flags.
  defp matches?(_, ""), do: false
  defp matches?(context = %{flag_match_inverse: true}, line), do: not matches?(%{context | flag_match_inverse: false}, line)
  defp matches?(
         %{pattern: pattern, flag_match_entire_line: true, flag_case_insensitive: true},
         line
       ), do: String.downcase(pattern) == String.downcase(String.trim(line))
  defp matches?(%{pattern: pattern, flag_match_entire_line: true}, line),
    do: pattern == String.trim(line)
  defp matches?( %{pattern: pattern, flag_case_insensitive: true}, line),
       do: String.contains?(String.downcase(line), String.downcase(pattern))
  defp matches?(%{pattern: pattern}, line),
    do: String.contains?(line, pattern)

  # Appends a matching line according to the flags.
  defp append(context, {line, line_number}) do
    if matches?(context, line) do
      append_match(context, line, line_number)
    else
      context
    end
  end

  # With -l, append only the filename and only once.
  defp append_match(
         context = %{flag_just_filename: true, current_file: file},
         _line,
         _line_number
       ),
       do:
         context
         |> Map.update!(:acc, &(&1 <> file <> "\n"))
         |> Map.delete(:current_file)
  defp append_match(context = %{flag_just_filename: true}, _line, _line_number), do: context

  # Normal output, with filename when multiple files are searched.
  defp append_match(
         context = %{
           acc: acc,
           current_file: file,
           multiple_files: true,
           flag_line_number: true
         },
         line,
         line_number
       ),
       do: %{context | acc: acc <> "#{file}:#{line_number}:#{line}\n"}
  defp append_match(
         context = %{
           acc: acc,
           current_file: file,
           multiple_files: true
         },
         line,
         _line_number
       ),
       do: %{context | acc: acc <> "#{file}:#{line}\n"}
  defp append_match(context = %{acc: acc, flag_line_number: true}, line, line_number),
    do: %{context | acc: acc <> "#{line_number}:#{line}\n"}
  defp append_match(context = %{acc: acc}, line, _line_number), do: %{context | acc: acc <> "#{line}\n"}

  # Removes the trailing newline when no output exists.
  defp result(%{acc: ""}), do: ""
  defp result(%{acc: acc}), do: acc
end
