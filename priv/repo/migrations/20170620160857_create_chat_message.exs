defmodule HandsChatServer.Repo.Migrations.CreateChatMessage do
  use Ecto.Migration

  def change do
    create table(:chat_messages) do
      add :text, :text
      add :image, :text
      add :from_chat_user_id, references(:chat_users, on_delete: :nothing)
      add :chat_channel_id, references(:chat_channels, on_delete: :nothing)

      timestamps()
    end
    create index(:chat_messages, [:from_chat_user_id])
    create index(:chat_messages, [:chat_channel_id])

  end
end
