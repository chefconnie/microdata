defmodule Microdata.Document do
  @moduledoc """
  Microdata.Document is the base struct returned after parsing a microdata document.
  """

  @enforce_keys [:items]
  defstruct items: nil
  @type t :: %Microdata.Document{items: [Microdata.Item.t()]}

  @doc """
  Lookup top-level items in the document with matching types.

  ## Examples (not a doctest)

    iex> Microdata.Document.lookup(doc, "foo")
    [%Microdata.Item{types: ["foo"], ...}, ...]

    iex> Microdata.Document.lookup(doc, ["foo", "bar"])
    [
      %Microdata.Item{types: ["foo"], ...},
      %Microdata.Item{types: ["bar"], ...}, ...
    ]
  """
  @spec lookup(Microdata.Document.t(), String.t()) :: [Microdata.Item.t()]
  @spec lookup(Microdata.Document.t(), [String.t()]) :: [Microdata.Item.t()]
  def lookup(_, nil), do: []

  def lookup(doc, item_types) when is_list(item_types) do
    types = MapSet.new(item_types)

    doc.items
    |> Enum.filter(fn item ->
      is_map(item.types) &&
        item.types
        |> MapSet.intersection(types)
        |> MapSet.size() > 0
    end)
  end

  def lookup(doc, item_type) do
    doc.items
    |> Enum.filter(fn item ->
      is_map(item.types) && MapSet.member?(item.types, item_type)
    end)
  end
end
