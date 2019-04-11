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

  # ControlFlow-2
  # 制御構文の使い分けについては以下が参考になる
  # https://elixir-lang.org/getting-started/case-cond-and-if.html
  # 可読性ならcase。条件考慮を1条件に絞れるので見やすい。
  # condは評価条件が複雑な場合に使う？(でもそれってそもそも条件を他関数に分離するべきでは)
  # ガード節付き関数は冗長になりやすい気がする
  # 実際のコードを書く際は、これらの使い分けはコンテクスト次第で考えたい
end
