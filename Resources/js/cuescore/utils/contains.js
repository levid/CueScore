// Generated by CoffeeScript 1.3.3
(function() {

  Array.prototype.contains = function(obj) {
    var i;
    i = this.length;
    if ((function() {
      var _results;
      _results = [];
      while (i--) {
        _results.push(this[i] === obj);
      }
      return _results;
    }).call(this)) {
      return true;
    }
    return false;
  };

}).call(this);
