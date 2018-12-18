defmodule ExList do
  @moduledoc """
  Funny inefficient implementation of linked lists in Elixir language.
  This project is just exercise and joke!
  Don't use it for real code!
  """

  # primitive terms for list elements
  @just :just
  @nothing :nothing

  # primitive types for list elements
  @type just(a) :: {:just, a}
  @type nothing :: :nothing

  # list term
  defstruct [
    head: @nothing,
    tail: @nothing
  ]

  # shortcuts for list elements
  defmacro just(something) do
    quote do
      {unquote(@just), unquote(something)}
    end
  end
  defmacro nothing do
    @nothing
  end

  # list is
  # 1) empty
  # either
  # 2) list is head and tail where tail is list as well
  @type t(a) :: %__MODULE__{head: nothing, tail: nothing} |
                %__MODULE__{head: just(a), tail: just(t(a))}

  # empty
  defmacro list do
    quote do
      %unquote(__MODULE__){
        head: nothing(),
        tail: nothing(),
      }
    end
  end
  # head and tail where tail is list as well
  defmacro list(head, tail) do
    quote do
      %unquote(__MODULE__){
        head: just(unquote(head)),
        tail: just(%unquote(__MODULE__){} = unquote(tail))
      }
    end
  end

  @doc """
  Execute this to use ExList in source code!

  ## Examples

  ```
  iex> use ExList
  ExList
  iex> list()
  %ExList{head: :nothing, tail: :nothing}
  iex> list(1, list())
  %ExList{
    head: {:just, 1},
    tail: {:just, %ExList{head: :nothing, tail: :nothing}}
  }
  iex> list(1, list(2, list()))
  %ExList{
    head: {:just, 1},
    tail: {:just,
     %ExList{
       head: {:just, 2},
       tail: {:just, %ExList{head: :nothing, tail: :nothing}}
     }}
  }
  ```
  """
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
    end
  end
end
