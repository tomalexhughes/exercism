defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """
  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found
  def search(numbers, key), do: search(numbers, key, 0, tuple_size(numbers) - 1)
  def search(numbers, key, 0, 1) when elem(numbers, 0) == key, do: {:ok, 0}

  def search(numbers, key, min, max) when div(max - min, 2) == 0 and elem(numbers, max) == key,
    do: {:ok, max}

  def search(numbers, key, min, max) do
    middle_index = div(max - min, 2) + min
    middle_value = elem(numbers, middle_index)

    cond do
      middle_index == max or middle_index == min -> :not_found
      middle_value == key -> {:ok, middle_index}
      middle_value < key -> search(numbers, key, middle_index, max)
      middle_value > key -> search(numbers, key, min, middle_index)
    end
  end
end
