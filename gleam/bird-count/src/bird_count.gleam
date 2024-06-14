import gleam/int
import gleam/list

pub fn today(days: List(Int)) -> Int {
  case days {
    // NOTE: `..` rather than, `_` as the latter matches a list of exactly two elements
    [today, ..] -> today
    _ -> 0
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [today, ..days] -> [today + 1, ..days]
    _ -> [1]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  // TODO: Replace with recursion
  list.any(days, fn(day) { day == 0 })
}

pub fn total(days: List(Int)) -> Int {
  // TODO: Replace with recursion
  case list.reduce(days, int.add) {
    Ok(total) -> total
    _ -> 0
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  // TODO: Replace with recursion
  let minimum_birds_for_busy_day = 5

  days
  |> list.filter(fn(day) { day >= minimum_birds_for_busy_day })
  |> list.length
}
