module BettysBikeShop exposing (penceToPounds, poundsToString)

import Debug exposing (toString)


penceToPounds : Int -> Float
penceToPounds pence =
    toFloat pence / 100


poundsToString : Float -> String
poundsToString pounds =
    "£" ++ toString pounds
