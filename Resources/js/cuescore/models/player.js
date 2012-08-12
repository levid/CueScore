// Generated by CoffeeScript 1.3.1
(function() {
  var Player,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Player = (function(_super) {

    __extends(Player, _super);

    Player.name = 'Player';

    function Player() {
      return Player.__super__.constructor.apply(this, arguments);
    }

    Player.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    Player.prototype.initialize = function() {
      _.extend(this, this.defaults);
      return this.bind("change:name", function() {
        var name;
        return name = this.get("name");
      });
    };

    Player.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Player;

  })(Backbone.Model);

  $CS.Models.Player = Player;

}).call(this);
