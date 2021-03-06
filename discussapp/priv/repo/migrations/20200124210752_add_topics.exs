defmodule Discussapp.Repo.Migrations.AddTopics do
  # to create a database see dev.exs
  use Ecto.Migration
  @moduledoc """
  This file was generated by next command:
      iex> mix ecto.gen.migration add_topics
      To be able to migrate this, execute next command:
      iex> mix ecto.migrate
  """

  def change do
    # remember that create here is a macro
    # new table named 'topics', it will have a title and a string column
    create table(:topics) do
      add :title, :string
    end
  end
end
