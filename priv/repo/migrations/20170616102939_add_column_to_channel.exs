defmodule HandsChatServer.Repo.Migrations.AddColumnToChannel do
  use Ecto.Migration

  def change do
    alter table(:chat_channels) do
        add :name, :string
        add :purpose, :text
    end
  end
end
