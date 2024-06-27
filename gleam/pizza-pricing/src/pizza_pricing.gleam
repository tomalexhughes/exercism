pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(pizza) -> pizza_price(pizza) + 1
    ExtraToppings(pizza) -> pizza_price(pizza) + 2
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let additional_fee = case order {
    [_] -> 3
    [_, _] -> 2
    _ -> 0
  }

  order_price_loop(order, additional_fee)
}

fn order_price_loop(order: List(Pizza), total: Int) -> Int {
  case order {
    [pizza, ..rest] -> order_price_loop(rest, total + pizza_price(pizza))
    [] -> total
  }
}
