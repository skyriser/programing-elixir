defmodule Flow do
  # ControlFlow-1
  # ex(1)> Flow.fizz_buzz(30)
  # [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
  #  "FizzBuzz", 16, 17, "Fizz", 19, "Buzz", "Fizz", 22, 23, "Fizz", "Buzz", 26,
  #  "Fizz", 28, 29, "FizzBuzz"]
  def fizz_buzz(n) when n > 0 do
    1..n |> Enum.map(&_fizz_buzz/1)
  end
  defp _fizz_buzz(n) do
    case { rem(n, 3), rem(n, 5) } do
      { 0, 0 } ->
        "FizzBuzz"
      { 0, _ } ->
        "Fizz"
      { _, 0 } ->
        "Buzz"
      _ ->
        n
    end
  end
end
