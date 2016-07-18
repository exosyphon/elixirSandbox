defmodule ServeItTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @website_router_opts ServeIt.init([])
  test "returns a user" do
    ServeIt.Repo.start_link
    changeset = User.changeset(%User{}, %{id: 1, first_name: "Chase", last_name: "D"})
    ServeIt.Repo.insert_or_update(changeset)
    conn = conn(:get, "/users/1")
    conn = ServeIt.call(conn, @website_router_opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert String.match?(conn.resp_body, ~r/Chase/)
  end
end
