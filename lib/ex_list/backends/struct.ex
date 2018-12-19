defmodule ExList.Backends.Struct do
  use ExList.Macro.Importable do
    use ExList.Monads.Decision
  end

  defstruct head: nil,
            tail: nil

  @type t(a) :: %__MODULE__{head: nil, tail: nil} | %__MODULE__{head: a, tail: t(a)}

  # empty
  defmacro list do
    quote do
      %unquote(__MODULE__){
        head: nil,
        tail: nil
      }
    end
  end

  # head and tail where tail is list as well
  defmacro list(head, tail) do
    quote do
      %unquote(__MODULE__){
        head: unquote(head),
        tail: %unquote(__MODULE__){} = unquote(tail)
      }
    end
  end
end
