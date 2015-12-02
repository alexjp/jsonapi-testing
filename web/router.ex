defmodule JsonapiOverhaul.Router do
  use JsonapiOverhaul.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JsonapiOverhaul do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", JsonapiOverhaul do
   pipe_through :api

   resources "/companies", CompanyController, except: [:new, :edit]
   resources "/users", UserController, except: [:new, :edit]
  end
end
