defmodule HandsChatServer.ChatMessage do
  use HandsChatServer.Web, :model

  schema "chat_messages" do
    field :text, :string
    field :image, :string
    belongs_to :from_chat_user, HandsChatServer.ChatUser
    belongs_to :chat_channel, HandsChatServer.ChatChannel

    timestamps()
  end

  @required_fields ~w(text image from_chat_user chat_channel)


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :image, :from_chat_user_id, :chat_channel_id])
    |> assoc_constraint(:from_chat_user)
    |> assoc_constraint(:chat_channel)
    |> foreign_key_constraint(:from_chat_user_id)
    |> foreign_key_constraint(:chat_channel_id)
    |> validate_required([:text, :image, :from_chat_user_id, :chat_channel_id])

  end


end
