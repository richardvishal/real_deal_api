defmodule RealDealApiWeb.Router do
  use RealDealApiWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}),
    do: conn |> json(%{errors: message}) |> halt()

  defp handle_errors(conn, %{reason: %{message: message}}),
    do: conn |> json(%{message: message}) |> halt()

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug RealDealApiWeb.Auth.Pipeline
    plug RealDealApiWeb.Auth.SetAccount
  end

  scope "/api", RealDealApiWeb do
    pipe_through :api

    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
  end

  scope "/api", RealDealApiWeb do
    pipe_through [:api, :auth]
    get "accounts/get_by/:id", AccountController, :show
    post "accounts/sign_out", AccountController, :sign_out
    post "accounts/update", AccountController, :update
  end
end
