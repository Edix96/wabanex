
defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Natalia", email: "natalia@matelo.com", password: "129434"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{name: "Natalia", email: "natalia@matelo.com", password: "129434"},
               errors: []
             } = response
    end
    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "R", email: "R@matelo.com"}

      response = User.changeset(params)

      expected_reponse =  %{
        name: ["should be at least 2 character(s)"],
         password: ["can't be blank"]
        }

      assert errors_on(response) == expected_reponse
    end
  end
end

