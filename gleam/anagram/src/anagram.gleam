import gleam/list
import gleam/string

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let word = string.lowercase(word)
  let key = generate_key(word)

  candidates
  |> list.filter(fn(candidate) { string.lowercase(candidate) != word })
  |> list.filter(fn(candidate) { generate_key(candidate) == key })
}

fn generate_key(word: String) -> String {
  word
  |> string.lowercase
  |> string.to_graphemes
  |> list.sort(string.compare)
  |> string.concat
}
