import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let input_length = string.length(input)

  case input_length, size {
    0, _ -> Error(EmptySeries)
    _, size if size == 0 -> Error(SliceLengthZero)
    _, size if size < 0 -> Error(SliceLengthNegative)
    input_length, size if size > input_length -> Error(SliceLengthTooLarge)
    _, _ -> Ok(slice(input, size))
  }
}

fn slice(input: String, size: Int) {
  input
  |> string.to_graphemes
  |> list.window(size)
  |> list.map(string.concat)
}

pub type Error {
  SliceLengthTooLarge
  SliceLengthNegative
  SliceLengthZero
  EmptySeries
}
