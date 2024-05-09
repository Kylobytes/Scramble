defmodule Scramble.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Scramble.Recipes` context.
  """

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Scramble.Recipes.create_recipe()

    recipe
  end
end
