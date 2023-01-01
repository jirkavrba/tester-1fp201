defmodule Tester1fp201.Questions.Question4 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      interest_rate: Enum.random(5..10),
      initial_deposit: Enum.random(4..10) * 1000,
      tax: Enum.random([15, 18, 20, 25])
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      <p>
        Jestliže jste uložili dnes v bance <strong><%= @initial_deposit %></strong>
        Kč při <strong><%= @interest_rate %>%
        roční nominální úrokové míře</strong>, jaký obnos si budete moci při uvažované sazbě daně z úroků ve výši
        <strong><%= @tax %>%</strong>
        a standardu 30E/360 vyzvednout
      </p>

      <ul>
        <li>a) po 5 měsících při ročním skládání úroků?</li>
        <li>b) po 7 letech při ročním skládání úroků?</li>
        <li>c) po 7 letech a 5 měsících při ročním skládání úroků?</li>
        <li>d) po 7 letech a 5 měsících při čtvrtletním skládání úroků?</li>
        <li>e) po 7 letech a 5 měsících při měsíčním skládání úroků?</li>
      </ul>
    </div>
    """
  end

  @impl true
  def render_solution(%{interest_rate: i, initial_deposit: d, tax: t}) do
    i = i / 100
    cum = i * (1 - t / 100)

    assigns = %{
      a: :erlang.float_to_binary((1 + cum * 5 / 12) * d, decimals: 2),
      b: :erlang.float_to_binary(:math.pow(1 + cum, 7) * d, decimals: 2),
      c: :erlang.float_to_binary(:math.pow(1 + cum, 7) * (1 + cum * 5 / 12) * d, decimals: 2),
      d:
        :erlang.float_to_binary(:math.pow(1 + cum / 4, 7 * 4 + 1) * (1 + cum / 4 * 2 / 3) * d,
          decimals: 2
        ),
      e: :erlang.float_to_binary(:math.pow(1 + cum / 12, 7 * 12 + 5) * d, decimals: 2),
      i: i,
      cum: :erlang.float_to_binary(cum, decimals: 5),
      deposit: d,
      tax: t
    }

    ~H"""
    <div>
      <ul>
        <li>a) <%= @a %> Kč</li>
        <li>b) <%= @b %> Kč</li>
        <li>c) <%= @c %> Kč</li>
        <li>d) <%= @d %> Kč</li>
        <li>e) <%= @e %> Kč</li>
      </ul>

      <div>
        \[
        \begin{align*}
        \text{ČÚM} &= <%= @i %> \cdot (1 - <%= @tax / 100 %>) = <%= @cum %> \\
        \\
        a) FV &= <%= @deposit %> \cdot (1 + \frac{<%= @cum %> \cdot 5}{12}) &= <%= @a %> \\
        b) FV &= <%= @deposit %> \cdot (1 + <%= @cum %>)^7 &= <%= @b %> \\
        c) FV &= <%= @deposit %> \cdot (1 + <%= @cum %>)^7 \cdot (1 + \frac{<%= @cum %> \cdot 5}{12}) &= <%= @c %> \\
        d) FV &= <%= @deposit %> \cdot (1 + \frac{<%= @cum %>}{4})^{7 \cdot 4 + 1} \cdot (1 + \frac{<%= @cum %> \cdot 2}{12}) &= <%= @d %> \\
        e) FV &= <%= @deposit %> \cdot (1 + \frac{<%= @cum %>}{12})^{7 \cdot 12 + 5} &= <%= @e %> \\
        \end{align*}
        \]
      </div>
    </div>
    """
  end
end
