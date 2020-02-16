defmodule Discussapp.UserSocket do
  @moduledoc """
  WebSockets is a protocol for exchanging dynamic and live information
  between a client and a server

  Phoenix supports websockets and long pooling

  Long pooling is an alternative means of doinf that exact same thing but
  works by using traditional http request
  """
  use Phoenix.Socket

  ## Channels
  # channel "room:*", Discussapp.RoomChannel
  # phoenix will handle everything that comes from  comments colon anything
  # and be handle by CommentsChannel
  channel "comments:*", Discussapp.CommentsChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # whenever a JS client connects to our server socket
  def connect(_params, socket) do
    {:ok, socket}
  end

  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
