class API

  constructor: (login, password) ->
    @login    = login
    @password = password
   
    $CS.API_ENDPOINT = "http://localhost:3009"

  requestURI: (path, query={}) ->
    # NOTE: Setup your own API endpoint, as below

    uri = "#{$CS.API_ENDPOINT}#{path}.json?"
    for own key, value of query
      uri += "#{ key }=#{ escape(value) }&"

    uri

  request: (path, options, authenticated=true) ->
    options.method  ?= 'GET'
    options.query   ?= {}
    options.success ?= -> Ti.API.info
    options.error   ?= -> Ti.API.error

    xhr = Ti.Network.createHTTPClient()
    xhr.onreadystatechange = (e) ->
      if this.readyState == 4
        try
          data = JSON.parse(this.responseText)
          if data.error?
            options.error(data)
          else
            options.success(data)
        catch exception
          options.error(exception)
          
    uri = @requestURI(path, options.query)
    xhr.open(options.method, uri)
    xhr.setRequestHeader 'Authorization', 'Basic ' + Ti.Utils.base64encode(@login+':'+@password) if authenticated

    message = "Executing "
    message += if authenticated then "Authenticated " else "Unauthenticated "
    message += "#{options.method} #{uri}"
    Ti.API.debug(message) if options.debug

    if options.body?
      xhr.setRequestHeader('Accept', 'application/json')
      xhr.setRequestHeader('Content-Type', 'application/json')
      data = JSON.stringify(options.body)
      Ti.API.debug(data) if options.debug
      xhr.send(data)
    else
      xhr.send()

  # High level method for GET requests
  get: (path, options, authenticated=true) ->
    options.method = 'GET'
    @request path, options, authenticated

  # High level method for POST requests
  post: (path, options, authenticated=true) ->
    options.method = 'POST'
    @request path, options, authenticated

  put: (path, options, authenticated=true) ->
    options.method = 'PUT'
    @request path, options, authenticated

  delete: (path, options, authenticated=true) ->
    options.method = 'DELETE'
    @request path, options, authenticated

  # Add your API endpoints below

  # Authenticate the user
  authenticate: (options) ->
    Ti.API.debug "$CS.API.authenticate" 
    @get '/me', options

  # Logout the user
  logout: (options) ->
    Ti.API.debug "$CS.API.logout" 
    @delete '/logout', options

  # Forgot password
  forgotPassword: (email, options) -> 
    Ti.API.debug "$CS.API.forgotPassword" 
    options.query = {}
    options.query.email = email
    @post '/passwords', options, false

  # Convenience method to get current user info
  me: (options) ->
    Ti.API.debug "$CS.API.me" 
    @authenticate options
    
$CS.API = new API