defmodule Tester1fp201.Questions.Question1 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns(seed) when is_binary(seed) do
    %{}
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      Otázka 1
    </div>
    """
  end

  @impl true
  def render_solution(assigns) do
    ~H"""
    <div>
      Odpověď 1
    </div>
    """
  end
end
