// Generated by CoffeeScript 1.3.1
(function() {
  var Match,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Match = (function(_super) {

    __extends(Match, _super);

    Match.name = 'Match';

    Match.prototype.defaults = {};

    function Match(player1, player2, player1Rank, player2Rank, player1Number, player2Number, player1TeamNumber, player2TeamNumber) {
      var getNewGame, me;
      _.extend(this, this.defaults);
      this.PlayerOne = new NineBallPlayer(player1, player1Rank, player1Number, player1TeamNumber);
      this.PlayerTwo = new NineBallPlayer(player2, player2Rank, player2Number, player2TeamNumber);
      this.CompletedGames = [];
      this.Ended = false;
      this.OriginalId = 0;
      this.LeagueMatchId = 0;
      this.PlayerNumberWinning = 0;
      this.SuddenDeath = false;
      this.Forfeit = false;
      me = this;
      getNewGame = function() {
        return new NineBallGame(function() {
          return me.PlayerOne;
        }, function() {
          return me.PlayerTwo;
        }, function() {
          return me.Ended = true;
        });
      };
      this.CurrentGame = this.getNewGame();
    }

    Match.prototype.scoreNumberedBall = function(ballNumber) {
      this.CurrentGame.scoreBall(ballNumber);
      if (this.isPlayerOneWinning() === true) {
        this.PlayerNumberWinning = 1;
      } else {
        this.PlayerNumberWinning = 2;
      }
      return this.checkForWin();
    };

    Match.prototype.shotMissed = function() {
      return this.CurrentGame.nextPlayerIsUp();
    };

    Match.prototype.hitDeadBall = function(ballNumber) {
      this.CurrentGame.hitDeadBall(ballNumber);
      return this.checkForWin();
    };

    Match.prototype.hitSafety = function() {
      return this.CurrentGame.hitSafety();
    };

    Match.prototype.checkForWin = function() {};

    Match.prototype.startNewGame = function() {
      if (this.CurrentGame.Ended === true) {
        this.CompletedGames.push(me.CurrentGame);
        return this.CurrentGame = me.getNewGame();
      }
    };

    Match.prototype.setSuddenDeathMode = function() {
      this.SuddenDeath = true;
      this.PlayerOne.GamesNeededToWin = 1;
      return this.PlayerTwo.GamesNeededToWin = 1;
    };

    Match.prototype.getPlayerOneScore = function() {
      return this.PlayerOne.Score;
    };

    Match.prototype.getLosingPlayer = function() {
      if (this.isPlayerOneWinning() === true) {
        return this.PlayerTwo;
      } else {
        return this.PlayerOne;
      }
    };

    Match.prototype.getWinningPlayer = function() {
      if (this.isPlayerOneWinning() === true) {
        return this.PlayerOne;
      } else {
        return this.PlayerTwo;
      }
    };

    Match.prototype.getLosingPlayersMatchPoints = function() {
      var losingScore;
      losingScore = new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      return losingScore;
    };

    Match.prototype.getWinningPlayersMatchPoints = function() {
      var winningScore;
      winningScore = new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      return winningScore;
    };

    Match.prototype.getPlayerOneMatchPoints = function() {
      if (this.isPlayerOneWinning() === true && this.isPlayerTwoWinning() === false) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      }
      return new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
    };

    Match.prototype.getPlayerTwoMatchPoints = function() {
      if (this.isPlayerOneWinning() === false && this.isPlayerTwoWinning() === true) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      }
      return new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
    };

    Match.prototype.getMatchPoints = function() {
      if (this.isPlayerOneWinning() === true) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.PlayerTwo.Rank, this.PlayerTwo.Score) + "-" + new NineBallRanks().getLosingPlayersMatchPoints(this.PlayerTwo.Rank, this.PlayerTwo.Score);
      } else {
        if (this.isPlayerTwoWinning() === true) {
          return new NineBallRanks().getLosingPlayersMatchPoints(this.PlayerOne.Rank, this.PlayerOne.Score) + "-" + new NineBallRanks().getWinningPlayersMatchPoints(this.PlayerOne.Rank, this.PlayerOne.Score);
        }
      }
      return "Tied";
    };

    Match.prototype.isPlayerOneWinning = function() {
      if ((this.PlayerOne.getRatioScore() > this.PlayerTwo.getRatioScore()) || (this.PlayerOne.getRatioScore() === this.PlayerTwo.getRatioScore() && this.PlayerNumberWinning === 1)) {
        return true;
      }
      return false;
    };

    Match.prototype.isPlayerTwoWinning = function() {
      if ((this.PlayerOne.getRatioScore() < this.PlayerTwo.getRatioScore()) || (this.PlayerOne.getRatioScore() === this.PlayerTwo.getRatioScore() && this.PlayerNumberWinning === 2)) {
        return true;
      }
      return false;
    };

    Match.prototype.getMatchPointsByTeamNumber = function(teamNumber) {
      if (this.PlayerOne.TeamNumber === teamNumber) {
        return this.getPlayerOneMatchPoints();
      } else {
        if (this.PlayerTwo.TeamNumber === teamNumber) {
          return this.getPlayerTwoMatchPoints();
        }
      }
      return 0;
    };

    Match.prototype.getTotalInnings = function() {
      var i, totalInnings;
      totalInnings = this.CurrentGame.NumberOfInnings;
      if (this.CompletedGames.length > 0) {
        i = 0;
        while (i <= (this.CompletedGames.length - 1)) {
          totalInnings += this.CompletedGames[i].NumberOfInnings;
          i++;
        }
      }
      return totalInnings.toString();
    };

    Match.prototype.getTotalDeadBalls = function() {
      var i, totalDeadBalls;
      totalDeadBalls = this.CurrentGame.getDeadBalls();
      if (this.CompletedGames.length > 0) {
        i = 0;
        while (i <= (this.CompletedGames.length - 1)) {
          totalDeadBalls += this.CompletedGames[i].getDeadBalls();
          i++;
        }
      }
      return totalDeadBalls.toString();
    };

    Match.prototype.getTotalSafeties = function() {
      return this.PlayerOne.getSafeties() + " to " + this.PlayerTwo.getSafeties();
    };

    Match.prototype.getCurrentGameNumber = function() {
      return (this.CompletedGames.length + 1).toString();
    };

    Match.prototype.toJSON = function() {
      return {
        PlayerOne: this.PlayerOne.toJSON(),
        PlayerTwo: this.PlayerTwo.toJSON(),
        PlayerOneMatchPointsEarned: this.getPlayerOneMatchPoints(),
        PlayerTwoMatchPointsEarned: this.getPlayerTwoMatchPoints(),
        CurrentGame: this.CurrentGame.toJSON(),
        CompletedGames: this.completedGamesToJSON(),
        SuddenDeath: this.SuddenDeath,
        Forfeit: this.Forfeit,
        Ended: this.Ended,
        OriginalId: this.OriginalId,
        LeagueMatchId: this.LeagueMatchId
      };
    };

    Match.prototype.completedGamesToJSON = function() {
      var arrayToReturn, i;
      arrayToReturn = [];
      i = 0;
      while (i <= this.CompletedGames.length - 1) {
        arrayToReturn[i] = this.CompletedGames[i].toJSON();
        i++;
      }
      return arrayToReturn;
    };

    Match.prototype.fromJSON = function(json) {
      var currentGame;
      this.PlayerOneMatchPointsEarned = json.PlayerOneMatchPointsEarned;
      this.PlayerTwoMatchPointsEarned = json.PlayerTwoMatchPointsEarned;
      this.PlayerOne = this.playerFromJSON(json.PlayerOne);
      this.PlayerTwo = this.playerFromJSON(json.PlayerTwo);
      this.CompletedGames = this.completedGamesFromJSON(json.CompletedGames);
      this.SuddenDeath = json.SuddenDeath;
      this.Forfeit = json.Forfeit;
      this.Ended = json.Ended;
      this.OriginalId = json.OriginalId;
      this.LeagueMatchId = json.LeagueMatchId;
      currentGame = this.getNewGame();
      currentGame.fromJSON(new function() {
        return json.CurrentGame;
      });
      return this.CurrentGame = currentGame;
    };

    Match.prototype.playerFromJSON = function(json) {
      var player;
      player = new NineBallPlayer();
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

  })($CS.Models.NineBall);

  $CS.Models.NineBall.Match = Match;

}).call(this);
