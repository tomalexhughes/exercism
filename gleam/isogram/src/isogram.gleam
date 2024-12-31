import gleam/regex
import gleam/set
import gleam/string

pub fn is_isogram(phrase phrase: String) -> Bool {
  let assert Ok(re) = regex.from_string("[^a-zA-Z]")
  let phrase = regex.replace(re, phrase, "") |> string.lowercase

  let set = phrase |> string.to_graphemes |> set.from_list
  set.size(set) == string.length(phrase)
}
