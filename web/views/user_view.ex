defmodule JsonapiOverhaul.UserView do
  use JSONAPI.View
  alias JsonapiOverhaul.UserView

  def render("index.json", %{users: users, conn: conn, params: params}) do
    UserView.index(users, conn, params)
  end

  def render("show.json", %{user: user, conn: conn, params: params}) do
    UserView.show(user, conn, params)
  end


  def fields(), do: [:id, :name, :company_id]
  def type(), do: "user"
  def includes(), do: [company: {JsonapiOverhaul.CompanyView, :include}]

end
