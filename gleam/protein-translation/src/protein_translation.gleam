import gleam/list
import gleam/string

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  case do_proteins(rna, []) {
    Ok(proteins) -> Ok(proteins |> list.reverse)
    Error(_) -> Error(Nil)
  }
}

fn do_proteins(rna: String, proteins: List(String)) -> Result(List(String), Nil) {
  let protein =
    get_protein_from_codon(string.slice(rna, at_index: 0, length: 3))
  let rest = string.drop_left(rna, 3)

  case protein {
    Ok(protein) -> do_proteins(rest, [protein, ..proteins])
    Error(EmptyString) -> Ok(proteins)
    Error(StopCode) -> Ok(proteins)
    Error(UnknownCodon) -> Error(Nil)
  }
}

type ParseError {
  EmptyString
  StopCode
  UnknownCodon
}

fn get_protein_from_codon(codon: String) -> Result(String, ParseError) {
  case codon {
    "AUG" -> Ok("Methionine")
    "UUU" | "UUC" -> Ok("Phenylalanine")
    "UUA" | "UUG" -> Ok("Leucine")
    "UCU" | "UCC" | "UCA" | "UCG" -> Ok("Serine")
    "UAU" | "UAC" -> Ok("Tyrosine")
    "UGU" | "UGC" -> Ok("Cysteine")
    "UGG" -> Ok("Tryptophan")
    "UAA" | "UAG" | "UGA" -> Error(StopCode)
    "" -> Error(EmptyString)
    _ -> Error(UnknownCodon)
  }
}
