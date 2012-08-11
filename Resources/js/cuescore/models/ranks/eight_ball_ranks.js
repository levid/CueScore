// Generated by CoffeeScript 1.3.1
(function() {
  var EightBall,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  EightBall = (function(_super) {

    __extends(EightBall, _super);

    EightBall.name = 'EightBall';

    function EightBall() {
      return EightBall.__super__.constructor.apply(this, arguments);
    }

    EightBall.prototype.defaults = {
      games_to_win: []
    };

    EightBall.prototype.initialize = function() {
      this.games_to_win[2] = [];
      this.games_to_win[2][2] = 2;
      this.games_to_win[2][3] = 2;
      this.games_to_win[2][4] = 2;
      this.games_to_win[2][5] = 2;
      this.games_to_win[2][6] = 2;
      this.games_to_win[2][7] = 2;
      this.games_to_win[3] = [];
      this.games_to_win[3][2] = 3;
      this.games_to_win[3][3] = 2;
      this.games_to_win[3][4] = 2;
      this.games_to_win[3][5] = 2;
      this.games_to_win[3][6] = 2;
      this.games_to_win[3][7] = 2;
      this.games_to_win[4] = [];
      this.games_to_win[4][2] = 4;
      this.games_to_win[4][3] = 3;
      this.games_to_win[4][4] = 3;
      this.games_to_win[4][5] = 3;
      this.games_to_win[4][6] = 3;
      this.games_to_win[4][7] = 2;
      this.games_to_win[5] = [];
      this.games_to_win[5][2] = 5;
      this.games_to_win[5][3] = 4;
      this.games_to_win[5][4] = 4;
      this.games_to_win[5][5] = 4;
      this.games_to_win[5][6] = 4;
      this.games_to_win[5][7] = 3;
      this.games_to_win[6] = [];
      this.games_to_win[6][2] = 6;
      this.games_to_win[6][3] = 5;
      this.games_to_win[6][4] = 5;
      this.games_to_win[6][5] = 5;
      this.games_to_win[6][6] = 5;
      this.games_to_win[6][7] = 4;
      this.games_to_win[7] = [];
      this.games_to_win[7][2] = 7;
      this.games_to_win[7][3] = 6;
      this.games_to_win[7][4] = 5;
      this.games_to_win[7][5] = 5;
      this.games_to_win[7][6] = 5;
      return this.games_to_win[7][7] = 5;
    };

    EightBall.prototype.getGamesNeedToWin = function(myRank, opponentRank) {
      var gamesNeeded;
      if (myRank > 1 && myRank < 8 && opponentRank > 1 && opponentRank < 8) {
        gamesNeeded = this.games_to_win[myRank][opponentRank];
        return gamesNeeded;
      }
      return 0;
    };

    EightBall.prototype.getTimeouts = function(rank) {
      if (rank < 4) {
        return 2;
      } else {
        if (rank >= 4 && rank <= 9) {
          return 1;
        }
      }
      return 0;
    };

    return EightBall;

  })($CS.Models.Rank);

  $CS.Models.Rank.EightBall = EightBall;

}).call(this);
