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
end
