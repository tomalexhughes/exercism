module TracksOnTracksOnTracks exposing (..)

import Array


newList : List String
newList =
    []


existingList : List String
existingList =
    [ "Elm", "Clojure", "Haskell" ]


addLanguage : String -> List String -> List String
addLanguage language languages =
    language :: languages


countLanguages : List String -> Int
countLanguages languages =
    List.length languages


reverseList : List String -> List String
reverseList languages =
    List.reverse languages


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
