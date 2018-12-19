defmodule ExList.UtilsTest do
  use ExUnit.Case

  ExList.backends()
  |> Enum.each(fn {backend_alias, backend_module} ->
    doctest Module.concat(backend_module, Utils)
    test "test #{inspect backend_alias}" do
      use ExList, backend: unquote(backend_alias)
      left = list("Hello", list("beautiful", list()))
      right = list("AST", list("world", list()))
      full = ExList.concat(left, right)
      assert full == list("Hello", list("beautiful", list("AST", list("world", list()))))
      assert "Hello beautiful AST world" == ExList.reduce(full, "", fn
        word, "" -> word
        word, acc -> "#{acc} #{word}"
      end)
    end
    test "test #{inspect backend_alias} sigil" do
      use ExList, backend: unquote(backend_alias)
      ex_list = list("hello", list("world", list()))
      assert ex_list == ~l/"hello", "world"/
      assert list() == ~l//
    end
  end)
end
