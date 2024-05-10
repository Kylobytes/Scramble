defmodule Scramble.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :amount, :decimal
      add :measurement_unit, :string

      timestamps()
    end
  end
end
