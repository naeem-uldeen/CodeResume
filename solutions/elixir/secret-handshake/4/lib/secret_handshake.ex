defmodule SecretHandshake do
  use Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    on = fn
      commands, flag, :reverse -> if (code &&& flag) > 0,
        do: Enum.reverse(commands),
        else: commands
      commands, flag, command  -> if (code &&& flag) > 0,
        do: commands ++ [command],
        else: commands
    end

    []
    |> on.(0b00001, "wink")
    |> on.(0b00010, "double blink")
    |> on.(0b00100, "close your eyes")
    |> on.(0b01000, "jump")
    |> on.(0b10000, :reverse)
  end
  
end
