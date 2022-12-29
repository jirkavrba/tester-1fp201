defmodule Tester1fp201Web.ErrorJSONTest do
  use Tester1fp201Web.ConnCase, async: true

  test "renders 404" do
    assert Tester1fp201Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Tester1fp201Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
