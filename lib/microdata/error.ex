defmodule Microdata.Error do
  @errors %{
    document: [:no_items]
  }

  @moduledoc """
  `Microdata.Error` provides a generic error struct implementing the `Exception` behaviour and containing three keys: `type`, `reason`, and `metadata`.

    - `type` is an atom classifying the general context the error exists in, such as `:document`.
    - `reason` is an atom classifying the general problem, such as `:no_items`.
    - `metadata` is a map containing any additional information useful for debugging the error, such as `%{input: "..."}`.

  ### Microdata Errors:

  #{
    @errors
    |> Enum.flat_map(fn {type, reasons} ->
      Enum.map(reasons, fn reason ->
        "- `%Microdata.Error{type: #{inspect(type)}, reason: #{inspect(reason)}}`"
      end)
    end)
    |> Enum.join("\n")
  }
  """

  @enforce_keys [:type, :reason]
  defexception type: nil, reason: nil, metadata: %{}

  @type type :: atom
  @type reason :: atom
  @type metadata :: %{any => any}

  @type t :: %__MODULE__{
          type: type,
          reason: reason,
          metadata: metadata
        }

  @doc """
  Lists a mapping of error types to reasons for all possible Microdata errors.
  """
  @spec list_errors() :: %{type => [reason]}
  def list_errors(), do: @errors

  @doc """
  Creates a new `%Microdata.Error{}`.
  """
  @spec new(type, reason, metadata) :: t
  def new(type, reason, metadata \\ %{}) do
    %__MODULE__{type: type, reason: reason, metadata: metadata}
  end

  # Exception callbacks

  @impl true
  def exception(%{type: type, reason: reason} = info) do
    metadata = Map.get(info, :metadata, %{})
    new(type, reason, metadata)
  end

  @impl true
  def message(%__MODULE__{type: type, reason: reason, metadata: metadata}) do
    IO.iodata_to_binary([
      "\n",
      "\n  Type: #{inspect(type)}",
      "\n",
      "\n  Reason: #{inspect(reason)}",
      render_metadata(metadata)
    ])
  end

  # Helpers

  defp render_metadata(%{} = metadata) do
    rendered = for {k, v} <- metadata, do: "\n    #{k}: #{inspect(v)}"

    case rendered do
      [] -> []
      _ -> ["\n\n  Metadata:" | rendered]
    end
  end
end
