defmodule Parse do
  def number([?- | tail]), do: _number_digits(tail, 0) * -1
  def number([?+ | tail]), do: _number_digits(tail, 0)
  def number(str),         do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([digit | tail], value) when digit in '0123456789' do
    _number_digits(tail, value * 10 + digit - ?0)
  end
  defp _number_digits([non_digit | _], _) do
    raise "Invalid digit '#{non_digit}'"
  end

  # StringsAndBinaries-1
  # スペース = 32, チルダ = 126
  # iex(5)> Parse.number(' ')
  # ** (RuntimeError) Invalid digit '32'
  # iex(5)> Parse.number('~')
  # ** (RuntimeError) Invalid digit '126'
  # Parse.printable?('ASCII STRING_')
  # true
  # iex(11)> Parse.printable?('NON ASCII あ')
  # false
  def printable?(strings), do: _printable?(strings)
  defp _printable?([head | _tail]) when head < 32, do: false
  defp _printable?([head | _tail]) when head > 126, do: false
  defp _printable?([_head | tail]), do: _printable?(tail)
  defp _printable?(_char), do: true

  # StringsAndBinaries-2
  # シングルクォートの場合は単なるリスト
  # iex(1)> Parse.anagram?('elixir', 'eliirx')
  # true
  # iex(2)> Parse.anagram?('elixir', 'eliirX')
  # false
  def anagram?(word1, word2), do: Enum.sort(word1) === Enum.sort(word2)

  # StringsAndBinaries-3
  # iex(4)> ['cat' | 'dog']
  # ['cat', 100, 111, 103]
  #
  # シングルクォートの場合は文字列ではなく単なるリスト
  # 'dog'も[100, 111, 103]というリストである
  # ex(10)> [100, 111, 103]
  # 'dog'
  #
  # [head | tail] 形式なので後尾にtailというリストを追加することになる
  # headはリストとしてprintableであるので文字列として表示される
  # tailは"まずリストとして解釈されたあと"、追加されることになる
  # (tailがprintableであるかどうかにかかわらず3つの要素である整数リストとして追加されるということ
  #
  # シンプルに理解するならば
  # ex(16)> [[99, 97, 116] | [100, 111, 103]]
  # ['cat', 100, 111, 103]
  #
  # であるし、もっと正確に書くならば
  # iex(17)> [[99, 97, 116], 100, 111, 103]
  # ['cat', 100, 111, 103]
  # という結果になっている

  # StringsAndBinaries-4
  # ex(1)> Parse.calculate('123 + 27')
  # 150
  # iex(2)> Parse.calculate('123 - 27')
  # 96
  # iex(3)> Parse.calculate('123 * 27')
  # 3321
  # iex(4)> Parse.calculate('123 / 27')
  # 4.555555555555555
  def calculate(formula) do
    # '123 + 27' => {'123 ', '+ 27}
    {num1, num2_with_operator} = Enum.split_while(formula, fn(x) -> x not in '+-*/' end)
    # '+ 27' => {'+', ' 27'}
    {operator, num2} = Enum.split_while(num2_with_operator, fn(x) -> x in '+-*/' end)
    # ' 'を排除
    num1 = Enum.filter(num1, fn(x) -> x != 32 end)
    num2 = Enum.filter(num2, fn(x) -> x != 32 end)

    _operate(num1, num2, operator)
  end
  defp _operate(num1, num2, operator) when operator == '+', do: number(num1) + number(num2)
  defp _operate(num1, num2, operator) when operator == '-', do: number(num1) - number(num2)
  defp _operate(num1, num2, operator) when operator == '*', do: number(num1) * number(num2)
  defp _operate(num1, num2, operator) when operator == '/', do: number(num1) / number(num2)

  # StringsAndBinaries-5
  # iex(1)> Parse.center(["cat", "zebra", "elephant"])
  #   cat
  #  zebra
  # elephant
  # :ok
  # iex(3)> Parse.center(["あ", "zeいra", "eleうaえt"])
  #    あ
  #  zeいra
  # eleうaえt
  # ex(2)> Parse.center(["a", "bb", "ccccc"])
  #   a
  #  bb
  # ccccc
  # :ok
  def center(strings) do
    max_length = _max_length(strings)
    Enum.each(strings, fn
      string ->
        pad_count = String.length(string) + _lpad_count(string, max_length)
        # rjustはdeprecated
        IO.puts(String.pad_leading(string, pad_count))
    end)
  end
  # バイナリ内の最大長を計算
  defp _max_length(strings), do: String.length(Enum.max_by(strings, fn x -> String.length(x) end))
  # 左右で均等にスペースが分布するとは限らない (ex) max = 5ならleft = 2, right = 3に分離する
  # rpadはスペースになるだけなので事実上不要
  defp _lpad_count(string, max_length), do: trunc((max_length - String.length(string)) / 2)

  # StringsAndBinaries-6
  # 不完全版 最後尾に"."が残る
  # 空のEnumを排除する必要がある
  # iex(1)> Parse.capitalize_sentences("oh. a DOG. woof. ")
  # "Oh. A dog. Woof. ."
  def capitalize_sentences(paragraph) do
    # ". "ごとに区切り、sentenceごとにcapitalizeしてjoin
    paragraph
    |> _split
    |> _add_period
    |> _capitalize
    |> _join
  end
  defp _split(paragraph), do: String.split(paragraph, ". ")
  defp _add_period(sentences) do
    Enum.map sentences, fn sentence ->
      case String.ends_with?(sentence, ".") do
        true ->
          sentence
        false ->
          sentence <> "."
      end
    end
  end
  defp _capitalize(sentences) do
    Enum.map sentences, fn sentence ->
      String.capitalize(sentence)
    end
  end
  defp _join(sentences), do: Enum.join(sentences, " ")

  # StringsAndBinaries-7
  def total_amount do
    # tax_rates = [NC: 0.075, TX: 0.08]
    {:ok, file} = File.open("../etc/ship_list.csv")
    Enum.map IO.stream(file, :line), fn line ->
      IO.puts(line)
    end
    File.close(file)
  end
end
