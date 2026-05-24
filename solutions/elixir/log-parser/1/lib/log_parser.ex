defmodule LogParser do

  @artifacts ~r/end-of-line\d+/i
  @log_levels ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  @separators ~r/<[~*=\-]*>/
  @user_name ~r/User\s+(\S+)/

  def valid_line?(line),        do: line =~ @log_levels
  def split_line(line),         do: String.split(line, @separators)
  def remove_artifacts(line),   do: String.replace(line, @artifacts, "")
  def tag_with_user_name(line), do: (case Regex.run(@user_name, line) do
        [_, user_name] -> "[USER] #{user_name} #{line}"
        nil -> line
      end)
end
