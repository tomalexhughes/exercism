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
    in
    Ok (String.map rnaNucleotide dna)
