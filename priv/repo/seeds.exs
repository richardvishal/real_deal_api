# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RealDealApi.Repo.insert!(%RealDealApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias RealDealApi.Accounts

Accounts.create_account(%{
  email: "richie@gmail.com",
  hash_password: "thisishashpassword"
})
