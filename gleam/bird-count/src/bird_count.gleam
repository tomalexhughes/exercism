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
  case days {
    [] -> False
    [0, ..] -> True
    [_, ..rest] -> has_day_without_birds(rest)
  }
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [day, ..rest] -> day + total(rest)
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [day, ..rest] if day >= 5 -> busy_days(rest) + 1
    [_day, ..rest] -> busy_days(rest)
  }
}
