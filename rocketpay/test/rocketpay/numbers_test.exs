defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "has a file w given name" do
      response = Numbers.sum_from_file("numbers")
      expected_response = {:ok, %{result: 55}}

      assert response == expected_response
    end

    test "has no file w given name" do
      response = Numbers.sum_from_file("banna")
      expected_response = {:error, %{message: "Invalid file"}}

      assert response == expected_response
    end
  end
end
