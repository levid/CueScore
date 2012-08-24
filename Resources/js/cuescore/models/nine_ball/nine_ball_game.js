// Generated by CoffeeScript 1.3.3
(function() {
  var Game,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Array.prototype.exists = function(search) {
    var i;
    i = 0;
    while (i < this.length) {
      if (this[i] === search) {
        return true;
      }
      i++;
    }
    return false;
  };

  Game = (function(_super) {

    __extends(Game, _super);

    Game.prototype.defaults = {
      player: {
        one: {
          score: 0,
          nineOnSnap: false,
          breakAndRun: false,
          ballsHitIn: [],
          deadBalls: [],
          lastBall: null,
          timeoutsTaken: 0,
          callback: function() {}
        },
        two: {
          score: 0,
          nineOnSnap: false,
          breakAndRun: false,
          ballsHitIn: [],
          deadBalls: [],
          lastBall: null,
          timeoutsTaken: 0,
          callback: function() {}
        }
      },
      numberOfInnings: 0,
      ended: false,
      onBreak: true,
      breakingPlayerStillShooting: true,
      matchEndedCallback: function() {}
    };

    function Game(options) {
      _.extend(this, this.defaults);
      this.player.one.callback = options.addToPlayerOne;
      this.player.two.callback = options.addToPlayerTwo;
      this.matchEndedCallback = options.callback;
      this.player.one.callback().timeoutsTaken = 0;
      this.player.two.callback().timeoutsTaken = 0;
    }

    Game.prototype.getCurrentlyUpPlayer = function() {
      if (this.player.one.callback().currentlyUp === true) {
        return this.player.one.callback();
      } else {
        return this.player.two.callback();
      }
    };

    Game.prototype.getDeadBalls = function() {
      return this.player.one.deadBalls.length + this.player.two.deadBalls.length;
    };

    Game.prototype.getScoreRatio = function(playerScore, playerBallCount) {
      return playerScore / playerBallCount;
    };

    Game.prototype.getWinningPlayerName = function() {
      if (this.getScoreRatio(this.player.one.score, this.player.one.callback().ballCount) > this.getScoreRatio(this.player.two.score, this.player.two.callback().ballCount)) {
        return this.player.one.callback().getFirstNameWithInitials();
      } else if (this.getScoreRatio(this.player.one.score, this.player.one.callback().ballCount) < this.getScoreRatio(this.player.two.score, this.player.two.callback().ballCount)) {
        return this.player.two.callback().getFirstNameWithInitials();
      } else {
        return "Tie";
      }
    };

    Game.prototype.getGameScore = function() {
      return this.player.one.score + "-" + this.player.two.score;
    };

    Game.prototype.getBallsHitInByPlayer = function(playerNum) {
      if (playerNum === 1) {
        return this.player.one.ballsHitIn.concat(this.player.one.deadBalls);
      } else if (playerNum === 2) {
        return this.player.two.ballsHitIn.concat(this.player.two.deadBalls);
      }
    };

    Game.prototype.getBallsHitIn = function() {
      return this.player.one.ballsHitIn.concat(this.player.two.ballsHitIn).concat(this.player.one.deadBalls).concat(this.player.two.deadBalls);
    };

    Game.prototype.getBallsScored = function() {
      return this.player.one.ballsHitIn.concat(this.player.two.ballsHitIn);
    };

    Game.prototype.getCurrentPlayerRemainingTimeouts = function() {
      if (this.player.one.callback().currentlyUp === true) {
        return (this.player.one.callback().timeoutsAllowed - this.player.one.timeoutsTaken).toString();
      } else {
        return (this.player.two.callback().timeoutsAllowed - this.player.two.timeoutsTaken).toString();
      }
    };

    Game.prototype.setNineOnSnapByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player.one.nineOnSnap !== true) {
          this.player.one.callback().addToNineOnSnaps(1);
        }
        return this.player.one.nineOnSnap = true;
      } else if (playerNum === 2) {
        if (this.player.two.nineOnSnap !== true) {
          this.player.two.callback().addToNineOnSnaps(1);
        }
        return this.player.two.nineOnSnap = true;
      }
    };

    Game.prototype.setBreakAndRunByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player.one.breakAndRun !== true) {
          this.player.one.callback().addToBreakAndRuns(1);
        }
        return this.player.one.breakAndRun = true;
      } else if (playerNum === 2) {
        if (this.player.two.breakAndRun !== true) {
          this.player.two.callback().addToBreakAndRuns(1);
        }
        return this.player.two.breakAndRun = true;
      }
    };

    Game.prototype.hitSafety = function() {
      this.getCurrentlyUpPlayer().addToSafeties(1);
      return this.nextPlayerIsUp();
    };

    Game.prototype.hitDeadBall = function(ballNumber) {
      if (ballNumber !== 9 && !this.getBallsHitIn().exists(ballNumber)) {
        this.deadBalls += 1;
        if (this.player.one.callback().currentlyUp === true) {
          this.player.one.deadBalls.push(ballNumber);
        } else {
          this.player.two.deadBalls.push(ballNumber);
        }
        return this.checkIfAllBallsAreHitIn();
      }
    };

    Game.prototype.takeTimeout = function() {
      if (this.getCurrentPlayerRemainingTimeouts() > 0) {
        if (this.player.one.callback().currentlyUp === true) {
          return this.player.one.timeoutsTaken += 1;
        } else {
          return this.player.two.timeoutsTaken += 1;
        }
      }
    };

    Game.prototype.checkIfAllBallsAreHitIn = function() {
      var allBallsHitIn, i;
      allBallsHitIn = this.getBallsHitIn();
      this.ended = allBallsHitIn.length === 9;
      if (this.ended === false) {
        if (allBallsHitIn.exists(9)) {
          i = 1;
          while (i < 9) {
            if (allBallsHitIn.exists(i) !== true) {
              if (this.player.one.callback().currentlyUp === true) {
                this.player.one.deadBalls.push(i);
              } else {
                this.player.two.deadBalls.push(i);
              }
            }
            i++;
          }
          this.ended = true;
        }
      }
      if (this.ended === true && this.getBallsScored().length === 9) {
        if (this.player.one.callback().currentlyUp === true && this.breakingPlayerStillShooting === true) {
          return this.setBreakAndRunByPlayer(1);
        } else if (this.player.two.callback().currentlyUp === true && this.breakingPlayerStillShooting === true) {
          return this.setBreakAndRunByPlayer(2);
        }
      }
    };

    Game.prototype.scoreBall = function(ballNumber) {
      if (!(this.getBallsHitIn().indexOf(ballNumber) >= 0 && !this.getBallsHitIn().exists(9))) {
        if (this.player.one.callback().currentlyUp === true) {
          if (ballNumber > 0 && ballNumber < 9) {
            this.player.one.score += 1;
            this.player.one.callback().addToScore(1);
          } else {
            this.player.one.score += 2;
            this.player.one.callback().addToScore(2);
            if (this.onBreak === true && this.getBallsScored().length !== 8) {
              this.setNineOnSnapByPlayer(1);
            }
          }
          this.player.one.lastBall = ballNumber;
          this.player.two.lastBall = null;
          this.player.one.ballsHitIn.push(ballNumber);
        } else {
          if (ballNumber > 0 && ballNumber < 9) {
            this.player.two.score += 1;
            this.player.two.callback().addToScore(1);
          } else {
            this.player.two.score += 2;
            this.player.two.callback().addToScore(2);
            if (this.onBreak === true && this.getBallsScored().length !== 8) {
              this.setNineOnSnapByPlayer(2);
            }
          }
          this.player.two.lastBall = ballNumber;
          this.player.one.lastBall = null;
          this.player.two.ballsHitIn.push(ballNumber);
        }
        this.checkIfAllBallsAreHitIn();
        return this.checkForWinner();
      }
    };

    Game.prototype.checkForWinner = function() {
      if (this.player.one.callback().hasWon() === true || this.player.two.callback().hasWon() === true) {
        this.end();
        return this.matchEndedCallback();
      }
    };

    Game.prototype.addToNumberOfInnings = function(num) {
      return this.numberOfInnings += num;
    };

    Game.prototype.nextPlayerIsUp = function() {
      if (this.onBreak !== true || ((this.player.two.callback().currentlyUp === true && this.player.two.ballsHitIn.length === 0) || (this.player.one.callback().currentlyUp === true && this.player.one.ballsHitIn.length === 0))) {
        if (this.player.one.callback().currentlyUp === true) {
          this.player.two.callback().currentlyUp = true;
          this.player.one.callback().currentlyUp = false;
        } else if (this.player.two.callback().currentlyUp === true) {
          this.player.two.callback().currentlyUp = false;
          this.player.one.callback().currentlyUp = true;
          this.addToNumberOfInnings(1);
        } else {
          this.player.one.callback().currentlyUp = true;
        }
        this.breakingPlayerStillShooting = false;
      }
      return this.onBreak = false;
    };

    Game.prototype.breakIsOver = function() {
      return this.onBreak = false;
    };

    Game.prototype.end = function() {
      return this.ended = true;
    };

    Game.prototype.toJSON = function() {
      return {
        playerOneScore: this.player.one.score,
        playerOneTimeoutsTaken: this.player.one.timeoutsTaken,
        playerOneNineOnSnap: this.player.one.nineOnSnap,
        playerOneBreakAndRun: this.player.one.breakAndRun,
        playerOneBallsHitIn: this.player.one.ballsHitIn,
        playerOneDeadBalls: this.player.one.deadBalls,
        playerOneLastBall: this.player.one.lastBall,
        playerTwoScore: this.player.two.score,
        playerTwoTimeoutsTaken: this.player.two.timeoutsTaken,
        playerTwoNineOnSnap: this.player.two.nineOnSnap,
        playerTwoBreakAndRun: this.player.two.breakAndRun,
        playerTwoBallsHitIn: this.player.two.ballsHitIn,
        playerTwoDeadBalls: this.player.one.deadBalls,
        playerTwoLastBall: this.player.one.lastBall,
        ended: this.ended,
        numberOfInnings: this.numberOfInnings,
        onBreak: this.onBreak,
        breakingPlayerStillShooting: this.breakingPlayerStillShooting
      };
    };

    Game.prototype.fromJSON = function(gameJSON) {
      this.player.one.score = gameJSON.playerOneScore;
      this.player.two.score = gameJSON.playerTwoScore;
      this.player.one.timeoutsTaken = gameJSON.playerOneTimeoutsTaken;
      this.player.two.timeoutsTaken = gameJSON.playerTwoTimeoutsTaken;
      this.player.one.nineOnSnap = gameJSON.playerOneNineOnSnap;
      this.player.one.breakAndRun = gameJSON.playerOneBreakAndRun;
      this.player.two.nineOnSnap = gameJSON.playerTwoNineOnSnap;
      this.player.two.breakAndRun = gameJSON.playerTwoBreakAndRun;
      this.player.one.ballsHitIn = gameJSON.playerOneBallsHitIn;
      this.player.two.ballsHitIn = gameJSON.playerTwoballsHitIn;
      this.player.one.deadBalls = gameJSON.playerOneDeadBalls;
      this.player.two.deadBalls = gameJSON.playerTwodeadBalls;
      this.player.one.lastBall = gameJSON.playerOneLastBall;
      this.player.two.lastBall = gameJSON.playerTwolastBall;
      this.numberOfInnings = gameJSON.numberOfInnings;
      this.ended = gameJSON.ended;
      this.onBreak = gameJSON.onBreak;
      return this.breakingPlayerStillShooting = gameJSON.breakingPlayerStillShooting;
    };

    return Game;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.Game = Game;

}).call(this);
