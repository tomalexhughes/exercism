pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    41 | 43 -> "So close"
    guess if guess < 41 -> "Too low"
    guess if guess > 43 -> "Too high"
    _ -> panic
  }
}
