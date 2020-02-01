defmodule Discussapp.Plugs.SetUser do
  @moduledoc """
  Module to be able to intercept any connection defines it a user is logged or not

  the goal is look into the connection
  grab the id
  fetch id into database
  do a tiny transform to conn
  set the user model on the conn object

  to be able to have access to user model in any place in our web app

  there are 2 types of plugs: function plug and module plug
  In this time we are creating a module plug.

  In a module plug we have two functions that are important
  init -> do some setup
  call -> called with a 'conn', must return a conn
  """
  import Plug.Conn
  import Phoenix.Controller

  alias Discussapp.Repo
  alias Discussapp.User
  alias Discussapp.Router.Helpers

  @doc """
  Function to create some initial setup
  """
  def init(_params) do
    # no initialization in this case
    # a way to use this init function is e.g. when we want to access a bunch of data
    # in db and we will do a lot of compution processes that will require some time
    # and setting all those things into the init function we will be able to access all the
    # data in the params in call function
  end

  @doc """
  This function will be called when a connection is been manipulated
  """
  def call(conn, _params) do
    conn
  end
end
