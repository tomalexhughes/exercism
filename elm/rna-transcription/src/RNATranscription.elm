module RNATranscription exposing (toRNA)


toRNA : String -> Result Char String
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
                Err '_'

            else
                Ok rna
    in
    dna
        |> String.map rnaNucleotide
        |> validateRnaStrand
