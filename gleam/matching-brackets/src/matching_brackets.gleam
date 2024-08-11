import gleam/string

pub fn is_paired(value: String) -> Bool {
  do_is_paired(value, [])
}

fn do_is_paired(value: String, stack: List(String)) -> Bool {
  // TODO: How can I reduce the amount of case expressions here?
  case value, stack {
    "", [] -> True
    "", _ -> False

    "[" <> rest_of_string, stack -> do_is_paired(rest_of_string, ["[", ..stack])
    "]" <> rest_of_string, ["[", ..rest_of_stack] ->
      do_is_paired(rest_of_string, rest_of_stack)

    "{" <> rest_of_string, stack -> do_is_paired(rest_of_string, ["{", ..stack])
    "}" <> rest_of_string, ["{", ..rest_of_stack] ->
      do_is_paired(rest_of_string, rest_of_stack)

    "(" <> rest_of_string, stack -> do_is_paired(rest_of_string, ["(", ..stack])
    ")" <> rest_of_string, ["(", ..rest_of_stack] ->
      do_is_paired(rest_of_string, rest_of_stack)

    ")" <> _, _ -> False
    "}" <> _, _ -> False
    "]" <> _, _ -> False

    _, stack -> do_is_paired(string.drop_left(value, 1), stack)
  }
}
