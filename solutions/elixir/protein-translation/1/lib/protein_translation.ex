defmodule ProteinTranslation do

  def of_rna(rna), do: iterate_by_3(String.graphemes(rna))

  defp iterate_by_3([]), do: {:ok, []}
  defp iterate_by_3([a, b, c | tail]) do
    to_string([a, b, c])
    |> of_codon()
    |> handle_codon(tail)
  end
  defp iterate_by_3([_ | _]), do: {:error, "invalid RNA"}

  defp handle_codon({:ok, "STOP"}, _tail), do: {:ok, []}
  defp handle_codon({:error, _}, _tail),   do: {:error, "invalid RNA"}
  defp handle_codon({:ok, protein}, tail), do: tail |> iterate_by_3() |> prepend(protein)

  defp prepend({:ok, rest}, protein), do: {:ok, [protein | rest]}
  defp prepend(error, _protein),      do: error

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
