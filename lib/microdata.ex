defmodule Microdata do
  @moduledoc """
  `Microdata` is an Elixir library for parsing [microdata](https://www.w3.org/TR/microdata) from a provided document.

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

  It should be noted that even though the library will find and read JSON-LD in an HTML page's `<script>` tags, it will
  not process JSON-LD returned as the body of an HTTP response. Passing a JSON-LD string as text will likewise not
  parse. Patches to add such functionality are welcome!

  ### Configuration
  In your `config.exs` you can can set the value of `{:microdata, :strategies}` to a list of modules to consult (in order)
  when looking for microdata content. Modules must conform to `Microdata.Strategy`. By default, the Microdata library uses, in order:
   * `Microdata.Strategy.HTMLMicroformat` - Looks for microdata in HTML tags
   * `Microdata.Strategy.JSONLD` - Looks for microdata in JSON-LD script tags

  ### Roadmap
  - Community contribs would be appreciated to add `itemref` support :)

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

  alias Microdata.{Document, Error}

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

  @default_strategies [Microdata.Strategy.HTMLMicrodata, Microdata.Strategy.JSONLD]

  @spec parse(file: String.t()) :: {:ok, Document.t()} | {:error, Error.t()}
  @spec parse(url: String.t()) :: {:ok, Document.t()} | {:error, Error.t()}
  @spec parse(String.t()) :: {:ok, Document.t()} | {:error, Error.t()}
  @spec parse(String.t(), base_uri: String.t()) :: {:ok, Document.t()} | {:error, Error.t()}
  # credo:disable-for-next-line Credo.Check.Refactor.PipeChainStart
  def parse(file: path), do: File.read!(path) |> parse(base_uri: path)

  # credo:disable-for-next-line Credo.Check.Refactor.PipeChainStart
  def parse(url: url), do: HTTPoison.get!(url).body |> parse(base_uri: url)
  def parse(html), do: parse(html, base_uri: nil)

  def parse(html, base_uri: base_uri) do
    doc = html |> Meeseeks.parse()

    strategies()
    |> Enum.flat_map(& &1.parse_items(doc, base_uri))
    |> case do
      items when items != [] ->
        {:ok, %Document{items: items}}

      _ ->
        {:error, Error.new(:document, :no_items, %{input: html})}
    end
  end

  def json_library do
    configured_lib = Application.get_env(:microdata, :json_library, Poison)

    unless Code.ensure_loaded?(configured_lib) do
      IO.warn("""
      found #{inspect(configured_lib)} in your application configuration
      for JSON encoding, but module #{inspect(configured_lib)} is not available.
      Ensure #{inspect(configured_lib)} is listed as a dependency in mix.exs.
      """)
    end

    configured_lib
  end

  defp strategies do
    Application.get_env(:microdata, :strategies, @default_strategies)
  end
end
