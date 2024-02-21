defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    calculate_factors(number, [], 2)
  end

  # Uses trial division, to improve performance we should use
  # a more performant algorithm.
  defp calculate_factors(1, list, _divisor) do
    list |> Enum.reverse()
  end

  defp calculate_factors(number, list, divisor) when rem(number, divisor) == 0,
    do: calculate_factors(div(number, divisor), [divisor | list], divisor)

  defp calculate_factors(number, list, divisor), do: calculate_factors(number, list, divisor + 1)
end
