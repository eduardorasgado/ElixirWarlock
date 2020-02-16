defmodule Discussapp.CommentsChannel do
  use Discussapp.Web, :channel

  # 4 ) joining to the web socket and piping to the javascript client with a map

  # join function is called whenever every js connection comes to our channel
  # topic, payload, socket
  #see https://hexdocs.pm/phoenix/Phoenix.Channel.html#c:code_change/3
  def join(name, _payload, socket) do
    IO.puts "-----------------"
    IO.puts name
    { :ok, %{hey: "there"}, socket }
  end

  def handle_in() do

  end

end
