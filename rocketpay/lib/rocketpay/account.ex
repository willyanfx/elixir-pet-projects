defmodule Rocketpay.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rocketpay.User

  # define o formato da chave
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:balance, :user_id]

  # defini schema
  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  # %__MODULE__{} é uma struct vazia
  # changeset de criacao de vazia
  #  ou changeset the update, comeca uma struct
  # \\ é um valor default
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end
