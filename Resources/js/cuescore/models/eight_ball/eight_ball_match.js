// Generated by CoffeeScript 1.3.3
(function() {
  var Match,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Match = (function(_super) {

    __extends(Match, _super);

    Match.prototype.defaults = {
      player: {
        one: {},
        two: {}
      },
      completedGames: [],
      ended: false,
      originalId: 0,
      leagueMatchId: 0,
      playerNumberWinning: 0,
      playerOneWon: false,
      playerTwoWon: false,
      arePlayersSwitching: false,
      suddenDeath: false,
      forfeit: false,
      currentGame: null
    };

    function Match(options) {
      var playerOneName, playerOneNumber, playerOneRank, playerOneTeamNumber, playerTwoName, playerTwoNumber, playerTwoRank, playerTwoTeamNumber;
      _.extend(this, this.defaults);
      playerOneName = options.playerOneName;
      playerTwoName = options.playerTwoName;
      playerOneRank = options.playerOneRank;
      playerTwoRank = options.playerTwoRank;
      playerOneNumber = options.playerOneNumber;
      playerTwoNumber = options.playerTwoNumber;
      playerOneTeamNumber = options.playerOneTeamNumber;
      playerTwoTeamNumber = options.playerTwoTeamNumber;
      this.player.one = new $CS.Models.EightBall.Player(options = {
        name: playerOneName,
        rank: playerOneRank,
        playerNumber: playerOneNumber,
        teamNumber: playerOneTeamNumber
      });
      this.player.two = new $CS.Models.EightBall.Player(options = {
        name: playerTwoName,
        rank: playerTwoRank,
        playerNumber: playerTwoNumber,
        teamNumber: playerTwoTeamNumber
      });
      if ((this.player.one.rank != null) && (this.player.two.rank != null)) {
        this.player.one.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(playerOneRank, playerTwoRank);
        this.player.two.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(playerTwoRank, playerOneRank);
      }
      this.currentGame = this.getNewGame();
    }

    Match.prototype.getNewGame = function() {
      var newGame, options,
        _this = this;
      newGame = new $CS.Models.EightBall.Game(options = {
        addToPlayerOne: function() {
          return _this.player.one;
        },
        addToPlayerTwo: function() {
          return _this.player.two;
        },
        callback: function() {
          if (_this.getRemainingGamesNeededToWinByPlayer(1) === 0) {
            _this.playerOneWon = true;
            return _this.ended = true;
          } else if (_this.getRemainingGamesNeededToWinByPlayer(2) === 0) {
            _this.playerTwoWon = true;
            return _this.ended = true;
          }
        }
      });
      return newGame;
    };

    Match.prototype.getTotalInnings = function() {
      var i, totalInnings;
      totalInnings = this.currentGame.numberOfInnings;
      if (this.completedGames.length > 0) {
        i = 0;
        while (i <= (this.completedGames.length - 1)) {
          totalInnings += this.completedGames[i].numberOfInnings;
          i++;
        }
      }
      return totalInnings;
    };

    Match.prototype.getTotalSafeties = function() {
      return this.player.one.getSafeties() + " to " + this.player.two.getSafeties();
    };

    Match.prototype.getCurrentGameNumber = function() {
      return this.completedGames.length + 1;
    };

    Match.prototype.getMatchPointsByTeamNumber = function(teamNumber) {
      if (this.player.one.teamNumber === teamNumber) {
        return this.getMatchPointsByPlayer(1);
      } else {
        if (this.player.two.teamNumber === teamNumber) {
          return this.getMatchPointsByPlayer(2);
        }
      }
      return 0;
    };

    Match.prototype.getWinningPlayer = function() {
      if ((this.getGamesWonByPlayer(1) / this.player.one.gamesNeededToWin) > (this.getGamesWonByPlayer(2) / this.player.two.gamesNeededToWin)) {
        return this.player.one;
      } else {
        return this.player.two;
      }
    };

    Match.prototype.getRemainingGamesNeededToWinByPlayer = function(playerNum) {
      if (playerNum === 1) {
        return this.player.one.gamesNeededToWin - this.getGamesWonByPlayer(1);
      } else if (playerNum === 2) {
        return this.player.two.gamesNeededToWin - this.getGamesWonByPlayer(2);
      }
    };

    Match.prototype.getGamesWonByPlayer = function(playerNum) {
      var gamesWon, i;
      i = 0;
      if (playerNum === 1) {
        gamesWon = (this.currentGame.playerOneWon === true ? 1 : 0);
        while (i <= (this.completedGames.length - 1)) {
          if (this.completedGames[i].playerOneWon === true) {
            gamesWon = gamesWon + 1;
          }
          i++;
        }
      } else if (playerNum === 2) {
        gamesWon = (this.currentGame.playerTwoWon === true ? 1 : 0);
        while (i <= (this.completedGames.length - 1)) {
          if (this.completedGames[i].playerTwoWon === true) {
            gamesWon = gamesWon + 1;
          }
          i++;
        }
      }
      return gamesWon;
    };

    Match.prototype.getMatchPointsByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.gamesNeededToWin) > (this.getGamesWonByPlayer(2) / this.player.two.gamesNeededToWin)) {
          return 1;
        } else {
          return 0;
        }
      } else if (playerNum === 2) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.gamesNeededToWin) < (this.getGamesWonByPlayer(2) / this.player.two.gamesNeededToWin)) {
          return 1;
        } else {
          return 0;
        }
      }
    };

    Match.prototype.getMatchPoints = function() {
      if (this.getMatchPointsByPlayer(1) === this.getMatchPointsByPlayer(2)) {
        return "TIE";
      } else {
        return this.getMatchPointsByPlayer(1) + "-" + this.getMatchPointsByPlayer(2);
      }
    };

    Match.prototype.setSuddenDeathMode = function() {
      this.suddenDeath = true;
      this.player.one.gamesNeededToWin = 1;
      return this.player.two.gamesNeededToWin = 1;
    };

    Match.prototype.scoreNumberedBall = function(ballNumber) {
      this.arePlayersSwitching = false;
      this.currentGame.scoreBall(ballNumber);
      if (this.isPlayerWinning(1) === true) {
        this.playerNumberWinning = 1;
      } else {
        this.playerNumberWinning = 2;
      }
      return this.checkForWin();
    };

    Match.prototype.shotMissed = function() {
      this.currentGame.nextPlayerIsUp();
      if (this.currentGame.breakingPlayerStillShooting === false) {
        return this.arePlayersSwitching = true;
      }
    };

    Match.prototype.hitSafety = function() {
      return this.currentGame.hitSafety();
    };

    Match.prototype.checkForWin = function() {
      if (this.getRemainingGamesNeededToWinByPlayer(1) === 0 || this.getRemainingGamesNeededToWinByPlayer(2) === 0) {
        return this.ended = true;
      }
    };

    Match.prototype.startNewGame = function() {
      if (this.currentGame.ended === true) {
        this.completedGames.push(this.currentGame);
        return this.currentGame = this.getNewGame();
      }
    };

    Match.prototype.resetPlayerRankStats = function() {
      this.player.one.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(this.player.one.rank, this.player.two.rank);
      this.player.two.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(this.player.two.rank, this.player.one.rank);
      this.player.one.resetPlayerRankStats();
      return this.player.two.resetPlayerRankStats();
    };

    Match.prototype.isPlayerWinning = function(playerNum) {
      if (playerNum === 1) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.gamesNeededToWin) > (this.getGamesWonByPlayer(2) / this.player.two.gamesNeededToWin)) {
          return true;
        } else {
          return false;
        }
      } else if (playerNum === 2) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.gamesNeededToWin) < (this.getGamesWonByPlayer(2) / this.player.two.gamesNeededToWin)) {
          return true;
        } else {
          return false;
        }
      }
    };

    Match.prototype.toJSON = function() {
      return {
        player: {
          one: this.player.one.toJSON(),
          two: this.player.two.toJSON()
        },
        playerOneWon: this.getGamesWonByPlayer(1),
        playerTwoWon: this.getGamesWonByPlayer(2),
        currentGame: this.currentGame.toJSON(),
        completedGames: this.completedGamesToJSON(),
        suddenDeath: this.suddenDeath,
        forfeit: this.forfeit,
        ended: this.ended,
        originalId: this.originalId,
        leagueMatchId: this.leagueMatchId
      };
    };

    Match.prototype.completedGamesToJSON = function() {
      var arrayToReturn, i;
      arrayToReturn = [];
      i = 0;
      while (i <= this.completedGames.length - 1) {
        arrayToReturn[i] = this.completedGames[i].toJSON();
        i++;
      }
      return arrayToReturn;
    };

    Match.prototype.fromJSON = function(json) {
      var currentGame;
      this.player.one = this.playerFromJSON(json.player.one);
      this.player.two = this.playerFromJSON(json.player.two);
      this.resetPlayerRankStats();
      this.completedGames = this.completedGamesFromJSON(json.completedGames);
      this.suddenDeath = json.suddenDeath;
      this.forfeit = json.forfeit;
      this.ended = json.ended;
      this.originalId = json.originalId;
      this.leagueMatchId = json.leagueMatchId;
      currentGame = this.getNewGame();
      currentGame.fromJSON(new function() {
        return json.currentGame;
      });
      return this.currentGame = currentGame;
    };

    Match.prototype.playerFromJSON = function(json) {
      var player;
      player = new $CS.Models.EightBall.Player(json);
      player.fromJSON(new function() {
        return json;
      });
      return player;
    };

    Match.prototype.completedGamesFromJSON = function(json) {
      var arrayToReturn, completedGame, i;
      arrayToReturn = [];
      i = 0;
      while (i <= json.length - 1) {
        completedGame = this.getNewGame();
        completedGame.fromJSON(new function() {
          return json[i];
        });
        arrayToReturn.push(completedGame);
        i++;
      }
      return arrayToReturn;
    };

    return Match;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.Match = Match;

}).call(this);
