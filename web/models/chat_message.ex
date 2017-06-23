defmodule HandsChatServer.ChatMessage do
  use HandsChatServer.Web, :model

  schema "chat_messages" do
    field :text, :string
    field :image, :string
    belongs_to :from_chat_user, HandsChatServer.ChatUser, foreign_key: :from_chat_user_id
    belongs_to :chat_channel, HandsChatServer.ChatChannel,foreign_key: :chat_channel_id

    timestamps()
  end

  @required_fields ~w(text image from_chat_user chat_channel)


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :image])
    |> cast_assoc(:from_chat_user, [:id])
    |> cast_assoc(:chat_channel, [:id])
    |> foreign_key_constraint(:from_chat_user, [:id])
    |> foreign_key_constraint(:chat_channel, [:id])
    |> validate_required([:text, :image])

  end

end
