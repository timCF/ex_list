defmodule ExList.Protocols.InspectTest do
  use ExUnit.Case
  use ExList, backend: :struct

  test "inspect" do
    ex_list = list("hello", list("world", list("stop", list("please", list()))))
    assert "#ExList<\"hello\", \"world\", \"stop\", \"please\">" == inspect(ex_list)
  end
end
