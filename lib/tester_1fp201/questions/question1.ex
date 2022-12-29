defmodule Tester1fp201.Questions.Question1 do
  import Phoenix.Component, only: [sigil_H: 2]

  @behaviour Tester1fp201.Question

  @impl true
  def assigns do
    %{
      interest_rate: Enum.random([2, 3, 4, 5, 7, 9, 12]) / 100
    }
  end

  @impl true
  def render_question(assigns) do
    ~H"""
    <div>
      Jak velká bude roční efektivní úroková míra pro termínovaný bankovní účet spojený s <strong><%= @interest_rate * 100 %>% roční nominální úrokovou mírou</strong> a
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
  def render_solution(%{interest_rate: i}) do
    assigns = %{
      a: i,
      b: :math.pow(1 + (i / 4), 4) - 1,
      c: :math.pow(1 + (i / 12), 12) - 1,
      d: :math.exp(i) - 1
    }

    ~H"""
    <div>
      <ul>
        <li>a) <%= @a * 100 %> %</li>
        <li>b) <%= :erlang.float_to_binary(@b * 100, decimals: 3) %> %</li>
        <li>b) <%= :erlang.float_to_binary(@c * 100, decimals: 3) %> %</li>
        <li>b) <%= :erlang.float_to_binary(@d * 100, decimals: 3) %> %</li>
      </ul>
    </div>
    """
  end
end
