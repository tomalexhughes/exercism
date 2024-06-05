import gleam/list.{last}
import gleam/result
import gleam/string.{split}

pub fn message(log_line: String) -> String {
  log_line |> split(":") |> last |> result.unwrap("") |> string.trim
}

pub fn log_level(log_line: String) -> String {
  log_line
  |> string.replace("[", "")
  |> string.replace("]", "")
  |> string.split(":")
  |> list.first
  |> result.unwrap("")
  |> string.lowercase
}

pub fn reformat(log_line: String) -> String {
  let message = message(log_line)
  let log_level = log_level(log_line)

  message <> " (" <> log_level <> ")"
}
