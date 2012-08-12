// Generated by CoffeeScript 1.3.1
(function() {
  var Game,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Game = (function(_super) {

    __extends(Game, _super);

    Game.name = 'Game';

    Game.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    function Game(options) {
      if (options == null) {
        options = {};
      }
      _.extend(this, this.defaults);
      this.name = options.name;
      this.age = options.age;
      this.children = options.children;
      this.bind("change:name", function() {
        var name;
        return name = this.get("name");
      });
    }

    Game.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Game;

  })(Backbone.Model);

  $CS.Models.Game = Game;

}).call(this);
