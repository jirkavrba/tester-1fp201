defmodule Tester1fp201.Questions.Question9 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      years: Enum.random(2..6),
      first_payment: Enum.random(2..5) * 1_000_000,
      additional_payments: Enum.random(3..6) * 100_000,
      interest_rate: Enum.random(2..7)
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      <p>
        Za kolik (tj. otázka na současnou hodnotu domu) jste vlastně prodali Váš bývalý dům,
        pokud první platba provedená dnes byla ve výši <strong><%= @first_payment %> Kč</strong>
        a dále budou následovat <strong><%= @years %></strong>
        platby po <strong><%= @additional_payments %> Kč</strong>
        na konci každého roku?
      </p>
      <p>
        Zvažujete <strong><%= @interest_rate %>% roční nominální úrokovou míru</strong>
        s <strong>ročním</strong>
        skládáním úroků. Od zdanění abstrahujete.
      </p>
    </div>
    """
  end

  @impl true
  def render_solution(%{years: n, first_payment: p1, additional_payments: pn, interest_rate: i}) do
    i = i / 100
    result = p1 + (1 - :math.pow(1 + i, -n)) / i * pn

    assigns = %{
      years: n,
      interest_rate: :erlang.float_to_binary(i, decimals: 2),
      first_payment: p1,
      additional_payments: pn,
      result: :erlang.float_to_binary(result, decimals: 2)
    }

    ~H"""
    <div>
      <strong><%= @result %> Kč</strong>

      <p>
        \[
        PV = <%= @first_payment %> + <%= @additional_payments %> \cdot \frac{1 - (1 + <%= @interest_rate %>)^{-<%= @years %>}}{<%= @interest_rate %>} = <%= @result %> \]
      </p>
    </div>
    """
  end
end
