// Generated by CoffeeScript 1.3.3
(function() {
  var QueryStringBuilder;

  QueryStringBuilder = (function() {

    function QueryStringBuilder() {}

    QueryStringBuilder.prototype.stringify = function(obj, prefix, accum) {
      if (accum == null) {
        accum = {};
      }
      if (_.isArray(obj)) {
        this.stringifyArray(obj, prefix, accum);
      } else if (_.isString(obj) || _.isNumber(obj) || _.isDate(obj) || ("" + obj) === "[object TiBlob]") {
        this.stringifyString(obj, prefix, accum);
      } else if (_.isBoolean(obj)) {
        this.stringifyBoolean(obj, prefix, accum);
      } else if (obj != null) {
        if (obj.attributes != null) {
          this.stringifyObject(obj.attributes, prefix, accum);
        } else {
          this.stringifyObject(obj, prefix, accum);
        }
      } else {
        return prefix;
      }
      return accum;
    };

    QueryStringBuilder.prototype.stringifyBoolean = function(bool, prefix, accum) {
      if (!prefix) {
        throw new TypeError("Stringify expects an object");
      }
      return accum[prefix] = bool ? 1 : 0;
    };

    QueryStringBuilder.prototype.stringifyString = function(str, prefix, accum) {
      if (!prefix) {
        throw new TypeError("Stringify expects an object");
      }
      return accum[prefix] = str;
    };

    QueryStringBuilder.prototype.stringifyArray = function(arr, prefix, accum) {
      var i, item, _i, _len, _results;
      if (!prefix) {
        throw new TypeError("Stringify expects an object");
      }
      i = 0;
      _results = [];
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        item = arr[_i];
        _results.push(this.stringify(item, "" + prefix + "[" + (i++) + "]", accum));
      }
      return _results;
    };

    QueryStringBuilder.prototype.stringifyObject = function(obj, prefix, accum) {
      var key, new_key, new_prefix, value, _results;
      _results = [];
      for (key in obj) {
        value = obj[key];
        if (key.match(/_preview$/)) {
          continue;
        }
        new_key = key;
        if (_.isArray(value)) {
          new_key = "" + key + "_attributes";
        }
        new_prefix = '';
        if (prefix) {
          new_prefix = "" + prefix + "[" + (encodeURIComponent(new_key)) + "]";
        } else {
          new_prefix = encodeURIComponent(new_key);
        }
        _results.push(this.stringify(value, new_prefix, accum));
      }
      return _results;
    };

    return QueryStringBuilder;

  })();

  $CS.Utils.QueryStringBuilder = QueryStringBuilder;

}).call(this);