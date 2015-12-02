defmodule JsonapiOverhaul.User do
  use JsonapiOverhaul.Web, :model

  schema "users" do
    field :name, :string
    belongs_to :company, JsonapiOverhaul.Company

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(company_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
