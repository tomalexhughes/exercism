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

  defp calculate_factors(1, list, _divisor) do
    list |> Enum.reverse()
  end

  defp calculate_factors(number, list, divisor) do
    if rem(number, divisor) == 0 do
      calculate_factors(div(number, divisor), [divisor | list], divisor)
    else
      calculate_factors(number, list, divisor + 1)
    end
  end
end
