defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{String.capitalize(container(number))} of beer on the wall, #{container(number)} of beer.
    #{action(number)}, #{container(successor(number))} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    Enum.reduce(range, "", fn x, acc -> "#{acc}\n#{verse(x)}" end)
    |> String.trim_leading()
  end

  @spec successor(integer) :: integer
  defp successor(0), do: 99
  defp successor(num), do: num - 1

  @spec container(integer) :: String.t()
  defp container(0), do: "no more bottles"
  defp container(1), do: "1 bottle"
  defp container(number), do: "#{number} bottles"

  @spec action(integer) :: String.t()
  defp action(1), do: "Take it down and pass it around"
  defp action(0), do: "Go to the store and buy some more"
  defp action(_), do: "Take one down and pass it around"
end
