defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """

  @spec build_shape(char) :: String.t()

  def build_shape(letter) do
    range = Enum.to_list(?A..letter)
    letter_number = Enum.find_index(range, fn char -> char == letter end) + 1
    line_length = letter_number * 2 - 1

    upper_half =
      range
      |> Stream.with_index()
      |> Stream.map(fn {letter, index} ->
        current_letter_number = index + 1
        outside_spaces_amount = letter_number - current_letter_number
        inside_spaces_amount = line_length - 2 - outside_spaces_amount * 2
        inside_spaces_amount = if inside_spaces_amount >= 0, do: inside_spaces_amount, else: 0
        outside_spaces = String.duplicate(" ", outside_spaces_amount)
        inside_spaces = String.duplicate(" ", inside_spaces_amount)

        inner_string =
          if letter == ?A, do: <<letter>>, else: "#{<<letter>>}#{inside_spaces}#{<<letter>>}"

        "#{outside_spaces}#{inner_string}#{outside_spaces}\n"
      end)
      |> Enum.to_list()

    bottom_half = Enum.drop(upper_half, -1) |> Enum.reverse()
    [upper_half | bottom_half] |> Enum.join("")
  end
end
