defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @codons @proteins |> Map.keys()

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    codon_list =
      rna_string_to_list(rna)
      |> Enum.uniq()
      |> Enum.map(fn codon -> @proteins[codon] end)

    proteins =
      codon_list
      |> Enum.with_index()
      |> Enum.filter(fn {_, i} ->
        i < Enum.find_index(codon_list, fn codon -> codon === "STOP" end)
      end)
      |> Enum.map(fn {k, _} -> k end)

    cond do
      Enum.member?(proteins, nil) -> {:error, "invalid RNA"}
      true -> {:ok, proteins}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) when codon in @codons, do: {:ok, @proteins[codon]}
  def of_codon(_), do: {:error, "invalid codon"}

  @spec of_rna(String.t()) :: list(String.t())
  defp rna_string_to_list(string) do
    string
    |> String.codepoints()
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
  end
end
