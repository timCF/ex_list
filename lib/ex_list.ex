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

  def backends, do: @backends

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
