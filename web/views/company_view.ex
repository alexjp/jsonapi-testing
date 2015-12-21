defmodule JsonapiOverhaul.CompanyView do
  use JSONAPI.View
  alias JsonapiOverhaul.CompanyView

  def render("index.json", %{companies: companies, conn: conn, params: params}) do
    CompanyView.index(companies, conn, params)
  end

  def render("show.json", %{company: company, conn: conn, params: params}) do
    CompanyView.show(company, conn, params)
  end


  def fields(), do: [:name]
  def type(), do: "company"
  # def includes(), do: [users: {JsonapiOverhaul.UserView, :include}]
  # def relationships(), do: [users: JsonapiOverhaul.UserView]

end
