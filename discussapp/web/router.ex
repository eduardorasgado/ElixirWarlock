defmodule Discussapp.Router do
  @moduledoc """
  Guide to all the conventions to route with phoenix:

  user_path  GET     /users           HelloWeb.UserController :index
  user_path  GET     /users/:id/edit  HelloWeb.UserController :edit
  user_path  GET     /users/new       HelloWeb.UserController :new
  user_path  GET     /users/:id       HelloWeb.UserController :show
  user_path  POST    /users           HelloWeb.UserController :create
  user_path  PATCH   /users/:id       HelloWeb.UserController :update
            PUT     /users/:id       HelloWeb.UserController :update
  user_path  DELETE  /users/:id       HelloWeb.UserController :delete
  """
  use Discussapp.Web, :router

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

  scope "/", Discussapp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # method, action addess, controller, function in controller(convention)
    get "/topics/new", TopicController, :new
    post "/topics", TopicController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discussapp do
  #   pipe_through :api
  # end
end
