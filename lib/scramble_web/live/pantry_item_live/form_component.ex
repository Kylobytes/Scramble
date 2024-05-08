defmodule ScrambleWeb.PantryItemLive.FormComponent do
  use ScrambleWeb, :live_component

  alias Scramble.Pantry

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage pantry_item records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="pantry_item-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pantry item</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pantry_item: pantry_item} = assigns, socket) do
    changeset = Pantry.change_pantry_item(pantry_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"pantry_item" => pantry_item_params}, socket) do
    changeset =
      socket.assigns.pantry_item
      |> Pantry.change_pantry_item(pantry_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"pantry_item" => pantry_item_params}, socket) do
    save_pantry_item(socket, socket.assigns.action, pantry_item_params)
  end

  defp save_pantry_item(socket, :edit, pantry_item_params) do
    case Pantry.update_pantry_item(socket.assigns.pantry_item, pantry_item_params) do
      {:ok, pantry_item} ->
        notify_parent({:saved, pantry_item})

        {:noreply,
         socket
         |> put_flash(:info, "Pantry item updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_pantry_item(socket, :new, pantry_item_params) do
    case Pantry.create_pantry_item(pantry_item_params) do
      {:ok, pantry_item} ->
        notify_parent({:saved, pantry_item})

        {:noreply,
         socket
         |> put_flash(:info, "Pantry item created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
