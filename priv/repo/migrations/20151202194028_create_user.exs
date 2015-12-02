defmodule JsonapiOverhaul.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :company_id, references(:companies)

      timestamps
    end
    create index(:users, [:company_id])

  end
end
