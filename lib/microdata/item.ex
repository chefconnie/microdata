defmodule Microdata.Item do
  @moduledoc """
  Microdata.Item structs are read from a microdata document.
  """

  defstruct types: nil, id: nil, properties: nil

  @type t :: %Microdata.Item{
          types: MapSet.t(String.t()),
          id: URI.t(),
          properties: [Microdata.Property.t()]
        }

  @doc """
  Resolve the vocabulary of a typed item or list of types.

  ## Examples

    iex> Microdata.Item.vocabulary(%Microdata.Item{})
    nil

    iex> Microdata.Item.vocabulary(%Microdata.Item{types: MapSet.new(["foo"])})
    "foo/"

    iex> Microdata.Item.vocabulary(["foo", "bar"])
    "foo/"

    iex> Microdata.Item.vocabulary(["foo#bar"])
    "foo"

    iex> Microdata.Item.vocabulary(["foo/bar"])
    "foo/"

    iex> Microdata.Item.vocabulary(["foo/bar/baz"])
    "foo/bar/"
  """
  @spec vocabulary(Microdata.Item.t()) :: String.t() | nil
  @spec vocabulary(MapSet.t()) :: String.t() | nil
  def vocabulary(%Microdata.Item{types: types}), do: vocabulary(types)

  def vocabulary(types) when is_map(types) or is_list(types) do
    types
    |> Enum.map(&parse_vocabulary_from_type/1)
    |> List.first()
  end

  def vocabulary(_), do: nil

  @doc """
  Lookup item properties with matching names.

  ## Examples (not a doctest)

    iex> Microdata.Item.lookup(item, "foo")
    [%Microdata.Property{names: ["foo"], ...}, ...]

    iex> Microdata.Item.lookup(["foo", "bar"])
    [
      %Microdata.Property{names: ["foo"], ...},
      %Microdata.Property{names: ["bar"], ...}, ...
    ]
  """
  @spec lookup(Microdata.Item.t(), String.t()) :: [Microdata.Property.t()]
  @spec lookup(Microdata.Item.t(), [String.t()]) :: [Microdata.Property.t()]
  def lookup(_, nil), do: []

  def lookup(item, prop_names) when is_list(prop_names) do
    names = MapSet.new(prop_names)

    item.properties
    |> Enum.filter(fn property ->
      is_map(property.names) &&
        property.names
        |> MapSet.intersection(names)
        |> MapSet.size() > 0
    end)
  end

  def lookup(item, prop_names) do
    item.properties
    |> Enum.filter(fn property ->
      is_map(property.names) && MapSet.member?(property.names, prop_names)
    end)
  end

  # Utility functions
  defp parse_vocabulary_from_type(type) do
    cond do
      String.contains?(type, "#") ->
        type
        |> String.split("#", parts: 2)
        |> List.first()

      String.contains?(type, "/") ->
        [_ | tail] = type |> String.split("/") |> Enum.reverse()
        "#{tail |> Enum.reverse() |> Enum.join("/")}/"

      true ->
        "#{type}/"
    end
  end
end
