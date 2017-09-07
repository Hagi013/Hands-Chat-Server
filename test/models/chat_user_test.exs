defmodule HandsChatServer.ChatUserTest do
  use HandsChatServer.ModelCase

  alias HandsChatServer.ChatUser

  @valid_attrs %{image: "some content", name: "some content", profile: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ChatUser.changeset(%ChatUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ChatUser.changeset(%ChatUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
