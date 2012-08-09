// Generated by CoffeeScript 1.3.3
(function() {
  var EightBallGame;

  EightBallGame = function(addToPlayerOne, addToPlayerTwo, callback) {
    this.STRIPS = 1;
    this.SOLIDS = 2;
    this.PlayerOneCallback = addToPlayerOne;
    this.PlayerTwoCallback = addToPlayerTwo;
    this.PlayerOneCallback().TimeoutsTaken = 0;
    this.PlayerTwoCallback().TimeoutsTaken = 0;
    this.MatchEndedCallback = callback;
    this.NumberOfInnings = 0;
    this.PlayerOneEightOnSnap = false;
    this.PlayerOneBreakAndRun = false;
    this.PlayerTwoEightOnSnap = false;
    this.PlayerTwoBreakAndRun = false;
    this.Ended = false;
    this.StripedBallsHitIn = [];
    this.SolidBallsHitIn = [];
    this.PlayerOneEightBall = [];
    this.PlayerTwoEightBall = [];
    this.LastBallHitIn = null;
    this.OnBreak = true;
    this.BreakingPlayerStillHitting = true;
    this.PlayerOneTimeoutsTaken = 0;
    this.PlayerTwoTimeoutsTaken = 0;
    this.PlayerOneBallType = null;
    this.PlayerTwoBallType = null;
    this.PlayerOneWon = false;
    this.PlayerTwoWon = false;
    this.ScratchOnEight = false;
    this.EarlyEight = false;
    this.getCurrentlyUpPlayer = function() {
      if (this.PlayerOneCallback().CurrentlyUp === true) {
        return this.PlayerOneCallback();
      }
      return this.PlayerTwoCallback();
    };
    this.getWinningPlayerName = function() {
      if (this.PlayerOneWon === true) {
        return this.PlayerOneCallback().getFirstNameWithInitials();
      } else {
        if (this.PlayerTwoWon === true) {
          return this.PlayerTwoCallback().getFirstNameWithInitials();
        }
      }
      return "";
    };
    this.hitSafety = function() {
      this.getCurrentlyUpPlayer().addOneToSafeties();
      return this.nextPlayerIsUp();
    };
    this.setPlayerOneWon = function() {
      this.PlayerOneWon = true;
      return this.PlayerOneCallback().GamesWon += 1;
    };
    this.setPlayerTwoWon = function() {
      this.PlayerTwoWon = true;
      return this.PlayerTwoCallback().GamesWon += 1;
    };
    this.checkForWinner = function() {
      if (this.getBallsHitIn().exists(8)) {
        this.Ended = true;
      }
      if (this.Ended === true) {
        if (this.BreakingPlayerStillHitting === true && (this.SolidBallsHitIn.length === 7 || this.StripedBallsHitIn.length === 7)) {
          if (this.PlayerOneCallback().CurrentlyUp === true) {
            this.setPlayerOneBreakAndRun();
            if (this.SolidBallsHitIn.length === 7) {
              this.PlayerOneBallType = this.SOLIDS;
              this.PlayerTwoBallType = this.STRIPS;
            } else {
              this.PlayerOneBallType = this.STRIPS;
              this.PlayerTwoBallType = this.SOLIDS;
            }
          } else if (this.PlayerTwoCallback().CurrentlyUp === true) {
            this.setPlayerTwoBreakAndRun();
            if (this.SolidBallsHitIn.length === 7) {
              this.PlayerTwoBallType = this.SOLIDS;
              this.PlayerOneBallType = this.STRIPS;
            } else {
              this.PlayerOneBallType = this.SOLIDS;
              this.PlayerTwoBallType = this.STRIPS;
            }
          }
        }
        if (this.PlayerOneEightBall.exists(8) && this.OnBreak === false) {
          if (this.getPlayerOneBallsHitIn().length !== 8) {
            this.setPlayerTwoWon();
          } else {
            this.setPlayerOneWon();
          }
        } else if (this.PlayerTwoEightBall.exists(8) && this.OnBreak === false) {
          if (this.getPlayerOneBallsHitIn().length !== 8) {
            this.setPlayerOneWon();
          } else {
            this.setPlayerTwoWon();
          }
        } else {
          if (this.PlayerOneCallback().CurrentlyUp === true) {
            this.setPlayerOneWon();
          } else {
            if (this.PlayerTwoCallback().CurrentlyUp === true) {
              this.setPlayerTwoWon();
            }
          }
        }
        return this.MatchEndedCallback();
      }
    };
    this.scoreBall = function(ballNumber) {
      if (!this.getBallsHitIn().exists(ballNumber)) {
        this.LastBallHitIn = ballNumber;
        if (ballNumber > 0 && ballNumber < 8) {
          this.SolidBallsHitIn.push(ballNumber);
        } else if (ballNumber > 8 && ballNumber < 16) {
          this.StripedBallsHitIn.push(ballNumber);
        } else {
          if (this.PlayerOneCallback().CurrentlyUp === true) {
            this.PlayerOneEightBall.push(ballNumber);
          } else {
            if (this.PlayerTwoCallback().CurrentlyUp === true) {
              this.PlayerTwoEightBall.push(ballNumber);
            }
          }
          if (this.OnBreak === true) {
            if (this.SolidBallsHitIn.length !== 7 && this.StripedBallsHitIn.length !== 7) {
              if (this.PlayerOneCallback().CurrentlyUp === true) {
                this.setPlayerOneEightOnSnap();
              } else {
                if (this.PlayerTwoCallback().CurrentlyUp === true) {
                  this.setPlayerTwoEightOnSnap();
                }
              }
            }
          } else {
            if (this.SolidBallsHitIn.length !== 7 && this.StripedBallsHitIn.length !== 7) {
              this.EarlyEight = true;
              if (this.PlayerOneCallback().CurrentlyUp === true) {
                this.PlayerOneCallback().CurrentlyUp = false;
                this.PlayerTwoCallback().CurrentlyUp = true;
              } else if (this.PlayerTwoCallback().CurrentlyUp === true) {
                this.PlayerOneCallback().CurrentlyUp = true;
                this.PlayerTwoCallback().CurrentlyUp = false;
              }
            }
          }
        }
        return this.checkForWinner();
      }
    };
    this.hitScratchOnEight = function() {
      this.ScratchOnEight = true;
      this.Ended = true;
      if (this.PlayerOneCallback().CurrentlyUp === true) {
        this.PlayerTwoWon = true;
        this.PlayerOneCallback().CurrentlyUp = false;
        this.PlayerTwoCallback().CurrentlyUp = true;
      } else {
        this.PlayerOneWon = true;
        this.PlayerTwoCallback().CurrentlyUp = false;
        this.PlayerOneCallback().CurrentlyUp = true;
      }
      return this.MatchEndedCallback();
    };
    this.addOneToNumberOfInnings = function() {
      return this.NumberOfInnings += 1;
    };
    this.nextPlayerIsUp = function() {
      if (this.OnBreak !== true || ((this.PlayerTwoCallback().CurrentlyUp === true || this.PlayerOneCallback().CurrentlyUp === true) && this.getBallsHitIn().length === 0)) {
        if (this.PlayerOneCallback().CurrentlyUp === true) {
          this.PlayerTwoCallback().CurrentlyUp = true;
          this.PlayerOneCallback().CurrentlyUp = false;
          if (this.PlayerOneBallType == null) {
            if (this.SolidBallsHitIn.length > 0 && this.StripedBallsHitIn.length === 0) {
              this.PlayerOneBallType = this.SOLIDS;
              this.PlayerTwoBallType = this.STRIPS;
            } else if (this.SolidBallsHitIn.length === 0 && this.StripedBallsHitIn.length > 0) {
              this.PlayerOneBallType = this.STRIPS;
              this.PlayerTwoBallType = this.SOLIDS;
            }
          }
        } else if (this.PlayerTwoCallback().CurrentlyUp === true) {
          this.PlayerTwoCallback().CurrentlyUp = false;
          this.PlayerOneCallback().CurrentlyUp = true;
          this.addOneToNumberOfInnings();
          if (this.PlayerTwoBallType == null) {
            if (this.SolidBallsHitIn.length === 0 && this.StripedBallsHitIn.length > 0) {
              this.PlayerOneBallType = this.SOLIDS;
              this.PlayerTwoBallType = this.STRIPS;
            } else if (this.SolidBallsHitIn.length > 0 && this.StripedBallsHitIn.length === 0) {
              this.PlayerOneBallType = this.STRIPS;
              this.PlayerTwoBallType = this.SOLIDS;
            }
          }
        } else {
          this.PlayerOneCallback().CurrentlyUp = true;
        }
        this.BreakingPlayerStillHitting = false;
      }
      return this.OnBreak = false;
    };
    this.setPlayerOneEightOnSnap = function() {
      if (this.PlayerOneEightOnSnap !== true) {
        this.PlayerOneCallback().addOneToEightOnSnaps();
      }
      return this.PlayerOneEightOnSnap = true;
    };
    this.setPlayerTwoEightOnSnap = function() {
      if (this.PlayerTwoEightOnSnap !== true) {
        this.PlayerTwoCallback().addOneToEightOnSnaps();
      }
      return this.PlayerTwoEightOnSnap = true;
    };
    this.setPlayerOneBreakAndRun = function() {
      if (this.PlayerOneBreakAndRun !== true) {
        this.PlayerOneCallback().addOneToBreakAndRuns();
      }
      return this.PlayerOneBreakAndRun = true;
    };
    this.setPlayerTwoBreakAndRun = function() {
      if (this.PlayerTwoBreakAndRun !== true) {
        this.PlayerTwoCallback().addOneToBreakAndRuns();
      }
      return this.PlayerTwoBreakAndRun = true;
    };
    this.setPlayerOneBallTypeToStriped = function() {
      this.PlayerOneBallType = this.STRIPS;
      this.PlayerTwoBallType = this.SOLIDS;
      return this.checkForWinner();
    };
    this.setPlayerOneBallTypeToSolid = function() {
      this.PlayerOneBallType = this.SOLIDS;
      this.PlayerTwoBallType = this.STRIPS;
      return this.checkForWinner();
    };
    this.setPlayerTwoBallTypeToStriped = function() {
      this.PlayerTwoBallType = this.STRIPS;
      this.PlayerOneBallType = this.SOLIDS;
      return this.checkForWinner();
    };
    this.setPlayerTwoBallTypeToSolid = function() {
      this.PlayerTwoBallType = this.SOLIDS;
      this.PlayerOneBallType = this.STRIPS;
      return this.checkForWinner();
    };
    this.getPlayerOneBallsHitIn = function() {
      if (this.PlayerOneBallType === this.STRIPS) {
        return this.StripedBallsHitIn.concat(this.PlayerOneEightBall);
      } else {
        if (this.PlayerOneBallType === this.SOLIDS) {
          return this.SolidBallsHitIn.concat(this.PlayerOneEightBall);
        }
      }
      return [];
    };
    this.getPlayerTwoBallsHitIn = function() {
      if (this.PlayerTwoBallType === this.STRIPS) {
        return this.StripedBallsHitIn.concat(this.PlayerTwoEightBall);
      } else {
        if (this.PlayerTwoBallType === this.SOLIDS) {
          return this.SolidBallsHitIn.concat(this.PlayerTwoEightBall);
        }
      }
      return [];
    };
    this.getGameScore = function() {
      return this.getPlayerOneBallsHitIn().length + "-" + this.getPlayerTwoBallsHitIn().length;
    };
    this.getBallsHitIn = function() {
      return this.SolidBallsHitIn.concat(this.StripedBallsHitIn.concat(this.PlayerTwoEightBall.concat(this.PlayerOneEightBall)));
    };
    this.getCurrentPlayerRemainingTimeouts = function() {
      if (this.PlayerOneCallback().CurrentlyUp === true) {
        return (this.PlayerOneCallback().TimeoutsAllowed - this.PlayerOneTimeoutsTaken).toString();
      }
      return (this.PlayerTwoCallback().TimeoutsAllowed - this.PlayerTwoTimeoutsTaken).toString();
    };
    this.takeTimeout = function() {
      if (this.getCurrentPlayerRemainingTimeouts() > 0) {
        if (this.PlayerOneCallback().CurrentlyUp === true) {
          return this.PlayerOneTimeoutsTaken += 1;
        } else {
          return this.PlayerTwoTimeoutsTaken += 1;
        }
      }
    };
    this.breakIsOver = function() {
      return this.OnBreak = false;
    };
    this.End = function() {
      return this.Ended = true;
    };
    this.toJSON = function() {
      return {
        PlayerOneTimeoutsTaken: this.PlayerOneTimeoutsTaken,
        PlayerTwoTimeoutsTaken: this.PlayerTwoTimeoutsTaken,
        NumberOfInnings: this.NumberOfInnings,
        PlayerOneEightOnSnap: this.PlayerOneEightOnSnap,
        PlayerOneBreakAndRun: this.PlayerOneBreakAndRun,
        PlayerTwoEightOnSnap: this.PlayerTwoEightOnSnap,
        PlayerTwoBreakAndRun: this.PlayerTwoBreakAndRun,
        PlayerOneBallType: this.PlayerOneBallType,
        PlayerTwoBallType: this.PlayerTwoBallType,
        PlayerOneEightBall: this.PlayerOneEightBall,
        PlayerTwoEightBall: this.PlayerTwoEightBall,
        PlayerOneWon: this.PlayerOneWon,
        PlayerTwoWon: this.PlayerTwoWon,
        EarlyEight: this.EarlyEight,
        ScratchOnEight: this.ScratchOnEight,
        Ended: this.Ended,
        StripedBallsHitIn: this.StripedBallsHitIn,
        SolidBallsHitIn: this.SolidBallsHitIn,
        LastBallHitIn: this.LastBallHitIn,
        OnBreak: this.OnBreak,
        BreakingPlayerStillHitting: this.BreakingPlayerStillHitting
      };
    };
    return this.fromJSON = function(gameJSON) {
      this.NumberOfInnings = gameJSON.NumberOfInnings;
      this.PlayerOneTimeoutsTaken = gameJSON.PlayerOneTimeoutsTaken;
      this.PlayerTwoTimeoutsTaken = gameJSON.PlayerTwoTimeoutsTaken;
      this.PlayerOneEightOnSnap = gameJSON.PlayerOneEightOnSnap;
      this.PlayerOneBreakAndRun = gameJSON.PlayerOneBreakAndRun;
      this.PlayerTwoEightOnSnap = gameJSON.PlayerTwoEightOnSnap;
      this.PlayerTwoBreakAndRun = gameJSON.PlayerTwoBreakAndRun;
      this.PlayerOneBallType = gameJSON.PlayerOneBallType;
      this.PlayerTwoBallType = gameJSON.PlayerTwoBallType;
      this.PlayerOneEightBall = gameJSON.PlayerOneEightBall;
      this.PlayerTwoEightBall = gameJSON.PlayerTwoEightBall;
      this.PlayerOneWon = gameJSON.PlayerOneWon;
      this.PlayerTwoWon = gameJSON.PlayerTwoWon;
      this.Ended = gameJSON.Ended;
      this.SolidBallsHitIn = gameJSON.SolidBallsHitIn;
      this.StripedBallsHitIn = gameJSON.StripedBallsHitIn;
      this.LastBallHitIn = gameJSON.LastBallHitIn;
      this.OnBreak = gameJSON.OnBreak;
      return this.BreakingPlayerStillHitting = gameJSON.BreakingPlayerStillHitting;
    };
  };

}).call(this);
