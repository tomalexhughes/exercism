import gleam/list

pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  do_accumulate(list, [], fun)
}

fn do_accumulate(
  list: List(a),
  transformed: List(b),
  fun: fn(a) -> b,
) -> List(b) {
  case list {
    [item, ..rest] -> do_accumulate(rest, [fun(item), ..transformed], fun)
    [] -> list.reverse(transformed)
  }
}
