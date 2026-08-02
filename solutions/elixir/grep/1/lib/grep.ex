defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    flags = MapSet.new(flags)
    multi? = length(files) > 1
    pat = if "-i" in flags, do: String.downcase(pattern), else: pattern

    match? = fn line ->
      l = if "-i" in flags, do: String.downcase(line), else: line
      m = if "-x" in flags, do: String.trim(l) == pat, else: String.contains?(l, pat)
      if "-v" in flags, do: not m, else: m
    end

    files
    |> Enum.flat_map(fn file ->
      lines = file |> File.read!() |> String.split("\n") |> then(fn l ->
        if String.ends_with?(File.read!(file), "\n") and l != [] and List.last(l) == "" do
          Enum.drop(l, -1)
        else
          l
        end
      end)

      if "-l" in flags do
        if Enum.any?(lines, match?), do: [file], else: []
      else
        lines
        |> Enum.with_index(1)
        |> Enum.filter(fn {line, _} -> match?.(line) end)
        |> Enum.map(fn {line, idx} ->
          pref = if multi?, do: "#{file}:", else: ""
          line_pref = if "-n" in flags, do: "#{pref}#{idx}:", else: pref
          "#{line_pref}#{line}"
        end)
      end
    end)
    |> then(fn res -> if Enum.empty?(res), do: "", else: Enum.join(res, "\n") <> "\n" end)
  end
end
