defmodule HandsChatServer.ChatChannel do
  use HandsChatServer.Web, :model

  @derive{Poison.Encoder, only: [:id, :name, :purpose]}
  schema "chat_channels" do
    field :name, :string
    field :purpose, :string
    many_to_many :members, HandsChatServer.ChatUser, join_through: "channels_users", on_replace: :delete
    has_many :messages, HandsChatServer.ChatMessage
    timestamps()
  end

  @required_fields ~w(name purpose)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    IO.inspect params["members"]
    struct
    |> cast(params, [:name, :purpose])
    |> put_assoc(:members, parse_members(params["members"]))
    |> validate_required([:name, :purpose])
  end

  defp parse_members(members) do
    IO.inspect members
    (members || "")
    |> Enum.map(&get_or_insert_user/1)
  end


  defp get_or_insert_user(members) do
    IO.inspect members
    Repo.insert!(%HandsChatServer.ChatUser{id: members["id"], name: members["name"], image: members["image"], profile: members["profile"]}, on_conflict: :replace_all, conflict_target: :id)
  end

end
