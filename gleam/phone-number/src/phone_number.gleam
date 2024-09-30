import gleam/regex
import gleam/result
import gleam/string

pub fn clean(input: String) -> Result(String, String) {
  Ok(input)
  |> result.try(validate_no_special_characters)
  |> result.try(validate_no_letters)
  |> result.try(validate_length)
  |> result.try(validate_country_code)
  |> result.try(validate_area_code)
  |> result.try(validate_exchange_code)
}

fn validate_length(input: String) -> Result(String, String) {
  case string.length(remove_non_letters(input)) {
    n if n < 10 -> Error("must not be fewer than 10 digits")
    n if n > 11 -> Error("must not be greater than 11 digits")
    _ -> Ok(input)
  }
}

fn validate_country_code(input: String) -> Result(String, String) {
  let input = remove_non_letters(input)

  // NOTE: We run this after `validate_length` so we can be sure it is either 10/11 digits
  case string.to_graphemes(input), string.length(input) {
    _, 10 -> Ok(input)
    // TODO: Change this so that we more explicitly call `remove_non_letters` - rather than as a side-effect of this function
    ["1", ..], 11 -> Ok(string.drop_left(input, 1))
    _, _ -> Error("11 digits must start with 1")
  }
}

// NOTE: This relies on the country code already being stripped by `validate_country_code`
fn validate_area_code(input: String) -> Result(String, String) {
  let input = remove_non_letters(input)

  case input {
    "0" <> _ -> Error("area code cannot start with zero")
    "1" <> _ -> Error("area code cannot start with one")
    // TODO: Change this so that we more explicitly call `remove_non_letters` - rather than as a side-effect of this function
    _ -> Ok(input)
  }
}

// NOTE: This relies on the country code already being stripped by `validate_country_code`
fn validate_exchange_code(input: String) -> Result(String, String) {
  let exchange_code = remove_non_letters(input) |> string.slice(3, 3)
  case exchange_code {
    "0" <> _ -> Error("exchange code cannot start with zero")
    "1" <> _ -> Error("exchange code cannot start with one")
    _ -> Ok(input)
  }
}

fn validate_no_letters(input: String) -> Result(String, String) {
  let assert Ok(re) = regex.from_string("[A-Za-z]")
  case regex.check(re, content: input) {
    True -> Error("letters not permitted")
    False -> Ok(input)
  }
}

fn validate_no_special_characters(input: String) -> Result(String, String) {
  let assert Ok(re) = regex.from_string("^[+a-zA-Z0-9\\(\\)\\-\\. ]+$")
  case regex.check(re, content: input) {
    True -> Ok(input)
    False -> Error("punctuations not permitted")
  }
}

fn remove_non_letters(input: String) -> String {
  let assert Ok(re) = regex.from_string("\\D")
  regex.replace(each: re, in: input, with: "")
}
