defmodule Tester1fp201.Questions.Question3 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      interest_rate: Enum.random([5.2, 5.4, 5.6, 5.8, 6.2, 6.4, 6.6]),
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      <p>
        Vaše banka nabízí Vašim klientům jeden typ účtu DC spojený s
        <strong><%= @interest_rate %>% roční nominální úrokovou mírou</strong>
        a s <strong>denním</strong>
        skládáním úroků.
        Jeden z Vašich dobrých klientů však požaduje <strong>čtvrtletní</strong>
        skládání (účet QC).
      </p>

      <p>
        Jakou výši roční nominální úrokové sazby při tomto skládání mu nabídnete,
        chcete-li zachovat stejné podmínky pro oba druhy účtů?
      </p>

      <small>Poznámka: rok má 360 dnů</small>
    </div>
    """
  end

  @impl true
  def render_solution(%{interest_rate: i}) do
    i = i / 100

    eum_dc = :math.pow(1 + i / 360, 360) - 1
    num_qc = (:math.pow(1 + eum_dc, 1 / 4) - 1) * 4

    assigns = %{
      answer: num_qc
    }

    ~H"""
    <div>
      <%= :erlang.float_to_binary(@answer * 100, decimals: 3) %> %
      <!-- TODO: Add solution in latex -->
    </div>
    """
  end
end
