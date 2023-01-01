defmodule Tester1fp201.Questions.Question2 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      interest_rate: Enum.random([2, 3, 4, 5, 7, 9, 12]),
      duration_years: Enum.random(4..10),
      initial_deposit: Enum.random(5..20) * 1000
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      Vypočtěte jak velkou částku si budete moci vyzvednout z účtu s
      <strong>nominální úrokovou sazbou <%= @interest_rate %>%</strong>
      po <strong><%= @duration_years %> letech</strong>, pokud dnes na tento účet vložíte <strong><%= @initial_deposit %> Kč</strong>.
      <ul>
        <li>a) s <strong>ročním</strong> skládáním úroků</li>
        <li>b) s <strong>čtvrtletním</strong> skládáním úroků</li>
        <li>c) s <strong>měsíčním</strong> skládáním úroků</li>
        <li>d) se <strong>spojitým</strong> skládáním úroků</li>
      </ul>
    </div>
    """
  end

  @impl true
  def render_solution(%{interest_rate: i, duration_years: n, initial_deposit: d}) do
    i = i / 100

    assigns = %{
      a: :erlang.float_to_binary(:math.pow(1 + i, n) * d, decimals: 2),
      b: :erlang.float_to_binary(:math.pow(1 + i / 4, n * 4) * d, decimals: 2),
      c: :erlang.float_to_binary(:math.pow(1 + i / 12, n * 12) * d, decimals: 2),
      d: :erlang.float_to_binary(:math.pow(:math.exp(i), n) * d, decimals: 2),
      initial_deposit: d,
      interest_rate: i,
      duration_years: n
    }

    ~H"""
    <div>
      <ul>
        <li>a) <%= @a %> Kč</li>
        <li>b) <%= @b %> Kč</li>
        <li>c) <%= @c %> Kč</li>
        <li>d) <%= @d %> Kč</li>
      </ul>

      <p>
        \[
        \begin{align*}
        (1 + <%= @interest_rate %>)^{<%= @duration_years %>} \cdot <%= @initial_deposit %> &= <%= @a %> \\
        (1 + \frac{<%= @interest_rate %>}{4})^{<%= @duration_years %> \cdot 4} \cdot <%= @initial_deposit %> &= <%= @b %> \\
        (1 + \frac{<%= @interest_rate %>}{12})^{<%= @duration_years %> \cdot 12} \cdot <%= @initial_deposit %> &= <%= @c %> \\
        (e^{<%= @interest_rate %>})^{<%= @duration_years %>} \cdot <%= @initial_deposit %> &= <%= @d %> \end{align*}
        \]
      </p>
    </div>
    """
  end
end
