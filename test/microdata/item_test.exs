defmodule Microdata.ItemTest do
  use ExUnit.Case, async: true
  doctest Microdata.Item, except: [lookup: 2]

  setup_all do
    item = %Microdata.Item{
      properties: [
        %Microdata.Property{names: MapSet.new(["foo"]), value: "xyz"},
        %Microdata.Property{names: MapSet.new(["foo", "bar"]), value: "xyz"},
        %Microdata.Property{names: MapSet.new(["bar"]), value: "xyz"}
      ]
    }

    {:ok, item: item}
  end

  test "can `lookup` items by type", %{item: item} do
    assert Microdata.Item.lookup(item, "foo") == [
             %Microdata.Property{names: MapSet.new(["foo"]), value: "xyz"},
             %Microdata.Property{names: MapSet.new(["foo", "bar"]), value: "xyz"}
           ]

    assert Microdata.Item.lookup(item, ["foo", "bar"]) == [
             %Microdata.Property{names: MapSet.new(["foo"]), value: "xyz"},
             %Microdata.Property{names: MapSet.new(["foo", "bar"]), value: "xyz"},
             %Microdata.Property{names: MapSet.new(["bar"]), value: "xyz"}
           ]

    assert Microdata.Item.lookup(item, "baz") == []
    assert Microdata.Item.lookup(item, nil) == []
  end
end
