defmodule Tracing do

  @type trace_t(a) :: {a, String.t}
  @type debug_fun(a) :: (a -> trace_t(a))
  @type trace_fun(a) :: (debug_fun(a) -> debug_fun(a))

  def f(x), do: x*2.0
  def g(x), do: x+3.0
  def h(x), do: x |> g |> f # == f(g(x))

  def ft(x), do: {f(x), "call f with #{x}."}
  def gt(x), do: {g(x), "call g with #{x}."}
  def ht(x), do: comp(&ft/1, &gt/1).(x)

  @spec bind(trace_t(a), debug_fun(a)) :: trace_t(a) when a: var
  def bind({y, s1}, tfun) do
    {z, s2} = tfun.(y)
    {z, s1 <> s2}
  end

  @spec comp(debug_fun(a), debug_fun(a)) :: debug_fun(a) when a: var
  def comp(ft, gt) do
    fn(x) -> x |> gt.() |> bind(ft) end
  end

  @spec unit(a) :: trace_t(a) when a: var
  def unit(x), do: {x, ""}

  @spec lift((a -> a)) :: debug_fun(a) when a: var
  def lift(f), do: fn(x) -> f.(x) |> unit end

end
