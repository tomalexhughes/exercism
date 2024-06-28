import gleam/result
import gleam/string

pub fn hey(remark: String) -> String {
  let remark = string.trim(remark)
  let is_question = string.last(remark) |> result.unwrap("") == "?"
  let is_shouting =
    string.uppercase(remark) == remark && string.lowercase(remark) != remark
  let is_silence = string.is_empty(remark)

  case is_question, is_shouting, is_silence {
    _, _, True -> "Fine. Be that way!"
    True, True, False -> "Calm down, I know what I'm doing!"
    False, True, False -> "Whoa, chill out!"
    True, False, False -> "Sure."
    _, _, _ -> "Whatever."
  }
}
