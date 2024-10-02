import gleam/bool

pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  use <- bool.guard(!has_lengths_set(a, b, c), False)
  use <- bool.guard(!has_valid_lengths(a, b, c), False)

  a == b && b == c
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  use <- bool.guard(!has_lengths_set(a, b, c), False)
  use <- bool.guard(!has_valid_lengths(a, b, c), False)

  a == b || b == c || a == c
}

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  use <- bool.guard(!has_lengths_set(a, b, c), False)
  use <- bool.guard(!has_valid_lengths(a, b, c), False)

  a != b && b != c && a != c
}

fn has_lengths_set(a: Float, b: Float, c: Float) -> Bool {
  a != 0.0 && b != 0.0 && c != 0.0
}

fn has_valid_lengths(a: Float, b: Float, c: Float) -> Bool {
  a +. b >=. c && a +. c >=. b && b +. c >=. a
}
