defmodule Microdata.Helpers do
  @moduledoc """
  Microdata.Helpers is a module for generic parsing helpers (ie those not coupled to the parsing mechanism).

  For example, certain tags require their values to be absolute URLs.
  """

  @doc """
  Validates that URLs include scheme & host

  ## Examples

    iex> Microdata.Helpers.validate_url("foo")
    {:error, "No scheme"}

    iex> Microdata.Helpers.validate_url("http://")
    {:error, "No host"}

    iex> Microdata.Helpers.validate_url("http://foo.com")
    {:ok, "http://foo.com"}
  """
  @spec validate_url(String.t()) :: {:error, String.t()} | {:ok, String.t()}
  def validate_url(url) do
    case URI.parse(url) do
      %URI{scheme: nil} -> {:error, "No scheme"}
      %URI{host: nil} -> {:error, "No host"}
      _ -> {:ok, url}
    end
  end

  @doc """
  Helper function to determine if a passed URL is absolute. Returns true/false bools.

  ## Examples

    iex> Microdata.Helpers.absolute_url?(nil)
    false

    iex> Microdata.Helpers.absolute_url?("path/to/page")
    false

    iex> Microdata.Helpers.absolute_url?("/path/to/page")
    false

    iex> Microdata.Helpers.absolute_url?("https://google.com")
    true
  """
  @spec absolute_url?(String.t()) :: boolean
  def absolute_url?(nil), do: false

  def absolute_url?(url) do
    case Microdata.Helpers.validate_url(url) do
      {:ok, _} -> true
      _ -> false
    end
  end

  # Microdata.Item helpers
  @doc """
  Parse item types from a space-separated string.

  ## Examples
    iex> Microdata.Helpers.parse_item_types(nil)
    nil

    iex> Microdata.Helpers.parse_item_types("foo")
    ["foo"]

    iex> Microdata.Helpers.parse_item_types("foo bar")
    ["foo", "bar"]

    iex> Microdata.Helpers.parse_item_types("\\n\\nfoo bar baz   \\n ")
    ["foo", "bar", "baz"]
  """
  @spec parse_item_types(String.t()) :: [String.t()]
  def parse_item_types(nil), do: nil
  def parse_item_types(string), do: string |> String.trim() |> String.split(" ")

  @doc """
  Parse item id from a provided string.

  ## Examples

    iex> Microdata.Helpers.parse_item_id(nil)
    nil

    iex> Microdata.Helpers.parse_item_id("\\r foo   \\n")
    URI.parse("foo")

    iex> Microdata.Helpers.parse_item_id("https://google.com")
    URI.parse("https://google.com")
  """

  @spec parse_item_id(String.t()) :: URI.t()
  def parse_item_id(nil), do: nil
  def parse_item_id(string), do: string |> String.trim() |> URI.parse()

  # Microdata.Property helpers
  @doc """
  Parse property names from a provided string.

  ## Examples

    iex> Microdata.Helpers.parse_property_names(nil)
    nil

    iex> Microdata.Helpers.parse_property_names("bar", %Microdata.Item{types: MapSet.new(["foo"])})
    ["foo/bar"]

    iex> Microdata.Helpers.parse_property_names("\\rbar baz bar   \\n", %Microdata.Item{types: MapSet.new(["foo"])})
    ["foo/bar", "foo/baz"]
  """
  @spec parse_property_names(String.t(), Microdata.Item.t()) :: [String.t()]
  def parse_property_names(nil), do: nil

  def parse_property_names(string, item) do
    string
    |> String.trim()
    |> String.split(" ")
    |> Enum.reduce([], fn name, names ->
      parse_property_name(name, item, names)
    end)
    |> Enum.reverse()
  end

  defp parse_property_name(name, item, names) do
    cond do
      Enum.member?(names, name) ->
        names

      Microdata.Helpers.absolute_url?(name) ->
        [name | names]

      true ->
        vocabulary = Microdata.Item.vocabulary(item)

        if vocabulary != nil do
          name = "#{vocabulary}#{name}"

          if Enum.member?(names, name), do: names, else: [name | names]
        else
          [name | names]
        end
    end
  end
end
