defmodule Microdata do
  @moduledoc """
  `Microdata` is an Elixir library for parsing [microdata](https://www.w3.org/TR/microdata) from a provided document.

  ### Caveats
  - `itemref` lookups are not yet supported
  - Only supports HTML parsing, ie no JSON or RDFa support

  If you need any of the above, contribs adding this support are most welcome!

  ### Dependencies
  #### Meeseeks + Rust
  Microdata parses HTML with [Meeseeks](https://github.com/mischov/meeseeks), which depends on [html5ever](https://github.com/servo/html5ever) via [meeseeks_html5ever](https://github.com/mischov/meeseeks_html5ever).

  Because html5ever is a Rust library, you will need to have the Rust compiler [installed](https://www.rust-lang.org/en-US/install.html).

  This dependency is necessary because there are no HTML5 spec compliant parsers written in Elixir/Erlang.

  #### HTTPoison
  If you are using the provided `Microdata.parse(url: ...)` helper function, your library / application will need to declare a dep on HTTPoison (see below).

  ### Installation

  - Ensure your build machine has the Rust compiler installed (see above)
  - Add `microdata` to your `mix.exs` deps
    - If you plan to use the `Microdata.parse(url: ...)` helper function, include a line for `{:httpoison, "~> 1.0"}`
  ```elixir
  def deps do
  [
    {:microdata, "~> 0.1.0"},
    {:httpoison, "~> 1.0"} # optional
  ]
  end
  ```
  - Run `mix deps.get`

  ### Usage
  Available [on HexDocs](https://hexdocs.pm/microdata). TL;DR:

  - `Microdata.parse(html_text)`, if you've already fetched / read your HTML
  - `Microdata.parse(file: "path_to_file.html")`, if you're reading from file
  - `Microdata.parse(url: "https://website.com/path/to/page")`, if you'd like to fetch & parse
      - Uses `HTTPoison ~> 1.0` under the hood; this is an optional dep so you'll want to add it to your `mix.exs` deps as well (see above)

  ### Roadmap
  - Community contribs would be appreciated to add `itemref` support, as well as JSON & RDFa parsing :)

  ### Helpful Links
  - [Microdata spec](https://www.w3.org/TR/microdata)

  ### Credits
  Thanks muchly to the team + community behind [meeseeks](https://hex.pm/packages/meeseeks), particularly [@mischov](https://github.com/mischov/), for the support and fixes on esoteric XPath issues.

  ### An Invitation
  ![Swedish Chef](https://media.giphy.com/media/LVBH3rg1BUROw/giphy.gif)

  Next time you're cooking, **don't risk** getting **raw chicken juice** or **sticky sauces** on your **fancy cookbooks** and **expensive electronics**! We are working on **Connie**, a **conversational cooking assistant** that uses Alexa & Google Home to answer questions like:

  > What am I supposed to be doing?
  > 
  > What's next for the lasagna?

  We wrote this lib to parse imported recipes and wanted to share it back with the community, as there are loads of ways you might use microdata in your own projects. Hope you enjoy!

  If you'd like to join our **private beta**, please send an email to [hi [AT] cookformom [DOT] com](mailto:hi@cookformom.com), letting us know:

  - Which voice assistant you use;
  - Your favourite meal; and
  - What you want to learn to cook next.

  Have a nice day :)
  """

  alias Microdata.{Document, Error, Helpers, Item, Property}
  import Meeseeks.XPath

  @tags_src ~w(audio embed iframe img source track video)
  @tags_href ~w(a area link)
  @tags_data ~w(object)
  @tags_value ~w(data meter)
  @tags_datetime ~w(datetime)

  @doc """
  Parses Microdata from a given document, and returns a %Microdata.Document{} struct.

  ## Examples (n.b. tested manually; not a doctest!)
  ```
  iex> Microdata.parse("<html itemscope itemtype='foo'><body><p itemprop='bar'>baz</p></body></html>")
  {:ok,
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
  }

  iex> Microdata.parse(file: "path/to/file.html")
  {:ok, %Microdata.Document{...}}

  iex> Microdata.parse(url: "https://website.com/path/to/page")
  {:ok, %Microdata.Document{...}}

  ```
  """

  @spec parse(file: String.t()) :: {:ok, Document.t()} | {:error, Error.t()}
  @spec parse(url: String.t()) :: {:ok, Document.t()} | {:error, Error.t()}
  @spec parse(String.t()) :: {:ok, Document.t()} | {:error, Error.t()}
  # credo:disable-for-next-line Credo.Check.Refactor.PipeChainStart
  def parse(file: path), do: File.read!(path) |> parse

  if Code.ensure_loaded?(HTTPoison) do
    # credo:disable-for-next-line Credo.Check.Refactor.PipeChainStart
    def parse(url: url), do: HTTPoison.get!(url).body |> parse
  else
    def parse(url: _), do: raise("HTTPoison required to for the url option")
  end

  def parse(html) do
    case html |> Meeseeks.parse() |> parse_items do
      items when length(items) > 0 ->
        {:ok, %Document{items: items}}

      _ ->
        {:error, Error.new(:document, :no_items, %{input: html})}
    end
  end

  defp parse_items(doc) do
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
