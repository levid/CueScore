// Generated by CoffeeScript 1.3.3
(function() {
  var Doubles,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Doubles = (function(_super) {

    __extends(Doubles, _super);

    function Doubles() {
      return Doubles.__super__.constructor.apply(this, arguments);
    }

    Doubles.prototype.defaults = {};

    Doubles.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      return _.extend(this, this.defaults);
    };

    return Doubles;

  })($CS.Models.League);

  $CS.Models.League.Doubles = Doubles;

}).call(this);
