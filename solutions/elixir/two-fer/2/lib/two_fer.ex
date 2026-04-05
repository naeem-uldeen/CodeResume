defmodule TwoFer do

  @spec two_fer(String) :: String
  def two_fer(name \\ "you") when is_binary(name) do
    "One for #{name}, one for me."
  end
  
end
