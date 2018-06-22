# Microdata

This lib parses Microdata `Item`s and their `Property`s from source `Document`s.

## Caveats
- `itemref` lookups are not yet supported
- Only supports HTML parsing, ie no JSON or RDFa support

If you need any of the above, contribs adding this support are most welcome!

## Dependencies
### Meeseeks + Rust
Microdata parses HTML with [Meeseeks](https://github.com/mischov/meeseeks), which depends on [html5ever](https://github.com/servo/html5ever) via [meeseeks_html5ever](https://github.com/mischov/meeseeks_html5ever).

Because html5ever is a Rust library, you will need to have the Rust compiler [installed](https://www.rust-lang.org/en-US/install.html).

This dependency is necessary because there are no HTML5 spec compliant parsers written in Elixir/Erlang.

### HTTPoison
If you are using the provided `Microdata.parse(url: ...)` helper function, your library / application will need to declare a dep on HTTPoison (see below).

## Installation

- Ensure your build machine has the Rust compiler installed (see above)
- Add `microdata` to your `mix.exs` deps:
```elixir
def deps do
  [
    {:microdata, "~> 0.0.1"}
  ]
end
```
    - Optionally, include a line for `{:httpoison, "~> 1.0"}`, if you plan to use the `Microdata.parse(url: ...)` helper function
- Run `mix deps.get`

## Usage
Available [on HexDocs](https://hexdocs.pm/microdata). TL;DR:

- `Microdata.parse(html_text)`, if you've already fetched / read your HTML
- `Microdata.parse(file: "path_to_file.html")`, if you're reading from file
- `Microdata.parse(url: "https://website.com/path/to/page")`, if you'd like to fetch & parse
    - Uses `HTTPoison ~> 1.0` under the hood; this is an optional dep so you'll want to add it to your `mix.exs` deps as well (see above)

## Roadmap
- Figure out how to write the `@type` spec for `Microdata.Property` structs
- Refactor shimmed XPath lookups, per [upstream issue](https://github.com/mischov/meeseeks/issues/42)
    - While at it, rm `filter_top_level_items`
- Refactor parser interface to return `{:ok, Microdata.Document.t()}|{:error, Microdata.Error.t()}` tuples
- Refactor items parsing to return `{:error, Microdata.Error.t()}` with reason "no microdata items found", if that's the case
- Community contribs would be appreciated to add `itemref` support, as well as JSON & RDFa parsing :)

## Helpful Links
- [Microdata spec](https://www.w3.org/TR/microdata)

## Credits
We are building a conversational cooking assistant that uses Alexa & Google Home to answer questions like "what am I supposed to be doing?" and "what's next for the lasagna?" while you're in the kitchen, so you don't risk getting raw chicken juice or sticky sauces on your fancy cookbooks and expensive electronics.

We wrote this lib for recipe parsing—ie so users can import recipes from all around the internet—and wanted to share it back with the community, as there are loads of ways you might use microdata in your own projects. Hope you enjoy!

If you'd like to join our private beta, please send an email to [hi [AT] cookformom [DOT] com](mailto:hi@cookformom.com), letting us know A) which voice assistant you use; B) your favourite meal; and C) what you want to learn to cook next.

Have a nice day :)
