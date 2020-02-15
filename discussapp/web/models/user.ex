defmodule Discussapp.User do
  use Discussapp.Web, :model
  @moduledoc """
  It defines the user table model and a way to create a user data struct
  to handle user data modifications
  """
  schema "users" do
    field :email, :string
    field :username, :string
    field :provider, :string
    field :token, :string
    # defining the user - topics model relation
    # if we define the relation here, the same should be in topic model, but belongs to rel
    # note that topics refers to topics schema and it is in plural form
    has_many :topics, Discussapp.Topic
    has_many :comments, Discussapp.Comment
    timestamps() # timestamps does not need to have specifications
  end

  @doc """
  to create a changeset struct and evaluate data
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :email,
                      :username,
                      :provider,
                      :token ])
    |> validate_required([ :email,
                           :username,
                           :provider,
                           :token ])
  end

end
