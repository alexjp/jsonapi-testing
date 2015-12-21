defmodule JsonapiOverhaul.CompanyControllerTest do
  use JsonapiOverhaul.ConnCase

  alias JsonapiOverhaul.Company
  @valid_attrs %{ type: "company", attributes: %{name: "TestCompany"}}
  @create_valid_attrs %{ type: "companies", attributes: %{name: "TestCompany"}}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, company_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = get conn, company_path(conn, :show, company)
    assert String.to_integer(json_response(conn, 200)["data"]["id"]) == company.id
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, company_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, company_path(conn, :create), data: @create_valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Company, @create_valid_attrs.attributes)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, company_path(conn, :create), data: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = put conn, company_path(conn, :update, company), %{id: company.id, data: @valid_attrs}
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Company, @valid_attrs.attributes)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = put conn, company_path(conn, :update, company), data: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = delete conn, company_path(conn, :delete, company)
    assert response(conn, 204)
    refute Repo.get(Company, company.id)
  end
end
