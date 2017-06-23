defmodule HandsChatServer.Repo.Migrations.AssociateChannelAndUser do
  use Ecto.Migration

  def change do
    alter table(:chat_channels) do
      add :channel_members, references(:chat_channels, on_delete: :nothing)
    end

    create table(:channels_users, primary_key: false) do
      add :chat_channel_id, references(:chat_channels, on_delete: :delete_all)
      add :chat_user_id, references(:chat_users, on_delete: :delete_all)
    end

  end
end
