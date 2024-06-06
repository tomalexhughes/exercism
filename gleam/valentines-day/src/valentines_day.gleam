pub type Approval {
  Yes
  No
  Maybe
}

pub type Cuisine {
  Korean
  Turkish
}

pub type Genre {
  Crime
  Horror
  Romance
  Thriller
}

pub type Activity {
  BoardGame
  Chill
  Movie(Genre)
  Restaurant(Cuisine)
  Walk(Int)
}

pub fn rate_activity(activity: Activity) -> Approval {
  case activity {
    Walk(distance) if distance > 11 -> Yes
    Walk(distance) if distance > 6 -> Maybe
    Restaurant(Turkish) -> Maybe
    Restaurant(Korean) -> Yes
    Movie(Romance) -> Yes
    BoardGame -> No
    _ -> No
  }
}
