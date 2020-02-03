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

  After writing the entire plug we just have to use it into our router module
  """
  import Plug.Conn
  # import Phoenix.Controller

  alias Discussapp.Repo
  alias Discussapp.User
  # alias Discussapp.Router.Helpers

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
    user_id = get_session(conn, :user_id)

    # cond statement evaluates the statement corresponding to the first clause
    # that evaluates to a truthy value
    # cond evaluates all the statement list, the first one that returns true will
    # execute the clause in it
    cond do
      # user will be user_id if this value is falsy,
      # if user_id is truthy then it will assign Repo.get to user
      # NOTE: this does not work as true && true = true, true && false = false
      user = user_id && Repo.get(User, user_id) ->
        # we assign to the connection, dont use put_session function
        conn
        |> assign(:user, user)
      # if above fails then just execute next, (user is not logged)
      true ->
        conn
        |> assign(:user, nil)
    end
  end
end
