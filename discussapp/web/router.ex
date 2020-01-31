defmodule Discussapp.Router do
  @moduledoc """
  The project was created by typing:
  $mix phoenix.new Discussapp

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

  # a pipeline that defines a controller to do some amount of pre proccesings
  # before handle a request
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

  # a scope keyword is for namespacing urls in phoenix
  scope "/", Discussapp do
    pipe_through :browser # Use the default browser stack

    # get "/", TopicController, :index
    # # method, action addess, controller, function in controller(convention)
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # # this is called router wildcard: :id
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update

    # this will work if only we follow a restful convention
    # when resouce helper is been used, wild card will be :id by default
    resources "/topics", TopicController
  end

  # urls related to user authentication
  scope "/auth",Discussapp do
    pipe_through :browser

    # ueber auth will provide a provider stradegy by loooking at request from user
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discussapp do
  #   pipe_through :api
  # end
end
