defmodule Tester1fp201.Questions.Question7 do
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
        Jak velkou částku musíte na konci každého roku vložit do fondu, abyste měli koncem <strong><%= @years %>. roku</strong> k dispozici <strong><%= @yield %> Kč</strong>?
      </p>
      <p>
        Prostředky fondu ukládáte na účet s <strong><%= @interest_rate %>% roční nominální úrokovou sazbou</strong> a <strong>ročním</strong> skládáním.<br>
        Úrok dále musíte zdanit <strong><%= @tax %>%</strong> sazbou z daně příjmů.
      </p>
    </div>
    """
  end

  @impl true
  def render_solution(%{years: n, yield: y, interest_rate: i, tax: t}) do
    i = i / 100
    cum = i * (1 - t / 100)
    result = y * (cum / (:math.pow(1 + cum, n) - 1))

    assigns = %{
      yield: y,
      years: n,
      interest_rate: :erlang.float_to_binary(i, decimals: 4),
      cum: :erlang.float_to_binary(cum, decimals: 4),
      tax: :erlang.float_to_binary(t / 100, decimals: 2),
      result: :erlang.float_to_binary(result, decimals: 2),
    }

    ~H"""
    <div>
      <strong><%= @result %> Kč</strong>

      <p>
        \[
          \begin{align*}
            \text{ČÚM} &= <%= @interest_rate %> \cdot (1 - <%= @tax %>) = <%= @cum %> \\
            <%= @yield %> \cdot \frac{<%= @cum %>}{(1 + <%= @cum %>)^<%= @years %> - 1} &= <%= @result %>
          \end{align*}
        \]
      </p>
    </div>
    """
  end
end
