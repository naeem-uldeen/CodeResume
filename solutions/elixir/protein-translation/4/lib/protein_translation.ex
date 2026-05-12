defmodule ProteinTranslation do

  @codons [
    {"UGU", "Cysteine"},     {"UGC", "Cysteine"},
    {"UUA", "Leucine"},      {"UUG", "Leucine"},
    {"AUG", "Methionine"},
    {"UUU", "Phenylalanine"},{"UUC", "Phenylalanine"},
    {"UCU", "Serine"},       {"UCC", "Serine"},
    {"UCA", "Serine"},       {"UCG", "Serine"},
    {"UGG", "Tryptophan"},
    {"UAU", "Tyrosine"},     {"UAC", "Tyrosine"},
    {"UAA", :stop},          {"UAG", :stop},          {"UGA", :stop}
  ]

  def of_rna(rna), do: acids(rna, [])

  for {codon, :stop} <- @codons do
    defp acids(<<unquote(codon), _::binary>>, proteins),
      do: {:ok, Enum.reverse(proteins)}

    def of_codon(unquote(codon)), do: {:ok, "STOP"}
  end

  for {codon, protein} <- @codons, protein != :stop do
    defp acids(<<unquote(codon), rest::binary>>, proteins),
      do: acids(rest, [unquote(protein) | proteins])

    def of_codon(unquote(codon)), do: {:ok, unquote(protein)}
  end

  defp acids(<<>>, proteins), do: {:ok, Enum.reverse(proteins)}
  defp acids(_, _),           do: {:error, "invalid RNA"}

  def of_codon(_), do: {:error, "invalid codon"}
end
