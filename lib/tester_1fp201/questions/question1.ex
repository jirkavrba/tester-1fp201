defmodule Tester1fp201.Questions.Question1 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      interest_rate: Enum.random([2, 3, 4, 5, 7, 9, 12])
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      Jak velká bude roční efektivní úroková míra pro termínovaný bankovní účet spojený s
      <strong><%= @interest_rate %> % roční nominální úrokovou mírou</strong>
      a
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
  @spec render_solution(%{:interest_rate => number, optional(any) => any}) ::
          Phoenix.LiveView.Rendered.t()
  def render_solution(%{interest_rate: i}) do
    i = i / 100

    assigns = %{
      a: i,
      b: :erlang.float_to_binary(:math.pow(1 + i / 4, 4) - 1, decimals: 5),
      c: :erlang.float_to_binary(:math.pow(1 + i / 12, 12) - 1, decimals: 5),
      d: :erlang.float_to_binary(:math.exp(i) - 1, decimals: 5),
      interest_rate: i
    }

    ~H"""
    <div>
      <ul>
        <li>a) <%= @a %></li>
        <li>b) <%= @b %></li>
        <li>b) <%= @c %></li>
        <li>b) <%= @d %></li>
      </ul>

      <p>
        \[
        \begin{align*} <%= @interest_rate %> &= <%= @interest_rate %> \\
        (1 + \frac{<%= @interest_rate %>}{4})^{4} - 1 &= <%= @b %> \\
        (1 + \frac{<%= @interest_rate %>}{12})^{12} - 1 &= <%= @c %> \\
        e^{<%= @interest_rate %>} - 1 &= <%= @d %> \\
        \end{align*}
        \]
      </p>
    </div>
    """
  end
end
