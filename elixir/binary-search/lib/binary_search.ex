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
  def search(numbers, item, index \\ 0)
  def search({item}, item, index), do: {:ok, index}
  def search({}, _, _), do: :not_found
  def search({tuple_item}, item, _) when tuple_item != item, do: :not_found

  def search(numbers, key, index) do
    size = tuple_size(numbers)
    as_list = Tuple.to_list(numbers)
    middle_index = size |> div(2)
    middle_item = as_list |> Enum.at(middle_index)
    is_before_split = middle_item > key
    range = if is_before_split, do: 0..(middle_index - 1), else: middle_index..-1//1
    sliced = as_list |> Enum.slice(range)

    number_of_elements_removed =
      if !is_before_split, do: length(as_list) - length(sliced), else: 0

    search(List.to_tuple(sliced), key, index + number_of_elements_removed)
  end
end
