import gleam/regex
import gleam/set
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let assert Ok(chars_regex) = regex.from_string("[^a-z]")

  sentence
  |> string.lowercase
  |> regex.replace(chars_regex, _, "")
  |> string.to_graphemes
  |> set.from_list
  |> set.size
  == 26
}
