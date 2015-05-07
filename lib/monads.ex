defprotocol Monads do
  def unit(a)
  def bind(fun)
end
