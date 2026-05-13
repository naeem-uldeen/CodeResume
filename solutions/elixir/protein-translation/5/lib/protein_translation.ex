defmodule ProteinTranslation do

  @codons_and_proteins [
    {~w(UGU UGC), "Cysteine"},
    {~w(UUA UUG), "Leucine"},
    {~w(AUG),     "Methionine"},
    {~w(UUU UUC), "Phenylalanine"},
    {~w(UCU UCC UCA UCG), "Serine"},
    {~w(UGG),     "Tryptophan"},
    {~w(UAU UAC), "Tyrosine"}
  ]
  @stop_codons ~w(UAA UAG UGA)

  def of_rna(rna), do: acids(rna, [])

  for {codons, protein} <- @codons_and_proteins, codon <- codons do
    defp acids(<<unquote(codon), rest::binary>>, proteins),
      do: acids(rest, [unquote(protein) | proteins])
  end
  
  for codon <- @stop_codons do
    defp acids(<<unquote(codon), _::binary>>, proteins),
      do: {:ok, Enum.reverse(proteins)}
  end
  
  defp acids(<<>>, proteins), do: {:ok, Enum.reverse(proteins)}
  defp acids(_, _),           do: {:error, "invalid RNA"}

  for {codons, protein} <- @codons_and_proteins, codon <- codons do
    def of_codon(unquote(codon)), do: {:ok, unquote(protein)}
  end
  
  for codon <- @stop_codons do
    def of_codon(unquote(codon)), do: {:ok, "STOP"}
  end
  
  def of_codon(_), do: {:error, "invalid codon"}
  
end
