defmodule Discussapp.PageController do
  use Discussapp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
