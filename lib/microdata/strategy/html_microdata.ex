defmodule Microdata.Strategy.HTMLMicrodata do
  @moduledoc """
  `HTMLMicrodata` defines a strategy to extract HTML microdata from a `Meeseeks.Document`, based on the W3C [HTML Microdata format](https://www.w3.org/TR/microdata/).

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
  def parse_items(doc) do
    doc
    |> Meeseeks.all(xpath("/*[@itemscope]|//*[@itemscope][not(ancestor::*[@itemscope][1])]"))
    |> Enum.map(&parse_item/1)
  end

  defp parse_item(item, nest_level \\ 2) do
    item_model = %Item{
      id: item |> Meeseeks.attr("itemid") |> Helpers.parse_item_id(),
      types:
        item
        |> Meeseeks.attr("itemtype")
        |> Helpers.parse_item_types()
        |> MapSet.new()
    }

    %{item_model | properties: parse_properties(item, item_model, nest_level)}
  end

  defp parse_properties(item, item_model, nest_level) do
    selector = ".//*[@itemprop][not(ancestor::*[@itemscope][#{nest_level}])]"

    item
    |> Meeseeks.all(xpath(selector))
    |> Enum.map(fn prop -> parse_property(prop, item_model, nest_level) end)
  end

  defp parse_property(property, item, nest_level) do
    %Property{
      names: property |> parse_property_names(item) |> MapSet.new(),
      value: parse_property_value(property, nest_level)
    }
  end

  defp parse_property_names(property, item) do
    property
    |> Meeseeks.attr("itemprop")
    |> Helpers.parse_property_names(item)
  end

  # credo:disable-for-lines:35 Credo.Check.Refactor.CyclomaticComplexity
  defp parse_property_value(property, nest_level) do
    tag = Meeseeks.tag(property)
    itemscope = Meeseeks.attr(property, "itemscope")
    content = Meeseeks.attr(property, "content")

    cond do
      itemscope != nil ->
        parse_item(property, nest_level + 1)

      content != nil ->
        content

      Enum.member?(@tags_src, tag) ->
        url = Meeseeks.attr(property, "src")
        if Helpers.absolute_url?(url), do: url, else: ""

      Enum.member?(@tags_href, tag) ->
        url = Meeseeks.attr(property, "href")
        if Helpers.absolute_url?(url), do: url, else: ""

      Enum.member?(@tags_data, tag) ->
        url = Meeseeks.attr(property, "data")
        if Helpers.absolute_url?(url), do: url, else: ""

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
end
