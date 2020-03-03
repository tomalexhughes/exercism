module Bob exposing (hey)

import String exposing (any, endsWith, isEmpty, toUpper, trim)


hey : String -> String
hey remark =
    if isEmpty <| trim <| remark then
        "Fine. Be that way!"

    else if toUpper remark == remark && endsWith "?" remark && hasLetters remark then
        "Calm down, I know what I'm doing!"

    else if toUpper remark == remark && hasLetters remark then
        "Whoa, chill out!"

    else if endsWith "?" (remark |> trim) then
        "Sure."

    else
        "Whatever."


hasLetters : String -> Bool
hasLetters remark =
    any Char.isAlpha remark
