defmodule Discussapp.Topic do
  use Discussapp.Web, :model

  @doc """
  Defining table data validation for our topic model
  """
  schema "topics" do
    field :title, :string
  end

end
