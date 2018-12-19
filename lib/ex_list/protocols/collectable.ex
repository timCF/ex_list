defimpl Collectable, for: ExList.Backends.Struct do
  use ExList, backend: :struct

  def into(original) do
    fun = fn
      ex_list, {:cont, x} -> list(x, ex_list)
      ex_list, :done -> original |> ExList.concat(ex_list |> ExList.reverse())
      _, :halt -> :ok
    end

    {list(), fun}
  end
end
