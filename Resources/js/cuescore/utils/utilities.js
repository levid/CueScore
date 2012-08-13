// Generated by CoffeeScript 1.3.1
(function() {
  var Utilities;

  Utilities = (function() {
    var getScoreRatio;

    Utilities.name = 'Utilities';

    Utilities.prototype.defaults = {};

    function Utilities(options) {
      var i;
      if (options == null) {
        options = {};
      }
      _.extend(this, this.defaults);
      Array.prototype.exists = function(search) {};
      i = 0;
      while (i < this.length) {
        if (this[i] === search) {
          return true;
        }
        i++;
      }
      false;

    }

    getScoreRatio = function(playerScore, playerBallCount) {
      return playerScore / playerBallCount;
    };

    Utilities.prototype.getPlatformWidth = function() {
      return Ti.Platform.displayCaps.platformWidth;
    };

    Utilities.prototype.getPlatformHeight = function() {
      return Ti.Platform.displayCaps.platformHeight - 22;
    };

    return Utilities;

  })();

  $CS.Utilities = new Utilities;

}).call(this);