import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let input_length = string.length(input)

  case input_length, size {
    0, _ -> Error(EmptySeries)
    _, size if size == 0 -> Error(SliceLengthZero)
    _, size if size < 0 -> Error(SliceLengthNegative)
    input_length, size if size > input_length -> Error(SliceLengthTooLarge)
    _, _ -> Ok(slice(input, size, []) |> list.reverse)
  }
}

fn slice(input: String, size: Int, slices: List(String)) {
  case string.length(input) < size {
    True -> slices
    False -> {
      let new_input = string.drop_left(input, 1)
      let new_slice = string.slice(input, 0, size)
      let slices = [new_slice, ..slices]
      slice(new_input, size, slices)
    }
  }
}

pub type Error {
  SliceLengthTooLarge
  SliceLengthNegative
  SliceLengthZero
  EmptySeries
}
