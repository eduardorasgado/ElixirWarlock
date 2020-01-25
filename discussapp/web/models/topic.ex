defmodule Discussapp.Topic do
  use Discussapp.Web, :model

  @doc """
  Defining table data validation for our topic model
  Topics is the table name as it was created in topics migration file
  """
  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [ :title ])
    |> validate_required([ :title ])
  end

end
