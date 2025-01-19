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
      // TODO: add bonus to the previous frame or this frame
      let frame: Frame = Frame(rolls: [knocked_pins], bonus: [])
      // TODO: This will be easier if we dont have a default first frame
      let previous_frame: Frame =
        add_bonus_to_previous_frame(game, knocked_pins)
      let other_frames = list.drop(game.frames, 1)
      let frames = [frame, previous_frame, ..other_frames]
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
      score + int.sum(frame.rolls) + int.sum(frame.bonus)
    })

  Ok(score)
}

fn add_bonus_to_previous_frame(game: Game, bonus: Int) -> Frame {
  // TODO: Remove `let assert`
  let assert Ok(frame) = game.frames |> list.first

  // TODO: Do we need to create a new frame, or can we update the existing
  Frame(rolls: frame.rolls, bonus: [bonus])
}
