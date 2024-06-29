import gleam/float.{compare}
import gleam/list.{sort}
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Fahrenheit(f1), Fahrenheit(f2) -> compare(f1, f2)
    Celsius(c1), Celsius(c2) -> compare(c1, c2)
    Celsius(c), Fahrenheit(f) -> compare(c, fahrenheit_to_celsius(f))
    Fahrenheit(f), Celsius(c) -> compare(fahrenheit_to_celsius(f), c)
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  sort(cities, fn(city1, city2) {
    compare_temperature(city1.temperature, city2.temperature)
  })
}
