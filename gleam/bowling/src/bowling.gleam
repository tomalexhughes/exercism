import gleam/int
import gleam/list
import gleam/result

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: List(Int))
}

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  let frames = game.frames
  let latest_frame =
    list.first(frames)
    |> result.unwrap(Frame(rolls: [], bonus: []))

  case latest_frame.rolls {
    [roll_1] -> {
      let frame: Frame = Frame(rolls: [roll_1, knocked_pins], bonus: [])
      // TODO: can we get rid of the drop here
      let other_frames = list.drop(game.frames, 1)
      let frames = [frame, ..other_frames]
      Ok(Game(frames))
    }
    [roll_1, roll_2, ..] if roll_2 + roll_1 == 10 -> {
      // TODO: add bonus
      let frame: Frame = Frame(rolls: [knocked_pins], bonus: [])
      let frames = [frame, ..game.frames]
      Ok(Game(frames))
    }
    // TODO: merge these conditions
    [_roll_1, _roll_2, ..] -> {
      let frame: Frame = Frame(rolls: [knocked_pins], bonus: [])
      let frames = [frame, ..game.frames]
      Ok(Game(frames))
    }
    [] -> {
      let frame: Frame = Frame(rolls: [knocked_pins], bonus: [])
      let frames = [frame, ..game.frames]
      Ok(Game(frames))
    }
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  let score =
    list.fold(over: game.frames, from: 0, with: fn(score, frame) {
      score + int.sum(frame.rolls)
    })

  Ok(score)
}
