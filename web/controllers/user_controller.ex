defmodule JsonapiOverhaul.UserController do
  use JsonapiOverhaul.Web, :controller

  alias JsonapiOverhaul.User

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, params) do
    users = Repo.all(User)
    render(conn, "index.json", %{users: users, conn: conn, params: params})
  end

  def create(conn, %{"data" => %{ "type" => "users", "attributes" => user_params}}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", %{user: user, conn: conn, params: user_params})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(JsonapiOverhaul.ChangesetView, "error.json", changeset: changeset)
    end
  end
  def create(conn, _)  do
    conn
    |> put_status(:unprocessable_entity)
    |> render(JsonapiOverhaul.ChangesetView, "error.json", changeset: %{error: "invalid data"})
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    render(conn, "show.json", %{user: Repo.preload(user, [:company]), conn: conn, params: id})
  end

  def update(conn, %{"id" => id, "data" => %{ "type" => "user", "attributes" => user_params}}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", %{user: user, conn: conn, params: user_params})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(JsonapiOverhaul.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, _)  do
    conn
    |> put_status(:unprocessable_entity)
    |> render(JsonapiOverhaul.ChangesetView, "error.json", changeset: %{error: "invalid data"})
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end
end
