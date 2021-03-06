defmodule Discussapp.Topic do
  use Discussapp.Web, :model

  @doc """
  Defining table data validation for our topic model
  Topics is the table name as it was created in topics migration file
  """
  schema "topics" do
    field :title, :string
    # defining two direction relation is critical to define a relation with ecto
    # ecto will create the user_id using the model_id syntax
    # note that user is not in plural because it not means for db schema
    belongs_to :user, Discussapp.User
    has_many :comments, Discussapp.Comment
  end

  @doc """
  This function creates a Ecto.changeset struct with action, changes
  and errors for validating new data for a db record change(in params)
  and accordingly to actual record data(struct)

  backward slash backward slash %{} is the way to assign default values in elixir

  This function returns a changeset too
  """
  def changeset(struct, params \\ %{}) do
    struct
    # records ow we want to update our database like the new props want to stick in there
    |> cast(params, [ :title ])
    # make sure the changeset contents a title prop
    |> validate_required([ :title ])
  end

end
