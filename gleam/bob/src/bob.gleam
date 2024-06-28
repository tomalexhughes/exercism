import gleam/result
import gleam/string

type Remark {
  Silence
  Question(shouting: Bool)
  Statement(shouting: Bool)
}

pub fn hey(remark: String) -> String {
  case parse_remark(remark) {
    Silence -> "Fine. Be that way!"
    Question(shouting: True) -> "Calm down, I know what I'm doing!"
    Statement(True) -> "Whoa, chill out!"
    Question(False) -> "Sure."
    Statement(False) -> "Whatever."
  }
}

fn parse_remark(remark: String) -> Remark {
  let remark = string.trim(remark)
  let is_question = string.last(remark) |> result.unwrap("") == "?"
  let is_shouting =
    string.uppercase(remark) == remark && string.lowercase(remark) != remark
  let is_silence = string.is_empty(remark)

  case is_question, is_shouting, is_silence {
    _, _, True -> Silence
    True, True, False -> Question(shouting: True)
    False, True, False -> Statement(shouting: True)
    True, False, False -> Question(shouting: False)
    _, _, _ -> Statement(shouting: False)
  }
}
