defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id id given, returns the user", %{conn: conn} do
      params = %{name: "Natalia", email: "natalia@matelo.com", password: "129434"}

      {:ok, %User{id: user_id}} = Wabanex.Users.Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}"){
          name
          email
        }
      }
      """
      response =
        conn
        |> post("api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{
          "data" => %{
            "getUser" => %{
              "email" => "natalia@matelo.com",
              "name" => "Natalia"
              }
            }
          }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
      mutation {
        createUser(input: {name: "Jãoa", email:"joao@fnefk.com", password:"fjejfnja"}){
        id
        name
      }
    }
      """


    response =
      conn
      |> post("api/graphql", %{query: mutation})
      |> json_response(:ok)

  assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Jãoa"}}} = response
    end
  end
end
