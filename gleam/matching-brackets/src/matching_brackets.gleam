import gleam/list
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
  string.to_graphemes(value)
  |> list.fold_until([], fn(stack, char) {
    let char = to_bracket(char)

    case char, list.first(stack) {
      Opening(a), _ -> {
        list.Continue([Opening(a), ..stack])
      }

      Closing(a), Ok(Opening(b)) if a == b -> {
        list.Continue(list.drop(stack, 1))
      }

      Closing(a), _ -> {
        list.Stop([Closing(a), ..stack])
      }

      _, _ -> {
        list.Continue(stack)
      }
    }
  })
  |> list.is_empty
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
