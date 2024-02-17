defmodule CollatzConjecture do
  require Integer

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer(), count :: non_neg_integer()) :: non_neg_integer()
  def calc(input, count \\ 0)
  def calc(input, _count) when is_binary(input) or input <= 0, do: raise(FunctionClauseError)
  def calc(1, count), do: count
  def calc(input, count) when Integer.is_even(input), do: calc(div(input, 2), count + 1)
  def calc(input, count) when Integer.is_odd(input), do: calc(input * 3 + 1, count + 1)
end
