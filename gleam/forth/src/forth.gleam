import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Forth {
  Forth(stack: List(String))
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

pub fn new() -> Forth {
  Forth([])
}

pub fn format_stack(f: Forth) -> String {
  string.join(f.stack, " ")
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  let stack = string.split(prog, " ") |> list.append(f.stack, _)
  let evaluated_stack = eval_stack(stack)

  case evaluated_stack {
    Ok(evaluated_stack) -> Ok(Forth(stack: evaluated_stack))
    Error(err) -> Error(err)
  }
}

fn eval_stack(stack: List(String)) -> Result(List(String), ForthError) {
  case stack {
    [arg1, arg2, "+", ..stack] -> {
      Ok([handle_arithmetic(arg1, arg2, Add), ..stack])
    }
    [arg1, arg2, "-", ..stack] -> {
      Ok([handle_arithmetic(arg1, arg2, Subtract), ..stack])
    }
    [arg1, arg2, "*", ..stack] -> {
      Ok([handle_arithmetic(arg1, arg2, Multiply), ..stack])
    }
    [arg1, arg2, "/", ..stack] -> {
      Ok([handle_arithmetic(arg1, arg2, Divide), ..stack])
    }

    [_, "+"] -> Error(StackUnderflow)
    ["+"] -> Error(StackUnderflow)

    [_, "-"] -> Error(StackUnderflow)
    ["-"] -> Error(StackUnderflow)

    [_, "*"] -> Error(StackUnderflow)
    ["*"] -> Error(StackUnderflow)

    [_, "/"] -> Error(StackUnderflow)
    ["/"] -> Error(StackUnderflow)

    _ -> Ok(stack)
  }
}

fn handle_arithmetic(arg1: String, arg2: String, operand: Operand) -> String {
  let operation = case operand {
    Add -> int.add
    Subtract -> int.subtract
    // TODO: Better error handling here?
    Divide -> fn(arg1, arg2) { int.divide(arg1, arg2) |> result.unwrap(0) }
    Multiply -> int.multiply
  }

  // TODO: Refactor out the `let assert` usage
  let assert Ok(arg1) = int.parse(arg1)
  let assert Ok(arg2) = int.parse(arg2)
  int.to_string(operation(arg1, arg2))
}

type Operand {
  Add
  Subtract
  Multiply
  Divide
}
