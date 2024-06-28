import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  let applied_game =
    game
    |> rule1
    |> result.map(rule2)
    |> result.try(rule3)
    |> result.try(rule4)

  case applied_game {
    Ok(game) -> swap_player(game)
    Error(error) -> Game(..game, error: error)
  }
}

fn swap_player(game: Game) -> Game {
  case game {
    Game(_, _, Black, _) -> Game(..game, player: White)
    Game(_, _, White, _) -> Game(..game, player: Black)
  }
}
