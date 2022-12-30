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
    eum_dc_sqrt = :math.pow(1 + eum_dc, 1 / 4) - 1
    eum_dc_sqrt1 = :math.pow(1 + eum_dc, 1 / 4)
    num_qc = (:math.pow(1 + eum_dc, 1 / 4) - 1) * 4

    assigns = %{
      answer: :erlang.float_to_binary(num_qc * 100, decimals: 3),
      num_qc: :erlang.float_to_binary(num_qc, decimals: 6),
      eum_dc: :erlang.float_to_binary(eum_dc, decimals: 6),
      eum_dc1: :erlang.float_to_binary(eum_dc + 1, decimals: 6),
      eum_dc_sqrt: :erlang.float_to_binary(eum_dc_sqrt, decimals: 6),
      eum_dc_sqrt1: :erlang.float_to_binary(eum_dc_sqrt1, decimals: 6),
      interest_rate: :erlang.float_to_binary(i, decimals: 3),
    }

    ~H"""
    <div>
      <strong><%= @answer %> %</strong>

      <p>
        \[
          \begin{align*}
            \text{EÚM}_{DC} &= (1 + \frac{<%= @interest_rate %>}{360})^{360} = <%= @eum_dc %> \\
            \text{EÚM}_{QC} &= \text{EÚM}_{DC} \Rightarrow \text{EÚM}_{QC} = <%= @eum_dc %>
          \end{align*}
        \]
        \[
          \begin{align*}
            <%= @eum_dc %> &= (1 + \frac{\text{NÚM}_{QC}}{4})^{4} - 1 \\
            <%= @eum_dc1 %> &= (1 + \frac{\text{NÚM}_{QC}}{4})^{4} \\
            \sqrt[4]{<%= @eum_dc1 %>} &= 1 + \frac{\text{NÚM}_{QC}}{4} \\
            <%= @eum_dc_sqrt1 %> &= 1 + \frac{\text{NÚM}_{QC}}{4} \\
            \text{NÚM}_{QC} &= <%= @eum_dc_sqrt %> \cdot 4 \\
            \text{NÚM}_{QC} &= <%= @num_qc %>
          \end{align*}
        \]
      </p>
    </div>
    """
  end
end
