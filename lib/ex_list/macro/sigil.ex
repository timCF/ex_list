defmodule ExList.Macro.Sigil do
  use ExList.Macro.Importable

  defmacro sigil_l({:<<>>, _, raw_text}, []) do
    {:ok, enumerable} =
      "[#{raw_text}]"
      |> Code.string_to_quoted()

    enumerable
    |> Enum.reverse()
    |> Enum.reduce(
      quote do
        list()
      end,
      fn term, acc ->
        quote do
          list(unquote(term), unquote(acc))
        end
      end
    )
  end
end
