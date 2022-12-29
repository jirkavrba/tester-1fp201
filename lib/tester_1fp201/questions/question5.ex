defmodule Tester1fp201.Questions.Question5 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    deposit = 20 + Enum.random(0..5)
    yield = deposit * 2 + Enum.random(-5..5)

    %{
      interest_rate: Enum.random(10..15),
      deposit: deposit * 1_000_000,
      yield: yield * 1_000_000,
      tax: Enum.random([15, 18, 20, 25]),
      years: Enum.random(5..10)
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      <p>
        Rozhodněte se mezi tím, zda
        <ul>
          <li>
            a) vložit dnes <strong><%= @deposit %> Kč</strong>
            do investice <em>Malina</em>
            s předpokládaným <strong>jednorázovým čistým příjmem ve výši <%= @yield %> Kč</strong>
            za <strong><%= @years %> let</strong>
            (od zdanění se zde abstrahujte),
          </li>
          <li>
            b) upřednostnit alternativní investici <em>Ostružina</em>
            s výnosovou (tj. zvažovanou) úrokovou mírou ve výši <strong><%= @interest_rate %>%</strong>
            (zde zvažujte zdanění úroků ve výši <strong><%= @tax %>%</strong>).
          </li>
        </ul>
      </p>
    </div>
    """
  end

  @impl true
  def render_solution(%{interest_rate: i, deposit: d, yield: y, tax: t, years: n}) do
    i = i / 100
    cum = i * (1 - t / 100)
    result = d * :math.pow(1 + cum, n)

    assigns = %{
      yield: y,
      result: result,
      cum: :erlang.float_to_binary(cum, decimals: 4)
    }

    ~H"""
    <div>
      Výhodnější je vložit peníze do investice
      <em><%= if @result > @yield, do: "Ostružina", else: "Malina" %></em>
      <br />
      <br />

      <ul>
        <li>Výnos investice <em>Malina</em> je <%= trunc(@yield) %> Kč</li>
        <li>Výnos investice <em>Ostružina</em> je <%= trunc(@result) %> Kč</li>
      </ul>
    </div>
    """
  end
end
