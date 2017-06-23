defmodule HandsChatServer.Repo.Migrations.CreateChatUser do
  use Ecto.Migration

  def change do
    create table(:chat_users) do
      add :name, :string
      add :image, :text
      add :profile, :text

      timestamps()
    end

  end
end
