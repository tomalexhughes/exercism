import gleam/string

pub fn reverse(value: String) -> String {
  // string.reverse(value)

  do_reverse(value, "")
}

fn do_reverse(input: String, output: String) -> String {
  case string.pop_grapheme(input) {
    Ok(#(char, rest)) -> do_reverse(rest, char <> output)
    Error(_) -> output
  }
}
