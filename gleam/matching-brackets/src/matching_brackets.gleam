import gleam/list
import gleam/result
import gleam/string

type Bracket {
  Curly
  Round
  Square
}

type BracketType {
  Opening(Bracket)
  Closing(Bracket)
  NotApplicable
}

pub fn is_paired(value: String) -> Bool {
  do_is_paired(value, [])
}

fn do_is_paired(value: String, stack: List(BracketType)) -> Bool {
  let bracket = string.first(value) |> result.unwrap("") |> to_bracket
  let is_finished = value == ""
  let is_stack_empty = list.is_empty(stack)

  case is_finished, is_stack_empty, bracket, list.first(stack) {
    True, True, _, _ -> True

    True, False, _, _ -> False

    _, _, Closing(a), Ok(Opening(b)) if a != b -> False

    _, _, Closing(a), Ok(Opening(b)) if a == b -> {
      do_is_paired(string.drop_left(value, 1), list.drop(stack, 1))
    }

    _, _, Opening(a), _ -> {
      do_is_paired(string.drop_left(value, 1), [Opening(a), ..stack])
    }

    _, _, NotApplicable, _ -> {
      do_is_paired(string.drop_left(value, 1), stack)
    }

    _, _, _, _ -> False
  }
}

fn to_bracket(value: String) -> BracketType {
  case value {
    "(" -> Opening(Round)
    ")" -> Closing(Round)
    "[" -> Opening(Square)
    "]" -> Closing(Square)
    "{" -> Opening(Curly)
    "}" -> Closing(Curly)
    _ -> NotApplicable
  }
}
