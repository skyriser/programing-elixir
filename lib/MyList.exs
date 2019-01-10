defmodule MyList do
  # ListsAndRecursion-0
  # MyList.sum([1, 2, 3])
  # 6
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  # ListsAndRecursion-1
  # > MyList.mapsum [1, 2, 3], &(&1 * &1)
  # 14
  def mapsum(list, func), do: _sum(_map(list, func))
  defp _map([], _func), do: []
  defp _map([head | tail], func), do: [func.(head) | _map(tail, func)]
  defp _sum([]), do: 0
  defp _sum([head | tail]), do: head + _sum(tail)

  # ListsAndRecursion-2
  # > MyList.max([99, 33, 33])
  # 99
  def max([head | tail]), do: _max(tail, head)
  defp _max([], max), do: max
  defp _max([head | tail], max) when head >= max, do: _max(tail, head)
  defp _max([head | tail], max) when head < max, do: _max(tail, max)

  # ListsAndRecursion-3
  # > MyList.caesar('ryvkve', 13)
  # 'elixir'
  def caesar([], _), do: []
  def caesar([head | tail], n) when (head + n) > 122, do: [head + n - 26 | caesar(tail, n)]
  def caesar([head | tail], n) when (head + n) < 122, do: [head + n | caesar(tail, n)]

  # ListsAndRecursion-4
  # > MyList.span(1,10)
  # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  def span(to, to), do: [to]
  def span(from, to), do: [from | span(from + 1, to)]

  # ListsAndRecursion-5-1
  # iex(2)> MyList.all?([1, 2, 3, 4, 5], &(&1 < 4))
  # false
  # iex(6)> MyList.all?([1, 2, 3], &(&1 < 4))
  # true
  # iex(2)> MyList.all?([], &(&1 < 4))
  # true
  def all?(list, func), do: _all?(list, func)
  defp _all?([], _func), do: true
  defp _all?([head | tail], func), do: func.(head) && _all?(tail, func)

  # ListsAndRecursion-5-2
  # iex(3)> Enum.each([1, 2, 3], &(IO.inspect(&1)))
  # 1
  # 2
  # 3
  # :ok
  def each(list, func), do: _each(list, func)
  defp _each([], _func), do: :ok
  defp _each([head | tail], func) do
    func.(head)
    _each(tail, func)
  end

  # ListsAndRecursion-5-3
  # iex(1)> MyList.filter([1, 2, 3], &(&1 > 1))
  # [2, 3]
  def filter(list, func), do: _filter(list, func)
  defp _filter([], _func), do: []
  defp _filter([head | tail], func) do
    if func.(head) do
      [head | _filter(tail, func)]
    else
      _filter(tail, func)
    end
  end

  # ListsAndRecursion-5-4
  # iex(4)> MyList.split([1, 2, 3, 4], 3)
  # {[1, 2, 3], [4]}
  # iex(5)> MyList.split([], 3)
  # {[], []}
  def split(list, count), do: {_lsplit(list, count), _rsplit(list, count)}
  defp _lsplit([], _count), do: []
  defp _lsplit(_list, 0), do: []
  defp _lsplit([head | tail], count), do: [head | _lsplit(tail, count - 1)]
  defp _rsplit([], _count), do: []
  defp _rsplit(list, 0), do: list
  defp _rsplit([_head | tail], count), do: _rsplit(tail, count - 1)

  # ListsAndRecursion-5-5
  # iex(5)> MyList.take([1, 2, 3, 4], 3)
  # [1, 2, 3]
  def take(list, count), do: _take(list, count)
  defp _take([], _count), do: []
  defp _take(_list, 0), do: []
  defp _take([head | tail], count), do: [head | _take(tail, count - 1)]

  # ListsAndRecursion-6
  # ex(1)> MyList.flatten([1, [2, 3, [4]], 5, [[[6]], 7], 8])
  # [1, 2, 3, 4, 5, 6, 7, 8]
  # iex(2)> MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]])
  # [1, 2, 3, 4, 5, 6]
  def flatten(list), do: _flatten(list)
  defp _flatten([]), do: []
  defp _flatten([head | tail]), do: _flatten(head) ++ _flatten(tail)
  defp _flatten(element), do: [element]

  # ListsAndRecursion-7
  # Eratosthenes algorythm (https://mathtrain.jp/eratosthenes)
  # iex(2)> MyList.prime_numbers(50)
  # [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
  def prime_numbers(to) when to > 1, do: _prime_numbers(span(2, to), to)
  defp _prime_numbers(list = [head | tail], to) do
    if (:math.sqrt(to) < head) do # root(to)を超えたら終了
      list
    else
      # 先頭の倍数をすべてfilter
      mutiple_filtered_list = for x <- list, rem(x, head) != 0, do: x
      [head | _prime_numbers(mutiple_filtered_list, to)]
    end
  end
end
