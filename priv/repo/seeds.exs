# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     JsonapiOverhaul.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias JsonapiOverhaul.Repo
alias JsonapiOverhaul.Company
alias JsonapiOverhaul.User

Repo.insert!(%Company{name: "Santander"})
Repo.insert!(%User{name: "Alexandre", company_id: 1})
Repo.insert!(%User{name: "Bruno", company_id: 1})
Repo.insert!(%User{name: "Carlos", company_id: 1})
