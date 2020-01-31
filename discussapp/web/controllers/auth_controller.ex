defmodule Discussapp.AuthController do
  use Discussapp.Web, :controller
  @moduledoc """
  This will be responsible for all user authentication
  """
  #the plug keyword is an elixir macro
  plug Ueberauth

  @doc """
  Handling any information that comes from github
  """
  def callback(conn, params) do
    IO.inspect "+++++++++"
    IO.inspect conn.assigns
    IO.inspect "+++++++++"
    IO.inspect params
    IO.inspect "+++++++++"
  end

end
