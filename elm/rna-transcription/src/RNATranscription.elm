module RNATranscription exposing (toRNA)


toRNA : String -> Result String String
toRNA dna =
    let
        rnaNucleotide dnaNucleotide =
            case dnaNucleotide of
                'G' ->
                    'C'

                'C' ->
                    'G'

                'T' ->
                    'A'

                'A' ->
                    'U'

                _ ->
                    '_'

        validateRnaStrand rna =
            if String.contains "_" rna then
                Err "Invalid character in DNA strand"

            else
                Ok rna
    in
    (String.map rnaNucleotide >> validateRnaStrand) dna
