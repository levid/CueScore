// Generated by CoffeeScript 1.3.1
(function() {
  var Match,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Match = (function(_super) {

    __extends(Match, _super);

    Match.name = 'Match';

    Match.prototype.defaults = {};

    function Match() {
      _.extend(this, this.defaults);
    }

    return Match;

  })(Backbone.Model);

  $CS.Models.Match = Match;

}).call(this);