defmodule Discussapp.TopicController do
  use Discussapp.Web, :controller
  # this is how to reduce code by avoid writing complete module names
  alias Discussapp.Topic
  @moduledoc """
  By convention, controller should be named as single element:
  TopicController and not TopicsController
  """

  @doc """
  This function handles the form to create a new topic
  """
  def new(conn, _params) do
    # we create a change set to merge this  with a form to
    # be able to create a new topic
    changeset = Topic.changeset %Topic{}, %{}
    render conn, "new.html"
  end
end
