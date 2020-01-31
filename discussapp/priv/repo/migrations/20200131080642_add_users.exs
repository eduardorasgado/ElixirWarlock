defmodule Discussapp.Repo.Migrations.AddUsers do
  use Ecto.Migration
  @moduledoc """
  Note that migration should be run by typing
  mix ecto.gen.migration add_users
  and users should be in plural form
  """

  def change do
    # remember that create here is a macro
    create table(:users) do
      add :email, :string
      # keep tracking,  who do they originally sign in with
      add :provider, :string
      add :token, :string
      # it creates timestamps for our table, inserted_at, created_at
      timestamps()
    end
  end
end
