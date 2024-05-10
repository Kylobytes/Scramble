defmodule Scramble.Repo.Migrations.CreateInstructions do
  use Ecto.Migration

  def change do
    create table(:instructions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :text
      add :order, :integer

      timestamps()
    end
  end
end
