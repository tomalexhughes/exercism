import gleam/list
import gleam/result
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.new() |> set.insert(card)
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  case set.contains(collection, card) {
    True -> #(True, collection)
    False -> #(False, set.insert(collection, card))
  }
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let have_desired_card = collection |> set.contains(my_card)
  let have_their_card = collection |> set.contains(their_card)
  let collection_after_trading =
    collection |> set.delete(my_card) |> set.insert(their_card)

  case have_desired_card, have_their_card {
    True, False -> #(True, collection_after_trading)
    _, _ -> #(False, collection_after_trading)
  }
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  list.reduce(collections, set.intersection)
  |> result.unwrap(set.new())
  |> set.to_list
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  list.fold(collections, set.new(), set.union) |> set.size
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection
  |> set.filter(keeping: fn(card) { string.starts_with(card, "Shiny ") })
}
