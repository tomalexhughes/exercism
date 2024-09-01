import gleam/list
import gleam/result
import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> string.to_graphemes
  |> list.try_map(dna_grapheme_to_rna)
  |> result.map(string.concat)
}

fn dna_grapheme_to_rna(grapheme: String) -> Result(String, Nil) {
  case grapheme {
    "G" -> Ok("C")
    "C" -> Ok("G")
    "T" -> Ok("A")
    "A" -> Ok("U")
    _ -> Error(Nil)
  }
}
