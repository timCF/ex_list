defimpl String.Chars, for: ExList.Backends.Struct do
  use ExList, backend: :struct

  def to_string(ex_list) do
    payload =
      ex_list
      |> ExList.reduce("", fn
        x, "" -> Kernel.to_string(x)
        x, acc -> "#{acc}, #{Kernel.to_string(x)}"
      end)

    "#ExList<#{payload}>"
  end
end
