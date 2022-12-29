defmodule Tester1fp201.Questions.Question2 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      b: :rand.uniform()
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      Otázka 2
    </div>
    """
  end

  @impl true
  def render_solution(assigns) do
    ~H"""
    <div>
      Odpověď 2
      b: <%= assigns.b %>
    </div>
    """
  end
end
