defmodule Microdata.Strategy.HTMLMicrodata do
  @moduledoc """
  `Microdata.Strategy.HTMLMicrodata` defines a strategy to extract HTML microdata from a `Meeseeks.Document`, based on the W3C [HTML Microdata format](https://www.w3.org/TR/microdata/).

  ### Caveats
  - `itemref` lookups are not yet supported
  """

  @behaviour Microdata.Strategy

  import Meeseeks.XPath

  alias Microdata.{Helpers, Item, Property}

  @tags_src ~w(audio embed iframe img source track video)
  @tags_href ~w(a area link)
  @tags_data ~w(object)
  @tags_value ~w(data meter)
  @tags_datetime ~w(datetime)

  @impl true
  def parse_items(doc, base_uri \\ nil) do
    parse_items(doc, 0, base_uri)
  end

  defp parse_items(doc, nest_level, base_uri, items \\ []) do
    selector =
      if nest_level == 0 do
        "/*[@itemscope]|//*[@itemscope and count(ancestor::*[@itemscope]) = 0]"
      else
        "//*[@itemscope and not(@itemprop) and count(ancestor::*[@itemscope]) = #{nest_level}]"
      end

    doc
    |> Meeseeks.all(xpath(selector))
    |> Enum.map(&parse_item(&1, nest_level, base_uri))
    |> case do
      new_items when new_items != [] ->
        parse_items(doc, nest_level + 1, base_uri, new_items ++ items)

      _ ->
        items
    end
  end

  defp parse_item(item, nest_level, base_uri) do
    item_model = %Item{
      id: item |> Meeseeks.attr("itemid") |> Helpers.parse_item_id(),
      types:
        item
        |> Meeseeks.attr("itemtype")
        |> Helpers.parse_item_types()
        |> MapSet.new()
    }

    %{item_model | properties: parse_properties(item, item_model, nest_level, base_uri)}
  end

  defp parse_properties(item, item_model, nest_level, base_uri) do
    selector = ".//*[@itemprop and count(ancestor::*[@itemscope]) = #{nest_level + 1}]"

    item
    |> Meeseeks.all(xpath(selector))
    |> Enum.map(fn prop -> parse_property(prop, item_model, nest_level, base_uri) end)
  end

  defp parse_property(property, item, nest_level, base_uri) do
    %Property{
      names: property |> parse_property_names(item) |> MapSet.new(),
      value: parse_property_value(property, nest_level, base_uri),
      html: Meeseeks.html(property)
    }
  end

  defp parse_property_names(property, item) do
    property
    |> Meeseeks.attr("itemprop")
    |> Helpers.parse_property_names(item)
  end

  # credo:disable-for-lines:35 Credo.Check.Refactor.CyclomaticComplexity
  defp parse_property_value(property, nest_level, base_uri) do
    tag = Meeseeks.tag(property)
    itemscope = Meeseeks.attr(property, "itemscope")
    content = Meeseeks.attr(property, "content")

    cond do
      itemscope != nil ->
        parse_item(property, nest_level + 1, base_uri)

      content != nil ->
        content

      Enum.member?(@tags_src, tag) ->
        Meeseeks.attr(property, "src")
        |> parse_property_uri(base_uri)

      Enum.member?(@tags_href, tag) ->
        Meeseeks.attr(property, "href")
        |> parse_property_uri(base_uri)

      Enum.member?(@tags_data, tag) ->
        Meeseeks.attr(property, "data")
        |> parse_property_uri(base_uri)

      Enum.member?(@tags_value, tag) ->
        value = Meeseeks.attr(property, "value")
        if value != nil, do: value, else: Meeseeks.text(property)

      Enum.member?(@tags_datetime, tag) ->
        value = Meeseeks.attr(property, "datetime")
        if value != nil, do: value, else: Meeseeks.text(property)

      true ->
        Meeseeks.text(property)
    end
  end

  defp parse_property_uri(uri, base) do
    cond do
      Helpers.absolute_url?(uri) -> uri
      Helpers.absolute_url?(base) -> URI.merge(base, uri) |> URI.to_string()
      true -> ""
    end
  end
end
