defmodule ExList.Protocols.EnumerableTest do
  use ExUnit.Case
  use ExList, backend: :struct
  test "enumerable" do
    ex_list = list("hello", list("world", list("stop", list("please", list()))))
    std_list = ["hello", "world", "stop", "please"]
    assert 2 == Enum.reduce_while(ex_list, 0, &((&1 == "stop") && halt(&2) || cont(&2 + 1)))
    assert std_list == Enum.to_list(ex_list)
    assert "stop" == Enum.find(ex_list, &(String.length(&1) < 5))
  end
end
