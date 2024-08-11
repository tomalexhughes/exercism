import gleam/dict
import gleam/list
import gleam/result
import gleam/string

pub fn is_paired(value: String) -> Bool {
  do_is_paired(value, [])
}

fn do_is_paired(value: String, stack: List(String)) -> Bool {
  let bracket_matches = dict.from_list([#(")", "("), #("]", "["), #("}", "{")])
  let char = string.first(value) |> result.unwrap("")
  let is_starting_bracket = dict.values(bracket_matches) |> list.contains(char)
  let is_closing_bracket = dict.keys(bracket_matches) |> list.contains(char)
  let is_matching_bracket_top_of_stack =
    list.first(stack) == dict.get(bracket_matches, char)
  let is_finished = value == ""
  let is_stack_empty = list.is_empty(stack)

  case
    is_finished,
    is_stack_empty,
    is_starting_bracket,
    is_closing_bracket,
    is_matching_bracket_top_of_stack
  {
    True, True, _, _, _ -> True

    True, False, _, _, _ -> False

    _, _, _, True, False -> False

    _, _, _, True, True -> {
      do_is_paired(string.drop_left(value, 1), list.drop(stack, 1))
    }

    _, _, True, _, _ -> {
      do_is_paired(string.drop_left(value, 1), [char, ..stack])
    }

    _, _, _, _, _ -> {
      do_is_paired(string.drop_left(value, 1), stack)
    }
  }
}
