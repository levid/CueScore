Array::contains = (obj) ->
  i = @length
  return true  if this[i] is obj  while i--
  false