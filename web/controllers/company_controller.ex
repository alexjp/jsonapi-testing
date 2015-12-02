defmodule JsonapiOverhaul.CompanyController do
  use JsonapiOverhaul.Web, :controller

  alias JsonapiOverhaul.Company

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, params) do
    companies = Repo.all(Company)
    render(conn, "index.json", %{companies: companies, conn: conn, params: params})
  end

  def create(conn, %{"data" => %{ "type" => "companies", "attributes" => company_params}}) do
    changeset = Company.changeset(%Company{}, company_params)

    case Repo.insert(changeset) do
      {:ok, company} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", company_path(conn, :show, company))
        |> render("show.json", %{company: company, conn: conn, params: company_params})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(JsonapiOverhaul.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Repo.get!(Company, id)
    render(conn, "show.json", %{company: company, conn: conn, params: id})
  end

  def update(conn, %{"id" => id, "data" => %{ "type" => "company", "attributes" => company_params}}) do
    company = Repo.get!(Company, id)
    changeset = Company.changeset(company, company_params)

    case Repo.update(changeset) do
      {:ok, company} ->
        render(conn, "show.json", %{company: company, conn: conn, params: company_params})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(JsonapiOverhaul.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Repo.get!(Company, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(company)

    send_resp(conn, :no_content, "")
  end
end
