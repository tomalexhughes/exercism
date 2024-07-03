import gleam/int.{max}
import gleam/option.{type Option, None, Some, unwrap}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player {
    Player(_, _, level: level, health: 0) if level >= 10 ->
      Some(Player(..player, health: 100, mana: option.Some(100)))
    Player(_, _, _, health: 0) -> Some(Player(..player, health: 100))
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player {
    Player(_, _, _, mana: None) -> #(
      Player(..player, health: max(player.health - cost, 0)),
      0,
    )

    Player(_, _, _, mana: Some(mana)) if cost <= mana -> #(
      Player(..player, mana: Some(mana - cost)),
      cost * 2,
    )

    _ -> #(player, 0)
  }
}
