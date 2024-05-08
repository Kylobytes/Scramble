defmodule Scramble.Pantry do
  @moduledoc """
  The Pantry context.
  """

  import Ecto.Query, warn: false
  alias Scramble.Repo

  alias Scramble.Pantry.PantryItem

  @doc """
  Returns the list of pantry_items.

  ## Examples

      iex> list_pantry_items()
      [%PantryItem{}, ...]

  """
  def list_pantry_items do
    Repo.all(PantryItem)
  end

  @doc """
  Gets a single pantry_item.

  Raises `Ecto.NoResultsError` if the Pantry item does not exist.

  ## Examples

      iex> get_pantry_item!(123)
      %PantryItem{}

      iex> get_pantry_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pantry_item!(id), do: Repo.get!(PantryItem, id)

  @doc """
  Creates a pantry_item.

  ## Examples

      iex> create_pantry_item(%{field: value})
      {:ok, %PantryItem{}}

      iex> create_pantry_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pantry_item(attrs \\ %{}) do
    %PantryItem{}
    |> PantryItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pantry_item.

  ## Examples

      iex> update_pantry_item(pantry_item, %{field: new_value})
      {:ok, %PantryItem{}}

      iex> update_pantry_item(pantry_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pantry_item(%PantryItem{} = pantry_item, attrs) do
    pantry_item
    |> PantryItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pantry_item.

  ## Examples

      iex> delete_pantry_item(pantry_item)
      {:ok, %PantryItem{}}

      iex> delete_pantry_item(pantry_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pantry_item(%PantryItem{} = pantry_item) do
    Repo.delete(pantry_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pantry_item changes.

  ## Examples

      iex> change_pantry_item(pantry_item)
      %Ecto.Changeset{data: %PantryItem{}}

  """
  def change_pantry_item(%PantryItem{} = pantry_item, attrs \\ %{}) do
    PantryItem.changeset(pantry_item, attrs)
  end
end
