defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &is_case_insensitive_anagram(base, &1))
  end

  defp is_case_insensitive_anagram(one, two) do
    one = String.downcase(one)
    two = String.downcase(two)

    one != two && Map.equal?(build_hash_map(one), build_hash_map(two))
  end

  defp build_hash_map(word) do
    word
    |> String.graphemes()
    # Alternatively: |> Enum.reduce(%{}, fn char, acc -> Map.update(acc, char, 1, fn i -> i + 1 end) end)
    |> Enum.frequencies()
  end
end
