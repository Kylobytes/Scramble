defmodule ScrambleWeb.IngredientLive.FormComponent do
  use ScrambleWeb, :live_component

  alias Scramble.Recipes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage ingredient records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="ingredient-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:measurement_unit]} type="text" label="Measurement unit" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Ingredient</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{ingredient: ingredient} = assigns, socket) do
    changeset = Recipes.change_ingredient(ingredient)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"ingredient" => ingredient_params}, socket) do
    changeset =
      socket.assigns.ingredient
      |> Recipes.change_ingredient(ingredient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"ingredient" => ingredient_params}, socket) do
    save_ingredient(socket, socket.assigns.action, ingredient_params)
  end

  defp save_ingredient(socket, :edit, ingredient_params) do
    case Recipes.update_ingredient(socket.assigns.ingredient, ingredient_params) do
      {:ok, ingredient} ->
        notify_parent({:saved, ingredient})

        {:noreply,
         socket
         |> put_flash(:info, "Ingredient updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_ingredient(socket, :new, ingredient_params) do
    case Recipes.create_ingredient(ingredient_params) do
      {:ok, ingredient} ->
        notify_parent({:saved, ingredient})

        {:noreply,
         socket
         |> put_flash(:info, "Ingredient created successfully")
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
