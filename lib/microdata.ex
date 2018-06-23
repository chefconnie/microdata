defmodule Microdata do
  @moduledoc """
  Microdata is an Elixir library for parsing [microdata](https://www.w3.org/TR/microdata) from a provided document.

  *Caveats:*
  - `itemref` lookups are not yet supported
  - Only supports HTML parsing, ie no JSON or RDFa support

  If you need any of the above, contribs adding this support are most welcome!

  #### Credits
  We are building a conversational cooking assistant that uses Alexa & Google Home to answer questions like "what am I supposed to be doing?" and "what's next for the lasagna?" while you're in the kitchen, so you don't risk getting raw chicken juice or sticky sauces on your fancy cookbooks and expensive electronics.

  We wrote this lib for recipe parsing—ie so users can import recipes from all around the internet—and wanted to share it back with the community, as there are loads of ways you might use microdata in your own projects. Hope you enjoy!

  If you'd like to join our private beta, please send an email to [hi [AT] cookformom [DOT] com](mailto:hi@cookformom.com), letting us know A) which voice assistant you use; B) your favourite meal; and C) what you want to learn to cook next.

  Have a nice day :)
  """

  import Meeseeks.XPath

  @tags_source ~w(audio embed iframe img source track video)
  @tags_href ~w(a area link)
  @tags_data ~w(object)
  @tags_value ~w(data meter)
  @tags_datetime ~w(datetime)

  @doc """
  Parses Microdata from a given document, and returns a %Microdata.Document{} struct.

  ## Examples (n.b. tested manually; not a doctest!)

      iex> Microdata.parse("<html itemscope itemtype='foo'><body><p itemprop='bar'>baz</p></body></html>")
      %Microdata.Document{
        items: [
          %Microdata.Item{
            types: ["foo"],
            properties: [
              %Microdata.Property{
                id: nil,
                properties: [
                  %Microdata.Property{
                    names: ["bar"],
                    value: "baz"
                  }
                ],
              }
            ],
            types: ["foo"]
          }
        ]
      }

      iex> Microdata.parse(file: "path/to/file.html")
      %Microdata.Document{...}

      iex> Microdata.parse(url: "https://website.com/path/to/page")
      %Microdata.Document{...}
  """

  @spec parse(file: String.t()) :: Microdata.Document.t()
  @spec parse(url: String.t()) :: Microdata.Document.t()
  @spec parse(String.t()) :: Microdata.Document.t()
  # credo:disable-for-lines:3 Credo.Check.Refactor.PipeChainStart
  def parse(file: path), do: File.read!(path) |> parse
  def parse(url: url), do: HTTPoison.get!(url).body |> parse
  def parse(html), do: Meeseeks.parse(html) |> parse_document

  defp parse_document(doc) do
    %Microdata.Document{
      items: parse_items(doc)
    }
  end

  defp parse_items(doc) do
    doc
    |> Meeseeks.all(xpath("/*[@itemscope]|//*[@itemscope][not(ancestor::*[@itemscope][1])]"))
    |> Enum.map(&parse_item/1)
  end

  defp parse_item(item, nest_level \\ 2) do
    item_model = %Microdata.Item{
      id: item |> Meeseeks.attr("itemid") |> Microdata.Helpers.parse_item_id(),
      types:
        item
        |> Meeseeks.attr("itemtype")
        |> Microdata.Helpers.parse_item_types()
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
    %Microdata.Property{
      names: property |> parse_property_names(item) |> MapSet.new(),
      value: parse_property_value(property, nest_level)
    }
  end

  defp parse_property_names(property, item) do
    property
    |> Meeseeks.attr("itemprop")
    |> Microdata.Helpers.parse_property_names(item)
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

      Enum.member?(@tags_source, tag) ->
        url = Meeseeks.attr(property, "source")
        if Microdata.Helpers.absolute_url?(url), do: url, else: ""

      Enum.member?(@tags_href, tag) ->
        url = Meeseeks.attr(property, "href")
        if Microdata.Helpers.absolute_url?(url), do: url, else: ""

      Enum.member?(@tags_data, tag) ->
        url = Meeseeks.attr(property, "data")
        if Microdata.Helpers.absolute_url?(url), do: url, else: ""

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
