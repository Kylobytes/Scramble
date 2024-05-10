defmodule Scramble.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ingredients" do
    field :amount, :decimal
    field :measurement_unit, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :amount, :measurement_unit])
    |> validate_required([:name, :amount, :measurement_unit])
  end
end
