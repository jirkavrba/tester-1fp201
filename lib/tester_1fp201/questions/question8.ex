defmodule Tester1fp201.Questions.Question8 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      years: Enum.random(5..10),
      yield: Enum.random(3..9) * 10_000_000,
      interest_rate: Enum.random(2..6),
      tax: Enum.random([15, 19, 20, 25])
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      <p>
        Jak velkou částku musíte na začátku každého roku dát na spoření, abyste měli koncem
        <strong><%= @years %>. roku</strong>
        k dispozici <strong><%= @yield %> Kč</strong>?
      </p>
      <p>
        Své úspory dáváte na účet s
        <strong><%= @interest_rate %>% roční nominální úrokovou sazbou</strong>
        a s <strong>ročním</strong>
        skládáním úroků.
        Úrok musíte dále zdanit <strong><%= @tax %>%</strong>
        sazbou daně z příjmu.
      </p>
    </div>
    """
  end

  @impl true
  def render_solution(%{years: n, yield: y, interest_rate: i, tax: t}) do
    i = i / 100
    cum = i * (1 - t / 100)
    az = y * (cum / (:math.pow(1 + cum, n) - 1))
    result = az / (1 + cum)

    assigns = %{
      yield: y,
      years: n,
      interest_rate: :erlang.float_to_binary(i, decimals: 2),
      cum: :erlang.float_to_binary(cum, decimals: 4),
      az: :erlang.float_to_binary(az, decimals: 2),
      tax: :erlang.float_to_binary(t / 100, decimals: 2),
      result: :erlang.float_to_binary(result, decimals: 2)
    }

    ~H"""
    <div>
      <strong><%= @result %> Kč</strong>

      <p>
        \[
        \begin{align*}
        \text{ČÚM} &= <%= @interest_rate %> \cdot (1 - <%= @tax %>) = <%= @cum %> \\
        A_Z &= <%= @yield %> \cdot \frac{<%= @cum %>}{(1 + <%= @cum %>)^<%= @years %> - 1} = <%= @az %> \\
        A_P &= \frac{<%= @az %>}{(1 + <%= @cum %>)} = <%= @result %> \end{align*}
        \]
      </p>
    </div>
    """
  end
end
