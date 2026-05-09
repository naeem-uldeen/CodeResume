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

  def encode(strand), do: encoded(strand, <<>>)

  defp encoded([nucleotide | strand], encoded),
    do: encoded(strand, <<encoded::bitstring, encode_nucleotide(nucleotide)::4>>)
  defp encoded([], encoded), do: encoded

  def decode(dna), do: decoded(dna, [])

  defp decoded(<<code::4, dna::bitstring>>, decoded),
    do: decoded(dna, [decode_nucleotide(code) | decoded])
  defp decoded(<<>>, decoded), do: Enum.reverse(decoded)

end
