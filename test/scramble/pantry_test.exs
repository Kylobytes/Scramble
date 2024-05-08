defmodule Scramble.PantryTest do
  use Scramble.DataCase

  alias Scramble.Pantry

  describe "pantry_items" do
    alias Scramble.Pantry.PantryItem

    import Scramble.PantryFixtures

    @invalid_attrs %{name: nil}

    test "list_pantry_items/0 returns all pantry_items" do
      pantry_item = pantry_item_fixture()
      assert Pantry.list_pantry_items() == [pantry_item]
    end

    test "get_pantry_item!/1 returns the pantry_item with given id" do
      pantry_item = pantry_item_fixture()
      assert Pantry.get_pantry_item!(pantry_item.id) == pantry_item
    end

    test "create_pantry_item/1 with valid data creates a pantry_item" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %PantryItem{} = pantry_item} = Pantry.create_pantry_item(valid_attrs)
      assert pantry_item.name == "some name"
    end

    test "create_pantry_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pantry.create_pantry_item(@invalid_attrs)
    end

    test "update_pantry_item/2 with valid data updates the pantry_item" do
      pantry_item = pantry_item_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %PantryItem{} = pantry_item} = Pantry.update_pantry_item(pantry_item, update_attrs)
      assert pantry_item.name == "some updated name"
    end

    test "update_pantry_item/2 with invalid data returns error changeset" do
      pantry_item = pantry_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Pantry.update_pantry_item(pantry_item, @invalid_attrs)
      assert pantry_item == Pantry.get_pantry_item!(pantry_item.id)
    end

    test "delete_pantry_item/1 deletes the pantry_item" do
      pantry_item = pantry_item_fixture()
      assert {:ok, %PantryItem{}} = Pantry.delete_pantry_item(pantry_item)
      assert_raise Ecto.NoResultsError, fn -> Pantry.get_pantry_item!(pantry_item.id) end
    end

    test "change_pantry_item/1 returns a pantry_item changeset" do
      pantry_item = pantry_item_fixture()
      assert %Ecto.Changeset{} = Pantry.change_pantry_item(pantry_item)
    end
  end
end
