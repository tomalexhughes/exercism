import gleam/int.{max}
import gleam/option.{type Option, None, Some, unwrap}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 if player.level >= 10 ->
      Some(Player(..player, health: 100, mana: option.Some(100)))
    0 -> Some(Player(..player, health: 100))
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    None -> #(Player(..player, health: max(player.health - cost, 0)), 0)

    Some(mana) if cost <= mana -> #(
      Player(..player, mana: Some(mana - cost)),
      cost * 2,
    )

    _ -> #(player, 0)
  }
}
