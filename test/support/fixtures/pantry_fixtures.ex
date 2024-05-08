defmodule Scramble.PantryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Scramble.Pantry` context.
  """

  @doc """
  Generate a pantry_item.
  """
  def pantry_item_fixture(attrs \\ %{}) do
    {:ok, pantry_item} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Scramble.Pantry.create_pantry_item()

    pantry_item
  end
end
