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
end
