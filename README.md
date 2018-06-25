[![Build Status](https://travis-ci.org/anulman/microdata.svg?branch=master)](https://travis-ci.org/anulman/microdata)
[![Microdata version](https://img.shields.io/hexpm/v/microdata.svg)](https://hex.pm/packages/microdata)

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

## Usage
Available [on HexDocs](https://hexdocs.pm/microdata). TL;DR:

- `Microdata.parse(html_text)`, if you've already fetched / read your HTML
- `Microdata.parse(file: "path_to_file.html")`, if you're reading from file
- `Microdata.parse(url: "https://website.com/path/to/page")`, if you'd like to fetch & parse
    - Uses `HTTPoison ~> 1.0` under the hood; this is an optional dep so you'll want to add it to your `mix.exs` deps as well (see above)

## Roadmap
- Community contribs would be appreciated to add `itemref` support, as well as JSON & RDFa parsing :)

## Helpful Links
- [Microdata spec](https://www.w3.org/TR/microdata)

## Credits
Thanks muchly to the team + community behind [meeseeks](https://hex.pm/packages/meeseeks), particularly [@mischov](https://github.com/mischov/), for the support and fixes on esoteric XPath issues.

## An Invitation
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
