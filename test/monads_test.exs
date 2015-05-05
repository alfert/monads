defmodule MonadsTest do
  use ExUnit.Case
  import Tracing

  test "h(x) == ht(x)" do
    x = 20.0
    ht = ht(x)
    h = h(x)
    assert {h, _} = ht
  end

  test "commutation digram" do
    x = 20.0
    assert x |> comp((lift &f/1), lift(&g/1)).() == x |> (lift &(f(g(&1)))).()
  end
end
