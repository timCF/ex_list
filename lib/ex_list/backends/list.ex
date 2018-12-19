defmodule ExList.Backends.List do
  use ExList.Macro.Importable do
    use ExList.Monads.Decision
  end

  @type t(a) :: [a]

  # empty
  defmacro list do
    []
  end

  # head and tail where tail is list as well
  defmacro list(head, tail) do
    quote do
      [unquote(head) | unquote(tail)]
    end
  end
end
