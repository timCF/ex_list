defmodule ExList.UtilsTest do
  use ExUnit.Case

  ExList.backends()
  |> Enum.each(fn {_, backend_module} ->
    doctest Module.concat(backend_module, Utils)
  end)
end
