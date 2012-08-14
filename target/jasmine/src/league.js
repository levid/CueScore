// Generated by CoffeeScript 1.3.3
(function() {
  var League,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  League = (function(_super) {

    __extends(League, _super);

    League.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    function League(options) {
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

    League.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return League;

  })(Backbone.Model);

  $CS.Models.League = League;

}).call(this);
