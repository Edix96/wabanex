defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, return the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}
      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

        expected_response = %{
          "result" => %{
            "Dani" => 26.666666666666668,
            "Diogo" => 23.04002019946976,
            "Francisco" => 28.124999999999993,
            "Rafael" => 24.897060231734173
          }
        }

      assert response == expected_response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{"filename" => "banana.csv"}
      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

        expected_response = %{"result" => "Error while opening the file"}

      assert response == expected_response
    end
  end
end
