class QueryStringBuilder
  stringify: (obj, prefix, accum = {}) ->
    if _.isArray(obj)
      this.stringifyArray obj, prefix, accum
    else if _.isString(obj) || _.isNumber(obj) || _.isDate(obj) || "#{obj}" == "[object TiBlob]"
      this.stringifyString obj, prefix, accum
    else if _.isBoolean(obj)
      this.stringifyBoolean obj, prefix, accum
    else if obj?
      if obj.attributes?
        this.stringifyObject obj.attributes, prefix, accum
      else
        this.stringifyObject obj, prefix, accum
    else
      return prefix

    accum

  stringifyBoolean: (bool, prefix, accum) ->
    unless prefix
      throw new TypeError("Stringify expects an object")

    accum[prefix] = if bool then 1 else 0

  stringifyString: (str, prefix, accum) ->
    unless prefix
      throw new TypeError("Stringify expects an object")

    accum[prefix] = str

  stringifyArray: (arr, prefix, accum) ->
    unless prefix
      throw new TypeError("Stringify expects an object")

    i = 0
    for item in arr
      this.stringify(item, "#{prefix}[#{i++}]", accum)

  stringifyObject: (obj, prefix, accum) ->
    for key, value of obj
      continue if key.match(/_preview$/)

      new_key = key
      if _.isArray(value)
        new_key = "#{key}_attributes"

      new_prefix = ''
      if prefix
        new_prefix = "#{prefix}[#{encodeURIComponent(new_key)}]"
      else
        new_prefix = encodeURIComponent new_key

      this.stringify value, new_prefix, accum
      
$CS.Utilities.QueryStringBuilder = QueryStringBuilder