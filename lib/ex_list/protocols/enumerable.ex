defimpl Enumerable, for: ExList.Backends.Struct do
  use ExList, backend: :struct
  def count(_), do: {:error, __MODULE__}
  def member?(_, _), do: {:error, __MODULE__}
  def slice(_), do: {:error, __MODULE__}

  def reduce(_, {:halt, acc}, _), do: {:halted, acc}
  def reduce(ex_list, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(ex_list, &1, fun)}
  def reduce(list(), {:cont, acc}, _), do: {:done, acc}
  def reduce(list(head, tail), {:cont, acc}, fun), do: reduce(tail, fun.(head, acc), fun)

  def slice(list(), _, _), do: list()
  def slice(_, _, 0), do: list()
  def slice(list(head, tail), 0, count), do: list(head, slice(tail, 0, count - 1))
  def slice(list(_, tail), start, count), do: slice(tail, start - 1, count)
end
