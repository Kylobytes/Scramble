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

  @doc """
  Generate a ingredient.
  """
  def ingredient_fixture(attrs \\ %{}) do
    {:ok, ingredient} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        measurement_unit: "some measurement_unit",
        name: "some name"
      })
      |> Scramble.Recipes.create_ingredient()

    ingredient
  end

  @doc """
  Generate a instruction.
  """
  def instruction_fixture(attrs \\ %{}) do
    {:ok, instruction} =
      attrs
      |> Enum.into(%{
        content: "some content",
        order: 42
      })
      |> Scramble.Recipes.create_instruction()

    instruction
  end
end
