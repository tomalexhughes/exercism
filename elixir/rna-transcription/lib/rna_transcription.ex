defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn x -> convert_char(x) end)
    |> Enum.concat
  end

  defp convert_char(char) do
    case char do
      ?G -> 'C'
      ?C -> 'G'
      ?T -> 'A'
      ?A -> 'U'
      _ -> ''
    end
  end
end
