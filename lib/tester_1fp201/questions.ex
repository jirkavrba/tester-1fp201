defmodule Tester1fp201.Questions do
  @questions [
    Tester1fp201.Questions.Question1,
    Tester1fp201.Questions.Question2,
    Tester1fp201.Questions.Question3,
    Tester1fp201.Questions.Question4,
    Tester1fp201.Questions.Question5,
    Tester1fp201.Questions.Question6,
  ]

  @type rendered_question :: %{
          question: Phoenix.LiveView.Rendered.t(),
          solution: Phoenix.LiveView.Rendered.t()
        }

  @spec all(binary()) :: list(rendered_question())
  def all(seed) when is_binary(seed) do
    :rand.seed(:exsss, :erlang.phash2(seed))

    @questions
    |> Enum.map(fn question -> {question, question.assigns()} end)
    |> Enum.map(fn {question, assigns} ->
      %{
        question: question.render_question(assigns),
        solution: question.render_solution(assigns)
      }
    end)
  end
end
