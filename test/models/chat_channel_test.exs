defmodule HandsChatServer.ChatChannelTest do
  use HandsChatServer.ModelCase

  alias HandsChatServer.ChatChannel

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ChatChannel.changeset(%ChatChannel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ChatChannel.changeset(%ChatChannel{}, @invalid_attrs)
    refute changeset.valid?
  end
end
