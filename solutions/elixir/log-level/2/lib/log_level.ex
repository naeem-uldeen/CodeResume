defmodule LogLevel do

  def to_label(5, false), do: :fatal
  def to_label(4, _),     do: :error
  def to_label(3, _),     do: :warning
  def to_label(2, _),     do: :info
  def to_label(1, _),     do: :debug
  def to_label(0, false), do: :trace
  def to_label(_, _),     do: :unknown

  def alert_recipient(level, legacy?) do
    level
    |> to_label(legacy?)
    |> recipient_for_label(legacy?)
  end

  defp recipient_for_label(:fatal,   _),     do: :ops
  defp recipient_for_label(:error,   _),     do: :ops
  defp recipient_for_label(:unknown, true),  do: :dev1
  defp recipient_for_label(:unknown, false), do: :dev2
  defp recipient_for_label(_,        _),     do: false
  
end
