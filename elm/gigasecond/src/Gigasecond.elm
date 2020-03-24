module Gigasecond exposing (add)

import Time


gigaSecond : Int
gigaSecond =
    10 ^ 9


add : Time.Posix -> Time.Posix
add timestamp =
    Time.millisToPosix (Time.posixToMillis timestamp + (gigaSecond * 1000))
