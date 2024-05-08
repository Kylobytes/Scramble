defmodule ScrambleWeb.PantryItemLive.Index do
  use ScrambleWeb, :live_view

  alias Scramble.Pantry
  alias Scramble.Pantry.PantryItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :pantry_items, Pantry.list_pantry_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pantry item")
    |> assign(:pantry_item, Pantry.get_pantry_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pantry item")
    |> assign(:pantry_item, %PantryItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pantry items")
    |> assign(:pantry_item, nil)
  end

  @impl true
  def handle_info({ScrambleWeb.PantryItemLive.FormComponent, {:saved, pantry_item}}, socket) do
    {:noreply, stream_insert(socket, :pantry_items, pantry_item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pantry_item = Pantry.get_pantry_item!(id)
    {:ok, _} = Pantry.delete_pantry_item(pantry_item)

    {:noreply, stream_delete(socket, :pantry_items, pantry_item)}
  end
end
