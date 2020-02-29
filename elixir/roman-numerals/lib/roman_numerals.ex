defmodule RomanNumerals do
  @numerals [
    M: 1000,
    CM: 900,
    D: 500,
    CD: 400,
    C: 100,
    XC: 90,
    L: 50,
    XL: 40,
    X: 10,
    IX: 9,
    V: 5,
    IV: 4,
    I: 1
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(input_number) do
    # Recursively build up a list of numerals
    iterator([], input_number, @numerals)
  end

  # If the number is greater than or equal to the head of the mapping add the letter and subtract digit from input
  defp iterator(letters, input_number, [{letter, digit} | _t] = num_list)
       when input_number >= digit do
    iterator([letter | letters], input_number - digit, num_list)
  end

  # If the current number is less than the head of the list remove the head from the mapping and run again
  defp iterator(letters, input_number, [_h | t]) do
    iterator(letters, input_number, t)
  end

  # When we have ran out of mappings join the string together
  defp iterator(numerals, _n, []) do
    numerals
    |> Enum.reverse()
    |> Enum.map_join("", &to_string/1)
  end
end
