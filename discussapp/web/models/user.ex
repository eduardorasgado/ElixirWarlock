defmodule Discussapp.User do
  use Discussapp.Web, :model
  @moduledoc """
  It defines the user table model and a way to create a user data struct
  to handle user data modifications
  """
  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    timestamps() # timestamps does not need to have specifications
  end

  @doc """
  to create a changeset struct and evaluate data
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :email,
                      :provider,
                      :token ])
    |> validate_required([ :email,
                           :provider,
                           :token ])
  end

end
