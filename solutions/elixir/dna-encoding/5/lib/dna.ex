defmodule DNA do

  nucleotides_and_codes = [
    {?\s, 0b0000},
    {?A, 0b0001},
    {?C, 0b0010},
    {?G, 0b0100},
    {?T, 0b1000}
  ]

  for {nucleotide, code} <- nucleotides_and_codes do
    def encode_nucleotide(unquote(nucleotide)), do: unquote(code)
  end

  for {nucleotide, code} <- nucleotides_and_codes do
    def decode_nucleotide(unquote(code)), do: unquote(nucleotide)
  end

  def encode([]), do: <<>>
  def encode([nucleotide | rest]),
    do: <<encode_nucleotide(nucleotide)::4, encode(rest)::bitstring>>

  def decode(<<>>), do: []
  def decode(<<code::4, rest::bitstring>>),
    do: [decode_nucleotide(code) | decode(rest)]

end
