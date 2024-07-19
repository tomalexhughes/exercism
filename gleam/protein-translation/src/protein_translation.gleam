import gleam/list
import gleam/result

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  do_proteins(rna, [])
  |> result.map(list.reverse)
}

fn do_proteins(rna: String, proteins: List(String)) -> Result(List(String), Nil) {
  case rna {
    "AUG" <> rest -> do_proteins(rest, ["Methionine", ..proteins])

    "UUU" <> rest | "UUC" <> rest ->
      do_proteins(rest, ["Phenylalanine", ..proteins])

    "UUA" <> rest | "UUG" <> rest -> do_proteins(rest, ["Leucine", ..proteins])

    "UCU" <> rest | "UCC" <> rest | "UCA" <> rest | "UCG" <> rest ->
      do_proteins(rest, ["Serine", ..proteins])

    "UAU" <> rest | "UAC" <> rest -> do_proteins(rest, ["Tyrosine", ..proteins])

    "UGU" <> rest | "UGC" <> rest -> do_proteins(rest, ["Cysteine", ..proteins])

    "UGG" <> rest -> do_proteins(rest, ["Tryptophan", ..proteins])

    "UAA" <> _rest | "UAG" <> _rest | "UGA" <> _rest -> Ok(proteins)

    "" -> Ok(proteins)

    _ -> Error(Nil)
  }
}
