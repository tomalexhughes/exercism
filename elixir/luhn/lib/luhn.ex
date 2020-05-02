defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean

  def valid?(number) do
    stripped_number = strip_spaces(number)

    cond do
      contains_illegal_chars?(stripped_number) -> false
      String.length(stripped_number) <= 1 -> false
      true -> rem(calculate(stripped_number), 10) == 0
    end
  end

  defp calculate(number) do
    number
    |> String.graphemes()
    |> Enum.reverse()
    |> List.insert_at(0, "0")
    |> Enum.map(&String.to_integer(&1))
    |> Enum.map_every(2, &double_digit(&1))
    |> Enum.sum()
  end

  defp double_digit(digit) when digit >= 5, do: digit * 2 - 9
  defp double_digit(digit), do: digit * 2

  defp contains_illegal_chars?(number) do
    !String.match?(number, ~r{\A\d*\z})
  end

  defp strip_spaces(number) do
    String.replace(number, " ", "")
  end
end
