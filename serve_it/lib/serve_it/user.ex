defmodule User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    # id field is implicit
    field :first_name, :string
    field :last_name, :string

    timestamps
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name])
  end
end
