Base64 =
  encode: (data) ->
    return btoa(data)  if typeof (btoa) is "function"
    b64_map = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
    byte1 = undefined
    byte2 = undefined
    byte3 = undefined
    ch1 = undefined
    ch2 = undefined
    ch3 = undefined
    ch4 = undefined
    result = new Array()
    j = 0
    i = 0

    while i < data.length
      byte1 = data.charCodeAt(i)
      byte2 = data.charCodeAt(i + 1)
      byte3 = data.charCodeAt(i + 2)
      ch1 = byte1 >> 2
      ch2 = ((byte1 & 3) << 4) | (byte2 >> 4)
      ch3 = ((byte2 & 15) << 2) | (byte3 >> 6)
      ch4 = byte3 & 63
      if isNaN(byte2)
        ch3 = ch4 = 64
      else ch4 = 64  if isNaN(byte3)
      result[j++] = b64_map.charAt(ch1) + b64_map.charAt(ch2) + b64_map.charAt(ch3) + b64_map.charAt(ch4)
      i += 3
    result.join ""

  decode: (data) ->
    data = data.replace(/[^a-z0-9\+\/=]/g, "")
    return atob(data)  if typeof (atob) is "function"
    b64_map = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
    byte1 = undefined
    byte2 = undefined
    byte3 = undefined
    ch1 = undefined
    ch2 = undefined
    ch3 = undefined
    ch4 = undefined
    result = new Array()
    j = 0
    data += "="  until (data.length % 4) is 0
    i = 0

    while i < data.length
      ch1 = b64_map.indexOf(data.charAt(i))
      ch2 = b64_map.indexOf(data.charAt(i + 1))
      ch3 = b64_map.indexOf(data.charAt(i + 2))
      ch4 = b64_map.indexOf(data.charAt(i + 3))
      byte1 = (ch1 << 2) | (ch2 >> 4)
      byte2 = ((ch2 & 15) << 4) | (ch3 >> 2)
      byte3 = ((ch3 & 3) << 6) | ch4
      result[j++] = String.fromCharCode(byte1)
      result[j++] = String.fromCharCode(byte2)  unless ch3 is 64
      result[j++] = String.fromCharCode(byte3)  unless ch4 is 64
      i += 4
    result.join ""