pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

pub fn value(colors: List(Color)) -> Result(Int, Nil) {
  case colors {
    [color_1, color_2, ..] -> {
      // [color_1, color_2]
      // |> list.map(fn(x) { color_value(x) })
      // |> list.map(fn(x) { int.to_string(x) })
      // |> string.join("")
      // |> int.parse

      Ok(color_value(color_1) * 10 + color_value(color_2))
    }
    _ -> Error(Nil)
  }
}

fn color_value(color: Color) -> Int {
  case color {
    Black -> 0
    Brown -> 1
    Red -> 2
    Orange -> 3
    Yellow -> 4
    Green -> 5
    Blue -> 6
    Violet -> 7
    Grey -> 8
    White -> 9
  }
}
