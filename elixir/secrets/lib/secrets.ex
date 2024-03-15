defmodule Secrets do
  def secret_add(secret), do: &Kernel.+(&1, secret)
  def secret_subtract(secret), do: &Kernel.-(&1, secret)
  def secret_multiply(secret), do: &Kernel.*(&1, secret)
  # NOTE: div/2 used for integer division, instead of / which returns a float
  def secret_divide(secret), do: &Kernel.div(&1, secret)
  def secret_and(secret), do: &Bitwise.band(&1, secret)
  def secret_xor(secret), do: &Bitwise.bxor(&1, secret)

  def secret_combine(secret_function1, secret_function2),
    # NOTE: secret_function1 and secret_function2 are anonymous functions
    # (returned via the above helpers). Hence needing the `.`
    do: &(&1 |> secret_function1.() |> secret_function2.())
end
