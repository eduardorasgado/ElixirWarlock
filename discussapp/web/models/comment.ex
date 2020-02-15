defmodule Discussapp.Comment do
  use Discussapp.Web, :model

  schema "comments" do
    field :content, :string
    # defining the relations with topic and user
    # these relations should correspond in proper model
    belongs_to :topic, Discussapp.Topic
    belongs_to :user, Discussapp.User
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :content ])
    |> validate_required([ :content ])
  end

end
