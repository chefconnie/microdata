defmodule Microdata.DocumentTest do
  use ExUnit.Case, async: true

  setup_all do
    doc = %Microdata.Document{
      items: [
        %Microdata.Item{},
        %Microdata.Item{types: MapSet.new(["foo"])},
        %Microdata.Item{types: MapSet.new(["foo", "bar"])},
        %Microdata.Item{types: MapSet.new(["bar"])}
      ]
    }

    {:ok, doc: doc}
  end

  test "can `lookup` items by type", %{doc: doc} do
    assert Microdata.Document.lookup(doc, "foo") == [
             %Microdata.Item{types: MapSet.new(["foo"])},
             %Microdata.Item{types: MapSet.new(["foo", "bar"])}
           ]

    assert Microdata.Document.lookup(doc, ["foo", "bar"]) == [
             %Microdata.Item{types: MapSet.new(["foo"])},
             %Microdata.Item{types: MapSet.new(["foo", "bar"])},
             %Microdata.Item{types: MapSet.new(["bar"])}
           ]

    assert Microdata.Document.lookup(doc, "baz") == []
    assert Microdata.Document.lookup(doc, nil) == []
  end
end
