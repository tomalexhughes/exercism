module TracksOnTracksOnTracks exposing (..)

import Array


newList : List String
newList =
    []


existingList : List String
existingList =
    [ "Elm", "Clojure", "Haskell" ]


addLanguage : String -> List String -> List String
addLanguage =
    (::)


countLanguages : List String -> Int
countLanguages =
    List.length


reverseList : List String -> List String
reverseList =
    List.reverse


excitingList : List String -> Bool
excitingList languages =
    let
        languagesArray =
            Array.fromList languages

        isFirstInList =
            Array.get 0 languagesArray == Just "Elm"

        isSecondInList =
            Array.get 1 languagesArray == Just "Elm"

        isShortList =
            List.length languages <= 3

        isExciting =
            isFirstInList || (isSecondInList && isShortList)
    in
    isExciting
