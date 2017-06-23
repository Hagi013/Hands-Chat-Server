defmodule HandsChatServer.ChatUser do
  use HandsChatServer.Web, :model

  @derive{Poison.Encoder, only: [:id, :name, :image, :profile]}
  schema "chat_users" do
    field :name, :string
    field :image, :string
    field :profile, :string
    many_to_many :channels, HandsChatServer.ChatChannel, join_through: "channels_users"
    has_many :message_froms, HandsChatServer.ChatMessage
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :image, :profile])
    |> cast_assoc(:channels, [:name, :purpose])
    |> cast_assoc(:message_froms, [:text, :image])
    |> validate_required([:name, :image, :profile])
  end
end
