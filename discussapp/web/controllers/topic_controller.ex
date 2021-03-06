defmodule Discussapp.TopicController do
  use Discussapp.Web, :controller
  # this is how to reduce code by avoid writing complete module names
  alias Discussapp.Topic
  @moduledoc """
  By convention, controller should be named as single element:
  TopicController and not TopicsController
  """

  # plug this controller, 'when' clause is called a GUARD
  # it let coder defines where to apply this plug
  plug Discussapp.Plugs.RequireAuth
    when action in [:new, :create, :edit, :update, :delete]

  plug :check_post_owner when action in [:update, :edit, :delete]

  @doc """
  This function return a list of all topics registered by users
  """
  def index(conn, _params) do
    # can see docs: https://hexdocs.pm/ecto/Ecto.Repo.html#c:all/2
    # topics = Repo.all(Topic)
    # same thing to fetch all topics, but ordered by id(postgres by default does not have
    # an order in tables):
    query = from topic in Topic,
            select: topic,
            order_by: topic.id

    topics = Repo.all(query)
    # returning the map of all topics elements but reversed
    topics = Enum.reverse topics
    render conn, "index.html", topics: topics
  end

  @doc """
    Return specific post and its comments
  """
  def show(conn, %{ "id" => topic_id }) do
    topic = Repo.get!(Topic, topic_id)
    render conn, "show.html", topic: topic
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
  def create(conn, %{ "topic" => topic } = _request) do
    # getting data from request(params)
    # to assign the topic relation we should get the user by conn.assigns[:user]
    # topic without user association
    # changeset = Topic.changeset %Topic{}, topic

    # getting the user associated to it
    # see how build_assoc works https://hexdocs.pm/ecto/Ecto.html#build_assoc/3
    # getting a %User{}
    changeset = conn.assigns[:user]
      #build_assoc(actual_user, topics table)
      # this produce a topic struct %Topic{data, user_id: 2}
      |> build_assoc(:topics)
      # changeset(%Topic{}, topic) where topic struct has already the user_id
      # and topic is the topic data from params
      |> Topic.changeset(topic)

    # we can use Repo struct because it was inserted into web.ex base controller fn
    # handling each one of the responses
    # :info will make alert message apears in view thanks to some elixir
    # eex helpers in web.templates.layout.app
    case Repo.insert(changeset) do
       { :ok, _topic }->
          conn
          |> put_flash(:info, "Topic Successfully created")
          |> redirect(to: topic_path(conn, :index))
       { :error, changeset } ->
          render conn, "new.html",changeset: changeset
    end
  end

  @doc """
  This method returns a form for specific id topic
  """
  def edit(conn, %{ "id" => topic_id }) do
    # id should be same as named in route wildcard in router.ex
    # changeset that is going to be showed in form
    topic = Repo.get(Topic, topic_id)
    # we are not passing second argument cuz changeset function has default params
    changeset = Topic.changeset topic

    # we should pass both changeset and topic even if topic is inside changeset
    render conn, "edit.html", changeset: changeset, topic: topic
  end

  @doc """
  This function save the new data of the topic user wants to update
  """
  def update(conn, %{ "id" => topic_id, "topic" => topic }) do
    # saving data and redirecting user
    # using pipe as it is elixir code
    old_topic = Repo.get(Topic, topic_id)
    changeset =  Topic.changeset old_topic, topic

    case Repo.update(changeset) do
      { :ok, _topic } ->
        conn
      |> put_flash(:info, "Topic Successfully updated")
      |> redirect(to: topic_path(conn, :index))
      { :error, changeset } ->
        #returning the same we return in edit, error message for form is in changeset
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  @doc """
  This function deletes a topic given topic id
  """
  def delete(conn, %{"id" => topic_id}) do

    # in case topic does not exists we will throw an error message
    Repo.get!(Topic, topic_id)
      |> Repo.delete!

    conn
      |> put_flash(:info, "Topic was deleted")
      |> redirect(to: topic_path(conn, :index))
  end

  @doc """
  Plug to parse an action given the ownership of a users post
  """
  def check_post_owner(conn, _params) do
    # id comes from resources in router
    %{params: %{"id" => topic_id}} = conn
    # if topic to be handle is owned by the user signed then give permission.
    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      # becaus a plug cannot redirect by itself we need to halt the connection
      |> halt()
    end
  end
end
