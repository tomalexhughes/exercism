defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^[:alnum:]-]/u, trim: true)
    |> Enum.group_by(& &1)
    |> Enum.map(fn {key, value} -> {key, length(value)} end)
    |> Enum.into(%{})
  end
end
