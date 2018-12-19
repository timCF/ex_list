defmodule ExList do
  @moduledoc """
  Funny inefficient implementation of linked lists in Elixir language.
  This project is just exercise and joke!
  Don't use it for real code!
  """

  @default_backend :struct
  @backends %{
    struct: ExList.Backends.Struct,
    tuple: ExList.Backends.Tuple,
    list: ExList.Backends.List
  }

  @doc """
  Map of backends for ExList implementations

  ## Example

  ```
  iex> ExList.backends
  #{@backends |> inspect}
  ```
  """
  def backends, do: @backends

  @doc """
  Macro enables ExList backend. Have optional 2nd :backend argument

  ## Example

  ```
  iex> use ExList
  ExList.Backends.Struct.Utils

  iex> use ExList, backend: :struct
  ExList.Backends.Struct.Utils

  iex> use ExList, backend: :tuple
  ExList.Backends.Tuple.Utils

  iex> use ExList, backend: :list
  ExList.Backends.List.Utils

  iex> quote do use ExList, backend: :hello_world end |> Code.eval_quoted
  ** (RuntimeError) invalid backend opts [backend: :hello_world]
  ```
  """
  defmacro __using__(opts) do
    backend =
      opts
      |> case do
        [] -> Map.get(@backends, @default_backend)
        [backend: backend] -> Map.get(@backends, backend)
      end
      |> case do
        nil -> raise("invalid backend opts #{inspect(opts)}")
        backend when is_atom(backend) -> backend
      end

    backend_utils =
      backend
      |> Module.concat(Utils)

    quote do
      use unquote(backend)
      alias unquote(backend_utils), as: unquote(__MODULE__)
    end
  end
end
