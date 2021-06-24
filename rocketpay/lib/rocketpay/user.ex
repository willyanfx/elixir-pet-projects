defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  # define o formato da chave
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :nickname]

  # defini schema
  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    timestamps()
  end

  # %__MODULE__{} é uma struct vazia
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/^[[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-.]+)*$/iu)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
