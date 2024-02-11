defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """

  @unicode_character ~r/^\p{L}$/u

  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _workers), do: %{}

  def frequency(texts, workers) do
    graphemes = texts |> Enum.join() |> String.graphemes()
    graphemes_per_chunk = ceil(length(graphemes) / workers)
    chunked = Enum.chunk_every(graphemes, graphemes_per_chunk)

    Task.async_stream(chunked, &count_letters/1)
    |> merge_results_stream
  end

  defp count_letters(graphemes) do
    Enum.filter(graphemes, &Regex.match?(@unicode_character, &1))
    |> Enum.frequencies_by(&String.downcase/1)
  end

  defp merge_results_stream(results_stream) do
    # > Computations on streams are only performed when you call a function from the Enum module.
    Enum.reduce(results_stream, %{}, fn {:ok, worker_result}, acc ->
      Map.merge(acc, worker_result, fn _key, acc_val, worker_val ->
        acc_val + worker_val
      end)
    end)
  end
end
