# methods
console = 
  log: (str) ->
    Ti.API.info str
  warn: (str) ->
    Ti.API.warn str
  error: (str) ->
    Ti.API.error str
  
say = (msg) ->
  alert(msg)
  
after = (ms, cb) -> setTimeout cb, ms
every = (ms, cb) -> setInterval cb, ms