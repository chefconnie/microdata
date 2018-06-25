defmodule Microdata.Property do
  @moduledoc """
  Microdata.Property structs are key/value mappings for microdata items' internal data.
  """

  @enforce_keys [:names, :value]
  defstruct names: nil, value: nil

  @type t :: %Microdata.Property{
          names: MapSet.t(String.t()),
          value: String.t() | Microdata.Item.t()
        }
end
