defmodule ExList.Protocols.String.CharsTest do
  use ExUnit.Case
  use ExList, backend: :struct
  test "string_chars" do
    ex_list = list("hello", list("world", list("stop", list("please", list()))))
    assert "#ExList<hello, world, stop, please>" == to_string(ex_list)
  end
end
