defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word \\ "") do
    word
    |> String.trim()
    |> String.downcase()
    |> String.split("")
    |> Enum.map(&get_letter_value/1)
    |> Enum.sum()
  end

  defp get_letter_value(letter) do
    letter_scores = [
      {'a e i o u l n r s t', 1},
      {'d g', 2},
      {'b c m p', 3},
      {'f h v w y', 4},
      {'k', 5},
      {'j x', 8},
      {'q z', 10}
    ]

    letter =
      letter
      |> String.to_charlist()
      |> List.first()

    {_, score} =
      letter_scores |> Enum.find({:not_found, 0}, fn {charlist, _} -> letter in charlist end)

    score
  end
end
