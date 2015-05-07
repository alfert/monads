defmodule MonadsTest do
  use ExUnit.Case
  import Tracing

  test "h(x) == ht(x)" do
    x = 20.0
    ht = ht(x)
    h = h(x)
    assert {^h, _} = ht
  end

  test "commutation digram" do
    x = 20.0
    assert x |> comp((lift &f/1), lift(&g/1)).() == x |>
      (lift fn(y) -> f(g(y)) end).()
  end

  test "unit is neutral under bind left" do
    x = 20.0
    mx = ft(x)
    assert mx |> bind(&unit/1) == mx
  end

  test "unit is neutral under bind right" do
    x = 20.0
    mx = ft(x)
    assert unit(x) |> bind(&ft/1) == mx
  end


end
