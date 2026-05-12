defmodule ProteinTranslation do
  # ── (case-based, slower than meta-version) ──────────────────────────────
  def of_rna(rna), do: acids(rna, [])

  defp acids(<<>>, proteins), do: {:ok, Enum.reverse(proteins)}
  defp acids(<<codon::binary-size(3), rest::binary>>, proteins) do
    case of_codon(codon) do
      {:ok, "STOP"}  -> {:ok, Enum.reverse(proteins)}
      {:ok, protein} -> acids(rest, [protein | proteins])
      _              -> {:error, "invalid RNA"}
    end
  end

  defp acids(_, _proteins), do: {:error, "invalid RNA"}

  def of_codon("UGU"), do: {:ok, "Cysteine"}
  def of_codon("UGC"), do: {:ok, "Cysteine"}
  def of_codon("UUA"), do: {:ok, "Leucine"}
  def of_codon("UUG"), do: {:ok, "Leucine"}
  def of_codon("AUG"), do: {:ok, "Methionine"}
  def of_codon("UUU"), do: {:ok, "Phenylalanine"}
  def of_codon("UUC"), do: {:ok, "Phenylalanine"}
  def of_codon("UCU"), do: {:ok, "Serine"}
  def of_codon("UCC"), do: {:ok, "Serine"}
  def of_codon("UCA"), do: {:ok, "Serine"}
  def of_codon("UCG"), do: {:ok, "Serine"}
  def of_codon("UGG"), do: {:ok, "Tryptophan"}
  def of_codon("UAU"), do: {:ok, "Tyrosine"}
  def of_codon("UAC"), do: {:ok, "Tyrosine"}
  def of_codon("UAA"), do: {:ok, "STOP"}
  def of_codon("UAG"), do: {:ok, "STOP"}
  def of_codon("UGA"), do: {:ok, "STOP"}
  def of_codon(_),     do: {:error, "invalid codon"}

end
