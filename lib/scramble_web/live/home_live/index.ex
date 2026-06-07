defmodule ScrambleWeb.HomeLive.Index do
  use ScrambleWeb, :live_view

  alias Scramble.Recipes
  alias Scramble.Recipes.Recipe

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :recipes, Recipes.list_recipes())}
  end

  defp count_recipes(recipes) do
    case Enumerable.count(recipes) do
      {:ok, count} -> count
      {:error, _error} -> 0
      _ -> 0
    end
  end
end
