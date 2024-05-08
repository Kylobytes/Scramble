defmodule ScrambleWeb.PantryItemLiveTest do
  use ScrambleWeb.ConnCase

  import Phoenix.LiveViewTest
  import Scramble.PantryFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_pantry_item(_) do
    pantry_item = pantry_item_fixture()
    %{pantry_item: pantry_item}
  end

  describe "Index" do
    setup [:create_pantry_item]

    test "lists all pantry_items", %{conn: conn, pantry_item: pantry_item} do
      {:ok, _index_live, html} = live(conn, ~p"/pantry_items")

      assert html =~ "Listing Pantry items"
      assert html =~ pantry_item.name
    end

    test "saves new pantry_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/pantry_items")

      assert index_live |> element("a", "New Pantry item") |> render_click() =~
               "New Pantry item"

      assert_patch(index_live, ~p"/pantry_items/new")

      assert index_live
             |> form("#pantry_item-form", pantry_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pantry_item-form", pantry_item: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pantry_items")

      html = render(index_live)
      assert html =~ "Pantry item created successfully"
      assert html =~ "some name"
    end

    test "updates pantry_item in listing", %{conn: conn, pantry_item: pantry_item} do
      {:ok, index_live, _html} = live(conn, ~p"/pantry_items")

      assert index_live |> element("#pantry_items-#{pantry_item.id} a", "Edit") |> render_click() =~
               "Edit Pantry item"

      assert_patch(index_live, ~p"/pantry_items/#{pantry_item}/edit")

      assert index_live
             |> form("#pantry_item-form", pantry_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pantry_item-form", pantry_item: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pantry_items")

      html = render(index_live)
      assert html =~ "Pantry item updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes pantry_item in listing", %{conn: conn, pantry_item: pantry_item} do
      {:ok, index_live, _html} = live(conn, ~p"/pantry_items")

      assert index_live |> element("#pantry_items-#{pantry_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pantry_items-#{pantry_item.id}")
    end
  end

  describe "Show" do
    setup [:create_pantry_item]

    test "displays pantry_item", %{conn: conn, pantry_item: pantry_item} do
      {:ok, _show_live, html} = live(conn, ~p"/pantry_items/#{pantry_item}")

      assert html =~ "Show Pantry item"
      assert html =~ pantry_item.name
    end

    test "updates pantry_item within modal", %{conn: conn, pantry_item: pantry_item} do
      {:ok, show_live, _html} = live(conn, ~p"/pantry_items/#{pantry_item}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pantry item"

      assert_patch(show_live, ~p"/pantry_items/#{pantry_item}/show/edit")

      assert show_live
             |> form("#pantry_item-form", pantry_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#pantry_item-form", pantry_item: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/pantry_items/#{pantry_item}")

      html = render(show_live)
      assert html =~ "Pantry item updated successfully"
      assert html =~ "some updated name"
    end
  end
end
