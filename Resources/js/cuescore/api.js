// Generated by CoffeeScript 1.3.1
(function() {
  var API,
    __hasProp = {}.hasOwnProperty;

  API = (function() {

    API.name = 'API';

    function API(login, password) {
      this.login = login;
      this.password = password;
      $CS.API_ENDPOINT = "http://localhost:3009";
    }

    API.prototype.requestURI = function(path, query) {
      var key, uri, value;
      if (query == null) {
        query = {};
      }
      uri = "" + $CS.API_ENDPOINT + path + ".json?";
      for (key in query) {
        if (!__hasProp.call(query, key)) continue;
        value = query[key];
        uri += "" + key + "=" + (escape(value)) + "&";
      }
      return uri;
    };

    API.prototype.request = function(path, options, authenticated) {
      var data, message, uri, xhr;
      if (authenticated == null) {
        authenticated = true;
      }
      if (options.method == null) {
        options.method = 'GET';
      }
      if (options.query == null) {
        options.query = {};
      }
      if (options.success == null) {
        options.success = function() {
          return Ti.API.info;
        };
      }
      if (options.error == null) {
        options.error = function() {
          return Ti.API.error;
        };
      }
      xhr = Ti.Network.createHTTPClient();
      xhr.onreadystatechange = function(e) {
        var data;
        if (this.readyState === 4) {
          try {
            data = JSON.parse(this.responseText);
            if (data.error != null) {
              return options.error(data);
            } else {
              return options.success(data);
            }
          } catch (exception) {
            return options.error(exception);
          }
        }
      };
      uri = this.requestURI(path, options.query);
      xhr.open(options.method, uri);
      if (authenticated) {
        xhr.setRequestHeader('Authorization', 'Basic ' + Ti.Utils.base64encode(this.login + ':' + this.password));
      }
      message = "Executing ";
      message += authenticated ? "Authenticated " : "Unauthenticated ";
      message += "" + options.method + " " + uri;
      if (options.debug) {
        Ti.API.debug(message);
      }
      if (options.body != null) {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
        data = JSON.stringify(options.body);
        if (options.debug) {
          Ti.API.debug(data);
        }
        return xhr.send(data);
      } else {
        return xhr.send();
      }
    };

    API.prototype.get = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'GET';
      return this.request(path, options, authenticated);
    };

    API.prototype.post = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'POST';
      return this.request(path, options, authenticated);
    };

    API.prototype.put = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'PUT';
      return this.request(path, options, authenticated);
    };

    API.prototype["delete"] = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'DELETE';
      return this.request(path, options, authenticated);
    };

    API.prototype.authenticate = function(options) {
      Ti.API.debug("$CS.API.authenticate");
      return this.get('/me', options);
    };

    API.prototype.logout = function(options) {
      Ti.API.debug("$CS.API.logout");
      return this["delete"]('/logout', options);
    };

    API.prototype.forgotPassword = function(email, options) {
      Ti.API.debug("$CS.API.forgotPassword");
      options.query = {};
      options.query.email = email;
      return this.post('/passwords', options, false);
    };

    API.prototype.me = function(options) {
      Ti.API.debug("$CS.API.me");
      return this.authenticate(options);
    };

    return API;

  })();

  $CS.API = new API;

}).call(this);