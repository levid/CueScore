// Generated by CoffeeScript 1.3.1
(function() {
  var NineBall,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  NineBall = (function(_super) {

    __extends(NineBall, _super);

    NineBall.name = 'NineBall';

    function NineBall() {
      return NineBall.__super__.constructor.apply(this, arguments);
    }

    NineBall.prototype.defaults = {};

    NineBall.prototype.initialize = function(name, rank, number, teamNumber) {
      return console.log(this);
    };

    return NineBall;

  })($CS.Models.Player);

  $CS.Models.Player.NineBall = NineBall;

}).call(this);
