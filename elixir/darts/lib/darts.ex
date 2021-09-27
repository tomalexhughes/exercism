defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    cond do
      is_within_inner_circle({x, y}) -> 10
      is_within_middle_circle({x, y}) -> 5
      is_within_outer_circle({x, y}) -> 1
      true -> 0
    end
  end

  defp is_within_circle({x, y}, radius),
    do: :math.pow(x, 2) + :math.pow(y, 2) <= :math.pow(radius, 2)

  defp is_within_outer_circle({x, y}), do: is_within_circle({x, y}, 10)
  defp is_within_middle_circle({x, y}), do: is_within_circle({x, y}, 5)
  defp is_within_inner_circle({x, y}), do: is_within_circle({x, y}, 1)
end
