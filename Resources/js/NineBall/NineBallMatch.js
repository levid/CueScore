// Generated by CoffeeScript 1.3.3
(function() {
  var NineBallMatch;

  NineBallMatch = function(player1, player2, player1Rank, player2Rank, player1Number, player2Number, player1TeamNumber, player2TeamNumber) {
    var me;
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
    this.getNewGame = function() {
      return new NineBallGame(function() {
        return me.PlayerOne;
      }, function() {
        return me.PlayerTwo;
      }, function() {
        return me.Ended = true;
      });
    };
    this.CurrentGame = this.getNewGame();
    this.scoreNumberedBall = function(ballNumber) {
      this.CurrentGame.scoreBall(ballNumber);
      if (this.isPlayerOneWinning() === true) {
        this.PlayerNumberWinning = 1;
      } else {
        this.PlayerNumberWinning = 2;
      }
      return this.checkForWin();
    };
    this.shotMissed = function() {
      return this.CurrentGame.nextPlayerIsUp();
    };
    this.hitDeadBall = function(ballNumber) {
      this.CurrentGame.hitDeadBall(ballNumber);
      return this.checkForWin();
    };
    this.hitSafety = function() {
      return this.CurrentGame.hitSafety();
    };
    this.checkForWin = function() {};
    this.startNewGame = function() {
      if (this.CurrentGame.Ended === true) {
        this.CompletedGames.push(me.CurrentGame);
        return this.CurrentGame = me.getNewGame();
      }
    };
    this.setSuddenDeathMode = function() {
      this.SuddenDeath = true;
      this.PlayerOne.GamesNeededToWin = 1;
      return this.PlayerTwo.GamesNeededToWin = 1;
    };
    this.getPlayerOneScore = function() {
      return this.PlayerOne.Score;
    };
    this.getLosingPlayer = function() {
      if (this.isPlayerOneWinning() === true) {
        return this.PlayerTwo;
      } else {
        return this.PlayerOne;
      }
    };
    this.getWinningPlayer = function() {
      if (this.isPlayerOneWinning() === true) {
        return this.PlayerOne;
      } else {
        return this.PlayerTwo;
      }
    };
    this.getLosingPlayersMatchPoints = function() {
      var losingScore;
      losingScore = new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      return losingScore;
    };
    this.getWinningPlayersMatchPoints = function() {
      var winningScore;
      winningScore = new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      return winningScore;
    };
    this.getPlayerOneMatchPoints = function() {
      if (this.isPlayerOneWinning() === true && this.isPlayerTwoWinning() === false) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      }
      return new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
    };
    this.getPlayerTwoMatchPoints = function() {
      if (this.isPlayerOneWinning() === false && this.isPlayerTwoWinning() === true) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      }
      return new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
    };
    this.getMatchPoints = function() {
      if (this.isPlayerOneWinning() === true) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.PlayerTwo.Rank, this.PlayerTwo.Score) + "-" + new NineBallRanks().getLosingPlayersMatchPoints(this.PlayerTwo.Rank, this.PlayerTwo.Score);
      } else {
        if (this.isPlayerTwoWinning() === true) {
          return new NineBallRanks().getLosingPlayersMatchPoints(this.PlayerOne.Rank, this.PlayerOne.Score) + "-" + new NineBallRanks().getWinningPlayersMatchPoints(this.PlayerOne.Rank, this.PlayerOne.Score);
        }
      }
      return "Tied";
    };
    this.isPlayerOneWinning = function() {
      if ((this.PlayerOne.getRatioScore() > this.PlayerTwo.getRatioScore()) || (this.PlayerOne.getRatioScore() === this.PlayerTwo.getRatioScore() && this.PlayerNumberWinning === 1)) {
        return true;
      }
      return false;
    };
    this.isPlayerTwoWinning = function() {
      if ((this.PlayerOne.getRatioScore() < this.PlayerTwo.getRatioScore()) || (this.PlayerOne.getRatioScore() === this.PlayerTwo.getRatioScore() && this.PlayerNumberWinning === 2)) {
        return true;
      }
      return false;
    };
    this.getMatchPointsByTeamNumber = function(teamNumber) {
      if (this.PlayerOne.TeamNumber === teamNumber) {
        return this.getPlayerOneMatchPoints();
      } else {
        if (this.PlayerTwo.TeamNumber === teamNumber) {
          return this.getPlayerTwoMatchPoints();
        }
      }
      return 0;
    };
    this.getTotalInnings = function() {
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
    this.getTotalDeadBalls = function() {
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
    this.getTotalSafeties = function() {
      return this.PlayerOne.getSafeties() + " to " + this.PlayerTwo.getSafeties();
    };
    this.getCurrentGameNumber = function() {
      return (this.CompletedGames.length + 1).toString();
    };
    this.toJSON = function() {
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
    this.completedGamesToJSON = function() {
      var arrayToReturn, i;
      arrayToReturn = [];
      i = 0;
      while (i <= this.CompletedGames.length - 1) {
        arrayToReturn[i] = this.CompletedGames[i].toJSON();
        i++;
      }
      return arrayToReturn;
    };
    this.fromJSON = function(json) {
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
    this.playerFromJSON = function(json) {
      var player;
      player = new NineBallPlayer();
      player.fromJSON(new function() {
        return json;
      });
      return player;
    };
    return this.completedGamesFromJSON = function(json) {
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
  };

}).call(this);
