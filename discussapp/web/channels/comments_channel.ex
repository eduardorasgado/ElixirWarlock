defmodule Discussapp.CommentsChannel do
  use Discussapp.Web, :channel

  # join function is called whenever every js connection comes to our channel
  # topic, payload, socket
  #see https://hexdocs.pm/phoenix/Phoenix.Channel.html#c:code_change/3
  def join(name, _payload, socket) do
    IO.puts "-----------------"
    IO.puts name
    { :ok, %{}, socket }
  end

  def handle_in() do

  end

end
