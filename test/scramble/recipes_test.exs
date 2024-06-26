defmodule Scramble.RecipesTest do
  use Scramble.DataCase

  alias Scramble.Recipes

  describe "recipes" do
    alias Scramble.Recipes.Recipe

    import Scramble.RecipesFixtures

    @invalid_attrs %{name: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(valid_attrs)
      assert recipe.name == "some name"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, update_attrs)
      assert recipe.name == "some updated name"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end

  describe "ingredients" do
    alias Scramble.Recipes.Ingredient

    import Scramble.RecipesFixtures

    @invalid_attrs %{amount: nil, measurement_unit: nil, name: nil}

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Recipes.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Recipes.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      valid_attrs = %{amount: "120.5", measurement_unit: "some measurement_unit", name: "some name"}

      assert {:ok, %Ingredient{} = ingredient} = Recipes.create_ingredient(valid_attrs)
      assert ingredient.amount == Decimal.new("120.5")
      assert ingredient.measurement_unit == "some measurement_unit"
      assert ingredient.name == "some name"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      update_attrs = %{amount: "456.7", measurement_unit: "some updated measurement_unit", name: "some updated name"}

      assert {:ok, %Ingredient{} = ingredient} = Recipes.update_ingredient(ingredient, update_attrs)
      assert ingredient.amount == Decimal.new("456.7")
      assert ingredient.measurement_unit == "some updated measurement_unit"
      assert ingredient.name == "some updated name"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Recipes.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Recipes.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Recipes.change_ingredient(ingredient)
    end
  end

  describe "instructions" do
    alias Scramble.Recipes.Instruction

    import Scramble.RecipesFixtures

    @invalid_attrs %{content: nil, order: nil}

    test "list_instructions/0 returns all instructions" do
      instruction = instruction_fixture()
      assert Recipes.list_instructions() == [instruction]
    end

    test "get_instruction!/1 returns the instruction with given id" do
      instruction = instruction_fixture()
      assert Recipes.get_instruction!(instruction.id) == instruction
    end

    test "create_instruction/1 with valid data creates a instruction" do
      valid_attrs = %{content: "some content", order: 42}

      assert {:ok, %Instruction{} = instruction} = Recipes.create_instruction(valid_attrs)
      assert instruction.content == "some content"
      assert instruction.order == 42
    end

    test "create_instruction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_instruction(@invalid_attrs)
    end

    test "update_instruction/2 with valid data updates the instruction" do
      instruction = instruction_fixture()
      update_attrs = %{content: "some updated content", order: 43}

      assert {:ok, %Instruction{} = instruction} = Recipes.update_instruction(instruction, update_attrs)
      assert instruction.content == "some updated content"
      assert instruction.order == 43
    end

    test "update_instruction/2 with invalid data returns error changeset" do
      instruction = instruction_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_instruction(instruction, @invalid_attrs)
      assert instruction == Recipes.get_instruction!(instruction.id)
    end

    test "delete_instruction/1 deletes the instruction" do
      instruction = instruction_fixture()
      assert {:ok, %Instruction{}} = Recipes.delete_instruction(instruction)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_instruction!(instruction.id) end
    end

    test "change_instruction/1 returns a instruction changeset" do
      instruction = instruction_fixture()
      assert %Ecto.Changeset{} = Recipes.change_instruction(instruction)
    end
  end
end
