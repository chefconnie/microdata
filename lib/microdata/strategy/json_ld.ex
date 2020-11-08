defmodule Microdata.Strategy.JSONLD do
  @moduledoc """
  `Microdata.Strategy.JSONLD` defines a strategy to extract linked data from a `Meeseeks.Document`, based on the W3C [JSON-LD standard](https://www.w3.org/TR/json-ld/).

  ### Caveats
  - Only a small fraction of section 6 of the [JSON-LD specification](https://www.w3.org/TR/json-ld/) is implemented
  """

  @behaviour Microdata.Strategy

  import Meeseeks.XPath

  alias Microdata.{Item, Property}

  @impl true
  def parse_items(doc, _base_uri \\ nil) do
    doc
    |> Meeseeks.all(xpath("//script[@type=\"application/ld+json\"]"))
    |> Enum.map(&parse_result(&1))
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
  end

  defp parse_result(result) do
    result
    |> Meeseeks.data()
    |> Microdata.json_library().decode()
    |> case do
      {:ok, object} -> parse_object(object, %{})
      {:error, _} -> nil
    end
  end

  def parse_object(object, _) when is_nil(object), do: nil

  def parse_object(object, parent_context) when is_list(object) do
    object
    |> Enum.map(&parse_object(&1, parent_context))
  end

  def parse_object(object, parent_context) do
    id = object["@id"]

    context =
      object
      |> extract_context()
      |> normalize_definitions(parent_context)
      |> Enum.into(parent_context)

    types =
      object
      |> extract_types()
      |> normalize_types(context)
      |> Enum.into(MapSet.new())

    object
    |> extract_properties()
    |> map_terms(context)
    |> normalize_values(context)
    |> List.flatten()
    |> to_property_list()
    |> case do
      [] ->
        parse_object(object["@graph"], context)

      properties ->
        %Item{
          id: id,
          types: types,
          properties: properties
        }
    end
  end

  defp extract_context(object) do
    object
    |> Map.get("@context")
    |> case do
      context when is_map(context) ->
        context

      context when is_binary(context) ->
        context
        |> download_context()
        |> Microdata.json_library().decode!()
        |> extract_context()

      _ ->
        %{}
    end
  end

  defp download_context("https://schema.org/") do
    read_locally("schema.org.json")
  end

  defp download_context("http://schema.org/") do
    read_locally("schema.org.json")
  end

  defp download_context("https://schema.org") do
    read_locally("schema.org.json")
  end

  defp download_context("http://schema.org") do
    read_locally("schema.org.json")
  end

  defp download_context(context) do
    HTTPoison.get!(context, [Accept: "application/ld+json"], follow_redirect: true).body
  end

  defp read_locally(file) do
    :code.priv_dir(:microdata)
    |> Path.join("schemas")
    |> Path.join(file)
    |> File.read!()
  end

  defp normalize_definitions(context, parent_context) do
    lookup_context = Map.merge(context, parent_context)

    context
    |> Enum.map(fn {term, mapping} ->
      case mapping do
        iri when is_binary(iri) -> {term, enlarge_iri(iri, lookup_context)}
        %{"@id" => iri} -> {term, enlarge_iri(iri, lookup_context)}
      end
    end)
  end

  defp enlarge_iri(iri, context) do
    iri
    |> String.split(":")
    |> case do
      [iri] -> iri
      [prefix, suffix] -> "#{context[prefix]}#{suffix}"
    end
  end

  defp extract_types(object) do
    case object["@type"] do
      types when is_list(types) -> types
      nil -> []
      type -> [type]
    end
  end

  defp normalize_types(types, context) do
    types
    |> Enum.map(fn type -> context[type] || type end)
  end

  defp extract_properties(object) do
    object
    |> Enum.reject(fn {term, _value} ->
      term |> String.starts_with?("@")
    end)
  end

  defp map_terms(properties, context) do
    properties
    |> Enum.map(fn {term, value} ->
      {context[term] || term, value}
    end)
  end

  defp normalize_values(properties, context) do
    properties
    |> Enum.map(fn {term, value} ->
      case value do
        list when is_list(list) ->
          list |> Enum.map(&{term, &1}) |> normalize_values(context)

        %{"@id" => value} ->
          {term, value}

        %{} = value ->
          {term, parse_object(value, context)}

        value ->
          {term, value}
      end
    end)
  end

  defp to_property_list(properties) do
    properties
    |> Enum.map(fn {term, value} ->
      %Property{
        names: [term] |> MapSet.new(),
        value: value
      }
    end)
  end
end
