defmodule ScrambleWeb.Router do
  use ScrambleWeb, :router

  import ScrambleWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ScrambleWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScrambleWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScrambleWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:scramble, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ScrambleWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", ScrambleWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{ScrambleWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/register", UserRegistrationLive, :new
      live "/login", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", ScrambleWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{ScrambleWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      live "/pantry_items", PantryItemLive.Index, :index
      live "/pantry_items/new", PantryItemLive.Index, :new
      live "/pantry_items/:id/edit", PantryItemLive.Index, :edit

      live "/pantry_items/:id", PantryItemLive.Show, :show
      live "/pantry_items/:id/show/edit", PantryItemLive.Show, :edit

      live "/recipes", RecipeLive.Index, :index
      live "/recipes/new", RecipeLive.Index, :new
      live "/recipes/:id/edit", RecipeLive.Index, :edit

      live "/recipes/:id", RecipeLive.Show, :show
      live "/recipes/:id/show/edit", RecipeLive.Show, :edit

      live "/ingredients", IngredientLive.Index, :index
      live "/ingredients/new", IngredientLive.Index, :new
      live "/ingredients/:id/edit", IngredientLive.Index, :edit

      live "/ingredients/:id", IngredientLive.Show, :show
      live "/ingredients/:id/show/edit", IngredientLive.Show, :edit
    end
  end

  scope "/", ScrambleWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{ScrambleWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
