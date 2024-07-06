import gleam/string.{length}

pub opaque type TreasureChest(treasure) {
  TreasureChest(password: String, treasure: treasure)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case length(password) {
    len if len >= 8 -> Ok(TreasureChest(password: password, treasure: contents))
    _ -> Error("Password must be at least 8 characters long")
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case password == chest.password {
    True -> Ok(chest.treasure)
    False -> Error("Incorrect password")
  }
}
