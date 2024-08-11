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

  case value, stack, bracket, list.first(stack) {
    "", [], _, _ -> True

    "", _, _, _ -> False

    _, _, Closing(a), Ok(Opening(b)) if a == b -> {
      do_is_paired(string.drop_left(value, 1), list.drop(stack, 1))
    }

    _, _, Closing(_), _ -> False

    _, _, Opening(a), _ -> {
      do_is_paired(string.drop_left(value, 1), [Opening(a), ..stack])
    }

    _, _, NotApplicable, _ -> {
      do_is_paired(string.drop_left(value, 1), stack)
    }
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
