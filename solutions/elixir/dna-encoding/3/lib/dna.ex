defmodule DNA do

  @nucleotides [{?\s, 0b0000}, {?A, 0b0001}, {?C, 0b0010}, {?G, 0b0100}, {?T, 0b1000}]

  for {code_point, value} <- @nucleotides do
    def encode_nucleotide(unquote(code_point)), do: unquote(value)
    def decode_nucleotide(unquote(value)), do: unquote(code_point)
  end

  for {code_point, value} <- @nucleotides do
    def encode([unquote(code_point) | rest]),
      do: <<unquote(value)::4, encode(rest)::bitstring>>

    def decode(<<unquote(value)::4, rest::bitstring>>),
      do: [unquote(code_point) | decode(rest)]
  end

  def encode([]), do: <<>>
  def decode(<<>>), do: []
  
end
