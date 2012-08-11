// Generated by CoffeeScript 1.3.1
(function() {
  var Game,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Game = (function(_super) {

    __extends(Game, _super);

    Game.name = 'Game';

    function Game() {
      return Game.__super__.constructor.apply(this, arguments);
    }

    Game.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    Game.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      this.name = options.name;
      this.age = options.age;
      this.children = options.children;
      console.log(this.attributes);
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    Game.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Game;

  })(Backbone.Model);

  $CS.Models.Game = Game;

}).call(this);
