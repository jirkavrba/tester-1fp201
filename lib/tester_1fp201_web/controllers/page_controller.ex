defmodule Tester1fp201Web.PageController do
  alias Tester1fp201.Questions
  use Tester1fp201Web, :controller

  def home(conn, %{"seed" => seed}) do
    render(conn, :home,
      layout: false,
      questions: Questions.all(seed),
      next_seed: generate_random_seed()
    )
  end

  def home(conn, _params) do
    conn
    |> redirect(to: "/?seed=#{generate_random_seed()}")
  end

  @spec generate_random_seed() :: binary()
  defp generate_random_seed() do
    :erlang.unique_integer()
    |> to_string()
    |> then(fn seed -> :crypto.hash(:md5, seed) end)
    |> Base.encode16()
    |> String.downcase()
  end
end
