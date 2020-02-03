defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Discussapp.Router.Helpers
  import Phoenix.Controller
  @moduledoc """
  This module Plug controls the access to some certain routes
  once the user has signin our application
  """

  @doc """
  Executed for expensive operations
  """
  def init _params do
  end

  @doc """
  Decide if the user is signed or not

  usually params here comes from the init function and not from the user request
  """
  def call(conn, _params) do
    cond do
      conn.assigns[:user] -> conn
      true ->
        conn
        |> put_flash(:error, "You must be logged in")
        |> redirect(to: topic_path(conn, :index))
        # module plugs are slighly different than phoenix common plugs
        # so it is not enough with just redirect cuz from this plug it should
        # tell to phoenix, this conn is done for, passing the connection to halt
        |> halt
    end

  end
end
