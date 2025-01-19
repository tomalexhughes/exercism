import gleam/int
import gleam/list

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
  let latest_frame = list.first(frames)

  case latest_frame {
    Ok(Frame(rolls: [roll_1], bonus: _)) -> {
      let frame: Frame = Frame(rolls: [roll_1, knocked_pins], bonus: [])
      let other_frames = list.drop(game.frames, 1)
      let frames = [frame, ..other_frames]
      Ok(Game(frames))
    }

    Ok(Frame(rolls: [roll_1, roll_2], bonus: _)) if roll_2 + roll_1 == 10 -> {
      let frame: Frame = Frame(rolls: [knocked_pins], bonus: [])
      let previous_frame: Frame =
        Frame(rolls: [roll_1, roll_2], bonus: [knocked_pins])
      let other_frames = list.drop(game.frames, 1)
      let frames = [frame, previous_frame, ..other_frames]
      Ok(Game(frames))
    }

    _ -> {
      let frame: Frame = Frame(rolls: [knocked_pins], bonus: [])
      let frames = [frame, ..game.frames]
      Ok(Game(frames))
    }
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  let score =
    list.fold(over: game.frames, from: 0, with: fn(score, frame) {
      score + int.sum(frame.rolls) + int.sum(frame.bonus)
    })

  Ok(score)
}
