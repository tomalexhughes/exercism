defmodule Bob do
  def hey(input) do
    contains_letters = Regex.match?(~r/\p{L}/, input)

    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      input == String.upcase(input) && String.ends_with?(input, "?") && contains_letters ->
        "Calm down, I know what I'm doing!"

      String.ends_with?(input, "?") ->
        "Sure."

      input == String.upcase(input) && contains_letters ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end
