defmodule Discussapp.TopicController do
  use Discussapp.Web, :controller
  # this is how to reduce code by avoid writing complete module names
  alias Discussapp.Topic
  @moduledoc """
  By convention, controller should be named as single element:
  TopicController and not TopicsController
  """

  @doc """
  This function return a list of all topics registered by users
  """
  def index(conn, _params) do
    # can see docs: https://hexdocs.pm/ecto/Ecto.Repo.html#c:all/2
    #query = from topic in Topic, select: topic
    #IO. inspect Repo.all(query)
    # same thing to fetch all topics:
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  @doc """
  This function handles the form to create a new topic
  """
  def new(conn, _params) do
    # we create a change set to merge this  with a form to
    # be able to create a new topic
    changeset = Topic.changeset %Topic{}, %{}
    # passing changeset as a custom variable, separated by commas
    render conn, "new.html", changeset: changeset
  end

  @doc """
  This function resolves for new topic creation
  """
  def create(conn, %{ "topic" => %{"title" => title} } = request) do
    # getting data from request(params)
    changeset = Topic.changeset %Topic{}, %{"title" => title}

    # we can use Repo struct because it was inserted into web.ex base controller fn
    # handling each one of the responses
    case Repo.insert(changeset) do
       { :ok, post }->
          IO.inspect post
       { :error, changeset } ->
          render conn, "new.html",changeset: changeset
    end
  end
end
