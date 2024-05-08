defmodule Scramble.Repo.Migrations.CreatePantryItems do
  use Ecto.Migration

  def change do
    create table(:pantry_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :amount, :decimal
      add :measurement_unit, :string

      timestamps()
    end
  end
end
