defmodule Tester1fp201.Questions.Question6 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      years: Enum.random(5..8),
      yield: Enum.random(1..5) * 1_000_000,
      interest_rate: Enum.random([2.5, 2.8, 3.2, 3.6, 3.8, 4.2]),
      tax: Enum.random([15, 20, 25])
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      <p>
        Kolik musíte uložit na účet, abyste si mohli za <strong><%= @years %> let</strong>
        z tohoto účtu vyzvednout <strong><%= @yield %> Kč</strong>?
      </p>
      <p>
        Účet je spojený s <strong><%= @interest_rate %>% roční nominální úrokovou mírou</strong>
        a <strong>měsíčním</strong>
        skládáním úroků.
        Zdanění úroků uvažujte ve výši <strong><%= @tax %> %</strong>.
      </p>
    </div>
    """
  end

  @impl true
  def render_solution(%{years: n, yield: y, interest_rate: i, tax: t}) do
    i = i / 100
    cum = i * (1 - t / 100)
    result = y / :math.pow(1 + cum / 12, n * 12)

    assigns = %{
      yield: y,
      years: n,
      interest_rate: :erlang.float_to_binary(i, decimals: 4),
      cum: :erlang.float_to_binary(cum, decimals: 4),
      tax: :erlang.float_to_binary(t / 100, decimals: 2),
      result: :erlang.float_to_binary(result, decimals: 2)
    }

    ~H"""
    <div>
      <strong><%= @result %> Kč</strong>

      <p>
        \[
        \begin{align*}
        \text{ČÚM} &= <%= @interest_rate %> \cdot (1 - <%= @tax %>) &= <%= @cum %> \\
        \\
        x \cdot \left(1 + \frac{<%= @cum %>}{12} \right)^{<%= @years %> \cdot 12} &= <%= @yield %> \\
        x &= \frac{<%= @yield %>}{\left(1 + \frac{<%= @cum %>}{12}\right)^{<%= @years %> \cdot 12}} \\
        x &= <%= @result %> \end{align*}
        \]
      </p>
    </div>
    """
  end
end
