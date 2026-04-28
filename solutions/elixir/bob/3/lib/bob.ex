defmodule Bob do

  def hey(remark) when is_binary(remark),
    do:
      with(
        remark   = String.trim(remark),
        silent?  = remark == "",
        asking?  = String.ends_with?(remark, "?"),
        yelling? = not silent? and
          String.upcase(remark) == remark and
          String.downcase(remark) != remark,

        response =
          cond do
            yelling? and asking? -> "Calm down, I know what I'm doing!"
            silent?              -> "Fine. Be that way!"
            yelling?             -> "Whoa, chill out!"
            asking?              -> "Sure."
            :else                -> "Whatever."
          end,
        do: response
      )
  end
  