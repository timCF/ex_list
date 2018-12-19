defmodule ExList.Monads.Decision do
  use ExList.Macro.Importable

  @cont :cont
  @halt :halt

  @type t(acc) :: {:cont, acc} | {:halt, acc}

  defmacro cont(something) do
    quote do
      {unquote(@cont), unquote(something)}
    end
  end

  defmacro halt(something) do
    quote do
      {unquote(@halt), unquote(something)}
    end
  end
end
