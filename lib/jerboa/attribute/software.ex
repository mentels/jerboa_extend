defmodule JerboaExtend.Attribute.Software do
  alias Jerboa.Format.Body.Attribute.{Encoder, Decoder}
  alias Jerbota.Format.Meta

  defstruct value: ""

  @max_length 128

  @typedoc """
  Textual representation being used by the STUN agent

  * `:value` is the UTF-8 encoded agent software's description 
  """
  @type t :: %__MODULE__{
    value: String.t
  }

  defimpl Encoder do
    alias JerboaExtend.Attribute.Software
    @code 0x8022

    @spec type_code(Sofrware.t) :: integer
    def type_code(_attr), do: @code

    @spec encode(Software.t, Meta.t) :: {Meta.t, binary}
    def encode(%Software{value: software}, meta) do
      if String.valid?(software) && (String.length(software) < Software.max_length) do
        {meta, software}
      end
    end
  end

  defimpl Decoder do
    alias JerboaExtend.Attribute.Software

    @spec decode(Software.t, value :: binary, meta :: Meta.t)
    :: {:ok, Meta.t, Sofrware.t} | {:error, term}
    def decode(%Software{} = s, value, meta) do
      if String.valid?(value) && (String.length(value) < Software.max_length) do
        {:ok, meta, %{s | value: value}}
      end
    end
  end

  def max_length(), do: @max_length

end
