// Generated by CoffeeScript 1.3.3
(function() {
  var Game,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Game = (function(_super) {
    var getScoreRatio;

    __extends(Game, _super);

    Game.prototype.defaults = {
      stripes: 1,
      solids: 2,
      innings: 0,
      matchEndedCallback: function() {},
      numberOfInnings: 0,
      ended: false,
      ballsHitIn: {
        stripes: [],
        solids: []
      },
      lastBallHitIn: null,
      onBreak: true,
      breakingPlayerStillShooting: true,
      scratchOnEight: false,
      earlyEight: false,
      playerOneWon: false,
      playerTwoWon: false,
      player: {
        one: {
          eightBall: [],
          eightOnSnap: false,
          breakAndRun: false,
          timeoutsTaken: 0,
          callback: function() {},
          ballType: null
        },
        two: {
          eightBall: [],
          eightOnSnap: false,
          breakAndRun: false,
          timeoutsTaken: 0,
          callback: function() {},
          ballType: null
        }
      }
    };

    function Game(options) {
      _.extend(this, this.defaults);
      this.player.one.callback = options.addToPlayerOne;
      this.player.two.callback = options.addToPlayerTwo;
      this.matchEndedCallback = options.callback;
      this.player.one.timeoutsTaken = 0;
      this.player.two.timeoutsTaken = 0;
    }

    Game.prototype.getCurrentlyUpPlayer = function() {
      if (this.player.one.callback().currentlyUp === true) {
        return this.player.one.callback();
      }
      return this.player.two.callback();
    };

    Game.prototype.getWinningPlayer = function() {
      if (this.playerOneWon === true) {
        return this.player.one;
      } else if (this.playerTwoWon === true) {
        return this.player.two;
      }
    };

    Game.prototype.getWinningPlayerName = function() {
      return this.getWinningPlayer().callback().getFirstNameWithInitials();
    };

    Game.prototype.getBallsHitInByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player.one.ballType === this.stripes) {
          return this.ballsHitIn.stripes.concat(this.player.one.eightBall);
        } else {
          if (this.player.one.ballType === this.solids) {
            return this.ballsHitIn.solids.concat(this.player.one.eightBall);
          }
          return [];
        }
      }
      if (playerNum === 2) {
        if (this.player.two.ballType === this.stripes) {
          return this.ballsHitIn.stripes.concat(this.player.two.eightBall);
        } else {
          if (this.player.two.ballType === this.solids) {
            return this.ballsHitIn.solids.concat(this.player.two.eightBall);
          }
          return [];
        }
      }
    };

    Game.prototype.getGameScore = function() {
      return this.getBallsHitInByPlayer(1).length + "-" + this.getBallsHitInByPlayer(2).length;
    };

    Game.prototype.getBallsHitIn = function() {
      return this.ballsHitIn.solids.concat(this.ballsHitIn.stripes.concat(this.player.two.eightBall.concat(this.player.one.eightBall)));
    };

    Game.prototype.getCurrentPlayerRemainingTimeouts = function() {
      if (this.player.one.callback().currentlyUp === true) {
        return this.player.one.callback().timeouts_allowed - this.player.one.timeoutsTaken;
      } else {
        return this.player.two.callback().timeouts_allowed - this.player.two.timeoutsTaken;
      }
    };

    getScoreRatio = function(playerScore, playerBallCount) {
      return playerScore / playerBallCount;
    };

    Game.prototype.setPlayerWon = function(playerNum) {
      if (playerNum === 1) {
        this.playerOneWon = true;
        return this.player.one.callback().gamesWon += 1;
      } else if (playerNum === 2) {
        this.playerTwoWon = true;
        return this.player.two.callback().gamesWon += 1;
      }
    };

    Game.prototype.setEightOnSnapByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player.one.eightOnSnap !== true) {
          this.player.one.callback().addToEightOnSnaps(1);
        }
        return this.player.one.eightOnSnap = true;
      } else if (playerNum === 2) {
        if (this.player.two.eightOnSnap !== true) {
          this.player.two.callback().addToEightOnSnaps(1);
        }
        return this.player.two.eightOnSnap = true;
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

    Game.prototype.setBallTypeByPlayer = function(playerNum, type) {
      if (playerNum === 1 && type === "stripes") {
        this.player.one.ballType = this.stripes;
        this.player.two.ballType = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "stripes") {
        this.player.two.ballType = this.stripes;
        this.player.one.ballType = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 1 && type === "solids") {
        this.player.one.ballType = this.solids;
        this.player.two.ballType = this.stripes;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "solids") {
        this.player.two.ballType = this.solids;
        this.player.one.ballType = this.stripes;
        return this.checkForWinner();
      }
    };

    Game.prototype.hitSafety = function() {
      this.getCurrentlyUpPlayer().addToSafeties(1);
      return this.nextPlayerIsUp();
    };

    Game.prototype.hitScratchOnEight = function() {
      this.scratchOnEight = true;
      this.ended = true;
      if (this.player.one.callback().currentlyUp === true) {
        this.playerTwoWon = true;
        this.player.one.callback().currentlyUp = false;
        this.player.two.callback().currentlyUp = true;
      } else {
        this.playerOneWon = true;
        this.player.two.callback().currentlyUp = false;
        this.player.one.callback().currentlyUp = true;
      }
      return this.matchEndedCallback();
    };

    Game.prototype.shotMissed = function() {
      return this.nextPlayerIsUp();
    };

    Game.prototype.addToNumberOfInnings = function(num) {
      return this.numberOfInnings += num;
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

    Game.prototype.breakIsOver = function() {
      return this.onBreak = false;
    };

    Game.prototype.end = function() {
      return this.ended = true;
    };

    Game.prototype.scoreBall = function(ballNumber) {
      if (!(this.getBallsHitIn().indexOf(ballNumber) > 0)) {
        this.lastBallHitIn = ballNumber;
        if (ballNumber > 0 && ballNumber < 8) {
          this.ballsHitIn.solids.push(ballNumber);
        } else if (ballNumber > 8 && ballNumber < 16) {
          this.ballsHitIn.stripes.push(ballNumber);
        } else {
          if (this.player.one.callback().currentlyUp === true) {
            this.player.one.eightBall.push(ballNumber);
          } else {
            if (this.player.two.callback().currentlyUp === true) {
              this.player.two.eightBall.push(ballNumber);
            }
          }
          if (this.onBreak === true) {
            if (this.ballsHitIn.solids.length !== 7 && this.ballsHitIn.stripes.length !== 7) {
              if (this.player.one.callback().currentlyUp === true) {
                this.setEightOnSnapByPlayer(1);
              } else {
                if (this.player.two.callback().currentlyUp === true) {
                  this.setEightOnSnapByPlayer(2);
                }
              }
            }
          } else {
            if (this.ballsHitIn.solids.length !== 7 && this.ballsHitIn.stripes.length !== 7) {
              this.earlyEight = true;
              if (this.player.one.callback().currentlyUp === true) {
                this.player.one.callback().currentlyUp = false;
                this.player.two.callback().currentlyUp = true;
              } else if (this.player.two.callback().currentlyUp === true) {
                this.player.one.callback().currentlyUp = true;
                this.player.two.callback().currentlyUp = false;
              }
            }
          }
        }
        return this.checkForWinner();
      }
    };

    Game.prototype.checkForWinner = function() {
      if (this.getBallsHitIn().indexOf(8) >= 0) {
        this.ended = true;
      }
      if (this.ended === true) {
        if (this.breakingPlayerStillShooting === true && (this.ballsHitIn.solids.length === 7 || this.ballsHitIn.stripes.length === 7)) {
          if (this.player.one.callback().currentlyUp === true) {
            this.setBreakAndRunByPlayer(1);
            this.player.one.ballType = this.solids;
            this.player.two.ballType = this.stripes;
          } else if (this.player.two.callback().currentlyUp === true) {
            this.setBreakAndRunByPlayer(2);
            this.player.two.ballType = this.solids;
            this.player.one.ballType = this.stripes;
          }
        }
        if (this.player.one.eightBall.indexOf(8) >= 0 && this.onBreak === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8 && this.getBallsHitInByPlayer(2).length !== 8) {
            this.setPlayerWon(2);
          } else if (this.getBallsHitInByPlayer(1).length === 8) {
            this.setPlayerWon(1);
          }
        } else if (this.player.two.eightBall.indexOf(8) >= 0 && this.onBreak === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8 && this.getBallsHitInByPlayer(2).length !== 8) {
            this.setPlayerWon(1);
          } else if (this.getBallsHitInByPlayer(2).length === 8) {
            this.setPlayerWon(2);
          }
        } else {
          if (this.player.one.callback().currentlyUp === true) {
            this.setPlayerWon(1);
          } else if (this.player.two.callback().currentlyUp === true) {
            this.setPlayerWon(2);
          }
        }
        return this.matchEndedCallback();
      }
    };

    Game.prototype.nextPlayerIsUp = function() {
      if (this.onBreak !== true || ((this.player.two.callback().currentlyUp === true || this.player.one.callback().currentlyUp === true) && this.getBallsHitIn().length === 0)) {
        if (this.player.one.callback().currentlyUp === true) {
          this.player.two.callback().currentlyUp = true;
          this.player.one.callback().currentlyUp = false;
          if (this.player.one.ballType == null) {
            if (this.ballsHitIn.solids.length > 0 && this.ballsHitIn.stripes.length === 0) {
              this.player.one.ballType = this.solids;
              this.player.two.ballType = this.stripes;
            } else if (this.ballsHitIn.solids.length === 0 && this.ballsHitIn.stripes.length > 0) {
              this.player.one.ballType = this.stripes;
              this.player.two.ballType = this.solids;
            }
          }
        } else if (this.player.two.callback().currentlyUp === true) {
          this.player.two.callback().currentlyUp = false;
          this.player.one.callback().currentlyUp = true;
          this.addToNumberOfInnings(1);
          if (this.player.two.ballType == null) {
            if (this.ballsHitIn.solids.length === 0 && this.ballsHitIn.stripes.length > 0) {
              this.player.one.ballType = this.solids;
              this.player.two.ballType = this.stripes;
            } else if (this.ballsHitIn.solids.length > 0 && this.ballsHitIn.stripes.length === 0) {
              this.player.one.ballType = this.stripes;
              this.player.two.ballType = this.solids;
            }
          }
        } else {
          this.player.one.callback().currentlyUp = true;
        }
        this.breakingPlayerStillShooting = false;
      }
      return this.onBreak = false;
    };

    Game.prototype.toJSON = function() {
      return {
        playerOneTimeoutsTaken: this.player.one.timeoutsTaken,
        playerTwoTimeoutsTaken: this.player.two.timeoutsTaken,
        playerOneEightOnSnap: this.player.one.eightOnSnap,
        playerOneBreakAndRun: this.player.one.breakAndRun,
        playerTwoEightOnSnap: this.player.two.eightOnSnap,
        playerTwoBreakAndRun: this.player.two.breakAndRun,
        playerOneBallType: this.player.one.ballType,
        playerTwoBallType: this.player.two.ballType,
        playerOneEightBall: this.player.one.eightBall,
        playerTwoEightBall: this.player.two.eightBall,
        playerOneWon: this.playerOneWon,
        playerTwoWon: this.playerTwoWon,
        numberOfInnings: this.numberOfInnings,
        earlyEight: this.earlyEight,
        scratchOnEight: this.scratchOnEight,
        breakingPlayerStillShooting: this.breakingPlayerStillShooting,
        stripedBallsHitIn: this.ballsHitIn.stripes,
        solidBallsHitIn: this.ballsHitIn.solids,
        lastBallHitIn: this.lastBallHitIn,
        onBreak: this.onBreak,
        ended: this.ended
      };
    };

    Game.prototype.fromJSON = function(gameJSON) {
      this.player.one.timeoutsTaken = gameJSON.playerOneTimeoutsTaken;
      this.player.two.timeoutsTaken = gameJSON.playerTwoTimeoutsTaken;
      this.player.one.eightOnSnap = gameJSON.playerOneEightOnSnap;
      this.player.one.breakAndRun = gameJSON.playerOneBreakAndRun;
      this.player.two.eightOnSnap = gameJSON.playerTwoEightOnSnap;
      this.player.two.breakAndRun = gameJSON.playerTwoBreakAndRun;
      this.player.one.ballType = gameJSON.playerOneBallType;
      this.player.two.ballType = gameJSON.playerTwoBallType;
      this.player.one.eightBall = gameJSON.playerOneEightBall;
      this.player.two.eightBall = gameJSON.playerTwoEightBall;
      this.playerOneWon = gameJSON.playerOneWon;
      this.playerTwoWon = gameJSON.playerTwoWon;
      this.numberOfInnings = gameJSON.numberOfInnings;
      this.breakingPlayerStillShooting = gameJSON.breakingPlayerStillShooting;
      this.ballsHitIn.solids = gameJSON.solidBallsHitIn;
      this.ballsHitIn.stripes = gameJSON.stripedBallsHitIn;
      this.lastBallHitIn = gameJSON.lastBallHitIn;
      this.onBreak = gameJSON.onBreak;
      return this.ended = gameJSON.ended;
    };

    return Game;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.Game = Game;

}).call(this);
