module Gigasecond exposing (add)

import Time


gigaSecond : Int
gigaSecond =
    10 ^ 9


add : Time.Posix -> Time.Posix
add timestamp =
    timestamp
        |> Time.posixToMillis
        |> (+) (gigaSecond * 1000)
        |> Time.millisToPosix
