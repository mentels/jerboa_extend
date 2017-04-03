defmodule JerboaExtend.Attribute.SoftwareTest do
  use ExUnit.Case
  use Quixir

  alias Jerboa.Format.{Meta, Body.Attribute}
  alias JerboaExtend.Attribute.Software

  test "STUN Software is encoded/decoded correctly" do
    ptest soft: string(max: 128) do
      {_meta, encoded_attr} = Attribute.encode(%Jerboa.Format.Meta{},
        %Software{value: soft})
      <<type::size(16), length::size(16), value::size(length)-bytes>> = encoded_attr
      assert {:ok, _meta, soft} = Attribute.decode(%Meta{}, type, value)
    end
  end
end
