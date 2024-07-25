import gleam/int
import gleam/list

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
  let constitution = ability()

  Character(
    ability(),
    ability(),
    ability(),
    ability(),
    ability(),
    constitution: constitution,
    hitpoints: modifier(constitution) + 10,
  )
}

pub fn modifier(score: Int) -> Int {
  let assert Ok(modifier) = int.floor_divide(score - 10, 2)
  modifier
}

pub fn ability() -> Int {
  let roll = fn() { int.random(5) + 1 }

  [roll(), roll(), roll(), roll()]
  |> list.sort(int.compare)
  |> list.drop(1)
  |> int.sum
}
