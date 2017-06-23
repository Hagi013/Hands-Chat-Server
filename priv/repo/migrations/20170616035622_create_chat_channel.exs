defmodule HandsChatServer.Repo.Migrations.CreateChatChannel do
  use Ecto.Migration

  def change do
    create table(:chat_channels) do
      timestamps()
    end

  end
end
