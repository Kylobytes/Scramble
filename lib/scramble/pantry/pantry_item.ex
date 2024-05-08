defmodule Scramble.Pantry.PantryItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pantry_items" do
    field :name, :string
    field :amount, :decimal
    field :measurement_unit, :string

    timestamps()
  end

  @doc false
  def changeset(pantry_item, attrs) do
    pantry_item
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
