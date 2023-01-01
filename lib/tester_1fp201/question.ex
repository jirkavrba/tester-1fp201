defmodule Tester1fp201.Question do
  @moduledoc """
  A common behaviour implemented by all questions so that they can be rendered easily in one place
  """

  @doc "Generate assigns for the given seed"
  @callback assigns() :: map()

  @doc "Render the questions with assigns returned by calling the assigns function"
  @callback render_question(assigns :: map()) :: Phoenix.LiveView.Rendered.t()

  @doc "Render the solution with assigns returned by calling the assigns function"
  @callback render_solution(assigns :: map()) :: Phoenix.LiveView.Rendered.t()
end
