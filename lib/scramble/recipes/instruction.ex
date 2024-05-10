defmodule Scramble.Recipes.Instruction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "instructions" do
    field :content, :string
    field :order, :integer

    timestamps()
  end

  @doc false
  def changeset(instruction, attrs) do
    instruction
    |> cast(attrs, [:content, :order])
    |> validate_required([:content, :order])
  end
end
