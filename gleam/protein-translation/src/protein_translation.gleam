import gleam/list
import gleam/result

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  do_proteins(rna, [])
  |> result.map(list.reverse)
}

fn do_proteins(rna: String, proteins: List(String)) -> Result(List(String), Nil) {
  case rna {
    "AUG" <> rest -> do_proteins(rest, ["Methionine", ..proteins])
    "UUU" <> rest -> do_proteins(rest, ["Phenylalanine", ..proteins])
    "UUC" <> rest -> do_proteins(rest, ["Phenylalanine", ..proteins])
    "UUA" <> rest -> do_proteins(rest, ["Leucine", ..proteins])
    "UUG" <> rest -> do_proteins(rest, ["Leucine", ..proteins])
    "UCU" <> rest -> do_proteins(rest, ["Serine", ..proteins])
    "UCC" <> rest -> do_proteins(rest, ["Serine", ..proteins])
    "UCA" <> rest -> do_proteins(rest, ["Serine", ..proteins])
    "UCG" <> rest -> do_proteins(rest, ["Serine", ..proteins])
    "UAU" <> rest -> do_proteins(rest, ["Tyrosine", ..proteins])
    "UAC" <> rest -> do_proteins(rest, ["Tyrosine", ..proteins])
    "UGU" <> rest -> do_proteins(rest, ["Cysteine", ..proteins])
    "UGC" <> rest -> do_proteins(rest, ["Cysteine", ..proteins])
    "UGG" <> rest -> do_proteins(rest, ["Tryptophan", ..proteins])
    "UAA" <> _rest -> Ok(proteins)
    "UAG" <> _rest -> Ok(proteins)
    "UGA" <> _rest -> Ok(proteins)
    "" -> Ok(proteins)
    _ -> Error(Nil)
  }
}
