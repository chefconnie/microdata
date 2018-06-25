defmodule Microdata.Property do
  @moduledoc """
  `Microdata.Property` structs are key/value mappings for data parsed from `Microdata.Item`s' source.
  """

  @enforce_keys [:names, :value]
  defstruct names: nil, value: nil

  @type t :: %Microdata.Property{
          names: MapSet.t(String.t()),
          value: String.t() | Microdata.Item.t()
        }
end
