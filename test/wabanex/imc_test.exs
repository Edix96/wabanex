defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1"  do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok, %{
          "Dani" => 26.666666666666668,
           "Diogo" => 23.04002019946976,
            "Francisco" => 28.124999999999993,
             "Rafael" => 24.897060231734173
        }}

      assert response == expected_response
    end

    test "when the wrong filename is given, returns an error" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}

      assert response == expected_response
    end
  end
end
