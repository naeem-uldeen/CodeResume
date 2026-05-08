defmodule DNA do

  @nucleotide_to_int %{
    ?\s => 0b0000,
    ?A  => 0b0001,
    ?C  => 0b0010,
    ?G  => 0b0100,
    ?T  => 0b1000
  }

  @int_to_nucleotide %{
    0b0000 => ?\s,
    0b0001 => ?A,
    0b0010 => ?C,
    0b0100 => ?G,
    0b1000 => ?T
  }

  def encode_nucleotide(code_point),
    do: @nucleotide_to_int[code_point]

  def decode_nucleotide(encoded_code),
    do: @int_to_nucleotide[encoded_code]

  def encode([]), do: <<>>
  def encode([code_point | rest]) do
    <<encode_nucleotide(code_point)::4, encode(rest)::bitstring>>
  end

  def decode(<<>>), do: []
  def decode(<<code::4, rest::bitstring>>) do
    [decode_nucleotide(code) | decode(rest)]
  end

end
