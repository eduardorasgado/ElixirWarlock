defmodule Discussapp.Repo.Migrations.AddComments do
  @moduledoc """
  Generated with mix ecto.gen.migration add_comments
  generate migration by mix ecto.migrate

  this command will generate a table with all the fields
  """
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      # users that owns the comment
      add :user_id, references(:users)
      # topic which is commented the element
      add :topic_id, references(:topics)
      # default time stamps
      timestamps()
    end
  end
end
