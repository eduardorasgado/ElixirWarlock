defmodule Discussapp.Repo.Migrations.AddUserIdToTopics do
  @moduledoc """
  This migration represents the model relation between user and topics
  one to many

  This migration was created by typing
    mix ecto.gen.migration add_user_id_to_topics

  to execute the migration we must run:
    mix ecto.migrate
  """
  use Ecto.Migration

  def change do
    # we dont want to create a new table, just alter a table
    alter table(:topics) do
      # referencing user table, looking for id column
      add :user_id, references(:users)
    end
  end
end
