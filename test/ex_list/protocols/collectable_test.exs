defmodule ExList.Protocols.CollectableTest do
  use ExUnit.Case
  use ExList, backend: :struct

  test "collectable" do
    ex_list = list("hello", list("world", list("stop", list("please", list()))))
    std_list = ["hello", "world", "stop", "please"]
    assert ex_list == Enum.into(std_list, list())
  end
end
