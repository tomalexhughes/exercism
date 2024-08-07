import gleam/list
import gleam/option.{type Option, None, Some}

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  list.last(high_scores)
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  case high_scores {
    [] -> Error(Nil)
    _ -> Ok(do_personal_best(high_scores, 0))
  }
}

fn do_personal_best(high_scores: List(Int), current_high_score) -> Int {
  case high_scores {
    [score, ..rest] if score > current_high_score ->
      do_personal_best(rest, score)
    [_, ..rest] -> do_personal_best(rest, current_high_score)
    [] -> current_high_score
  }
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  do_personal_top_three(high_scores, None, None, None)
}

fn do_personal_top_three(
  high_scores: List(Int),
  first: Option(Int),
  second: Option(Int),
  third: Option(Int),
) -> List(Int) {
  let unwrapped_first = option.unwrap(first, 0)
  let unwrapped_second = option.unwrap(second, 0)
  let unwrapped_third = option.unwrap(third, 0)

  case high_scores {
    [score, ..rest] if score > unwrapped_first -> {
      do_personal_top_three(rest, Some(score), first, second)
    }
    [score, ..rest] if score > unwrapped_second -> {
      do_personal_top_three(rest, first, Some(score), second)
    }
    [score, ..rest] if score > unwrapped_third -> {
      do_personal_top_three(rest, first, second, Some(score))
    }
    [_, ..rest] -> {
      do_personal_top_three(rest, first, second, third)
    }
    [] -> [first, second, third] |> option.values()
  }
}
