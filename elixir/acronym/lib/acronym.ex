defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.upcase(
      String.split(string, " ")
      |> Enum.reduce("", fn x, acc -> acc <> String.at(x, 0) end)
    )
  end
end
