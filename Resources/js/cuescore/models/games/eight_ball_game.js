// Generated by CoffeeScript 1.3.1
(function() {
  var EightBall,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  EightBall = (function(_super) {
    var getCurrentPlayerRemainingTimeouts;

    __extends(EightBall, _super);

    EightBall.name = 'EightBall';

    function EightBall() {
      return EightBall.__super__.constructor.apply(this, arguments);
    }

    EightBall.prototype.defaults = {
      stripes: 1,
      solids: 2,
      innings: 0,
      match_ended_callback: {},
      number_of_innings: 0,
      ended: false,
      balls_hit_in: {
        stripes: [],
        solids: []
      },
      last_ball_hit_in: null,
      on_break: true,
      breaking_player_still_shooting: true,
      scratch_on_eight: false,
      early_eight: false,
      player: [
        {
          one: {
            eight_ball: null,
            eight_on_snap: false,
            break_and_run: false,
            timeouts_taken: 0,
            timeouts_allowed: null,
            callback: typeof addToPlayerOne !== "undefined" && addToPlayerOne !== null,
            ball_type: null,
            has_won: false,
            currently_up: false,
            score: []
          },
          two: {
            eight_ball: null,
            eight_on_snap: false,
            break_and_run: false,
            timeouts_taken: 0,
            timeouts_allowed: null,
            callback: typeof addToPlayerOne !== "undefined" && addToPlayerOne !== null,
            ball_type: null,
            has_won: false,
            currently_up: false,
            score: []
          }
        }
      ]
    };

    EightBall.prototype.initialize = function(addToPlayerOne, addToPlayerTwo, callback) {
      return this.match_ended_callback = callback != null;
    };

    EightBall.prototype.getCurrentlyUpPlayer = function() {
      if (this.player['one'].callback().isCurrentlyUp === true) {
        return this.player['one'].callback();
      }
      return this.player['two'].callback();
    };

    EightBall.prototype.getWinningPlayerName = function() {
      if (this.player['one'].has_won === true) {
        return this.player['one'].callback().getFirstNameWithInitials();
      } else {
        if (this.player['two'].has_won === true) {
          return this.player['two'].callback().getFirstNameWithInitials();
        }
      }
    };

    EightBall.prototype.getBallsHitInByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player['one'].ball_type === this.stripes) {
          return this.balls_hit_in.stripes.concat(this.player['one'].eight_ball);
        } else {
          if (this.player['one'].ball_type === this.solids) {
            return this.balls_hit_in.solids.concat(this.player['one'].eight_ball);
          }
        }
        [];
      }
      if (playerNum === 2) {
        if (this.player['two'].ball_type === this.stripes) {
          return this.balls_hit_in.stripes.concat(this.player['two'].eight_ball);
        } else {
          if (this.player['two'].ball_type === this.solids) {
            return this.balls_hit_in.solids.concat(this.player['two'].eight_ball);
          }
        }
        return [];
      }
    };

    EightBall.prototype.getGameScore = function() {
      return this.getBallsHitInByPlayer(1).length + "-" + this.getBallsHitInByPlayer(2).length;
    };

    EightBall.prototype.getBallsHitIn = function() {
      return this.balls_hit_in.solids.concat(this.balls_hit_in.stripes.concat(this.player['two'].eight_ball.concat(this.player['one'].eight_ball)));
    };

    getCurrentPlayerRemainingTimeouts = function() {
      if (this.player['one'].callback().currently_up === true) {
        return (this.player['one'].callback().timeouts_allowed - this.player['one'].timeouts_taken).toString();
      }
      return (this.player['two'].callback().timeouts_allowed - this.player['two'].timeouts_taken).toString();
    };

    EightBall.prototype.setPlayerWon = function(playerNum) {
      if (playerNum === 1) {
        this.player['one'].has_won = true;
        return this.player['one'].callback().games_won += 1;
      } else if (playerNum === 2) {
        this.player['two'].has_won = true;
        return this.player['two'].callback().games_won += 1;
      }
    };

    EightBall.prototype.setEightOnSnapByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player['one'].eight_on_snap !== true) {
          this.player['one'].callback().addToEightOnSnaps(1);
        }
        return this.player['one'].eight_on_snap = true;
      } else if (playerNum === 2) {
        if (this.player['two'].eight_on_snap !== true) {
          this.player['two'].callback().addToEightOnSnaps(1);
        }
        return this.player['two'].eight_on_snap = true;
      }
    };

    EightBall.prototype.setBreakAndRunByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player['one'].break_and_run !== true) {
          this.player['one'].callback().addOneToBreakAndRuns();
        }
        return this.player['one'].break_and_run = true;
      } else if (playerNum === 2) {
        if (this.player['two'].break_and_run !== true) {
          this.player['two'].callback().addOneToBreakAndRuns();
        }
        return this.player['two'].break_and_run = true;
      }
    };

    EightBall.prototype.setBallTypeByPlayer = function(playerNum, type) {
      if (playerNum === 1 && type === "stripes") {
        this.player['one'].ball_type = this.stripes;
        this.player['two'].ball_type = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "stripes") {
        this.player['two'].ball_type = this.stripes;
        this.player['one'].ball_type = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 1 && type === "solids") {
        this.player['one'].ball_type = this.solids;
        this.player['two'].ball_type = this.stripes;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "solids") {
        this.player['two'].ball_type = this.solids;
        this.player['one'].ball_type = this.stripes;
        return this.checkForWinner();
      }
    };

    EightBall.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    EightBall.prototype.hitSafety = function() {
      this.getCurrentlyUpPlayer().addOneToSafeties();
      return this.nextPlayerIsUp();
    };

    EightBall.prototype.hitScratchOnEight = function() {
      this.scratch_on_eight = true;
      this.ended = true;
      if (this.player['one'].callback().currently_up === true) {
        this.player['two'].has_won = true;
        this.player['one'].callback().currently_up = false;
        this.player['two'].callback().currently_up = true;
      } else {
        this.player['one'].has_won = true;
        this.player['two'].callback().currently_up = false;
        this.player['one'].callback().currently_up = true;
      }
      return this.match_ended_callback();
    };

    EightBall.prototype.addToNumberOfInnings = function(num) {
      return this.number_of_innings += num;
    };

    EightBall.prototype.takeTimeout = function() {
      if (this.getCurrentPlayerRemainingTimeouts() > 0) {
        if (this.player['one'].callback().currently_up === true) {
          return this.player['one'].timeouts_taken += 1;
        } else {
          return this.player['two'].timeouts_taken += 1;
        }
      }
    };

    EightBall.prototype.breakIsOver = function() {
      return this.on_break = false;
    };

    EightBall.prototype.game_end = function() {
      return this.ended = true;
    };

    EightBall.prototype.checkForWinner = function() {
      if (this.getBallsHitIn().exists(8)) {
        this.ended = true;
      }
      if (this.ended === true) {
        if (this.breakingPlayerStillHitting === true && (this.solidBallsHitIn.length === 7 || this.stripedBallsHitIn.length === 7)) {
          if (this.player['one'].callback().currently_up === true) {
            this.setBreakAndRunByPlayer(1);
            if (this.balls_hit_in.solids.length === 7) {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            } else {
              this.player['one'].ball_type = this.stripes;
              this.player['two'].ball_type = this.solids;
            }
          } else if (this.player['two'].callback().currently_up === true) {
            this.setBreakAndRunByPlayer(2);
            if (this.balls_hit_in.solids.length === 7) {
              this.player['two'].ball_type = this.solids;
              this.player['one'].ball_type = this.stripes;
            } else {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            }
          }
        }
        if (this.player['one'].eightBall.exists(8) && this.on_break === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8) {
            this.setPlayerWon(2);
          } else {
            this.setPlayerWon(1);
          }
        } else if (this.player['two'].eightBall.exists(8) && this.on_break === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8) {
            this.setPlayerWon(1);
          } else {
            this.setPlayerWon(2);
          }
        } else {
          if (this.player['one'].callback().currently_up === true) {
            this.setPlayerWon(1);
          } else {
            if (this.player['two'].callback().currently_up === true) {
              this.setPlayerWon(2);
            }
          }
        }
        return this.match_ended_callback();
      }
    };

    EightBall.prototype.scoreBall = function(ballNumber) {
      if (!this.getBallsHitIn().exists(ballNumber)) {
        this.last_ball_hit_in = ballNumber;
        if (ballNumber > 0 && ballNumber < 8) {
          this.balls_hit_in.solids.push(ballNumber);
        } else if (ballNumber > 8 && ballNumber < 16) {
          this.balls_hit_in.stripes.push(ballNumber);
        } else {
          if (this.player['one'].callback().currently_up === true) {
            this.player['one'].eight_ball.push(ballNumber);
          } else {
            if (this.player['two'].callback().currently_up === true) {
              this.player['two'].eight_ball.push(ballNumber);
            }
          }
          if (this.on_break === true) {
            if (this.balls_hit_in.solids.length !== 7 && this.balls_hit_in.stripes.length !== 7) {
              if (this.player['one'].callback().currently_up === true) {
                this.setEightOnSnapByPlayer(1);
              } else {
                if (this.player['two'].callback().currently_up === true) {
                  this.setEightOnSnapByPlayer(2);
                }
              }
            }
          } else {
            if (this.balls_hit_in.solids.length !== 7 && this.balls_hit_in.stripes.length !== 7) {
              this.early_eight = true;
              if (this.player['one'].callback().currently_up === true) {
                this.player['one'].callback().currently_up = false;
                this.player['two'].callback().currently_up = true;
              } else if (this.player['two'].callback().currently_up === true) {
                this.player['one'].callback().currently_up = true;
                this.player['two'].callback().currently_up = false;
              }
            }
          }
        }
        return this.checkForWinner();
      }
    };

    EightBall.prototype.nextPlayerIsUp = function() {
      if (this.on_break !== true || ((this.player['two'].callback().currently_up === true || this.player['one'].callback().currently_up === true) && this.getBallsHitIn().length === 0)) {
        if (this.player['one'].callback().currently_up === true) {
          this.player['two'].callback().currently_up = true;
          this.player['one'].callback().currently_up = false;
          if (this.player['one'].ball_type == null) {
            if (this.balls_hit_in.solids.length > 0 && this.balls_hit_in.stripes.length === 0) {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            } else if (this.balls_hit_in.solids.length === 0 && this.balls_hit_in.stripes.length > 0) {
              this.player['one'].ball_type = this.stripes;
              this.player['two'].ball_type = this.solids;
            }
          }
        } else if (this.PlayerTwoCallback().CurrentlyUp === true) {
          this.player['two'].callback().currently_up = false;
          this.player['one'].callback().currently_up = true;
          this.addToNumberOfInnings(1);
          if (this.player['two'].ball_type == null) {
            if (this.balls_hit_in.solids.length === 0 && this.balls_hit_in.stripes.length > 0) {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            } else if (this.balls_hit_in.solids.length > 0 && this.balls_hit_in.stripes.length === 0) {
              this.player['one'].ball_type = this.stripes;
              this.player['two'].ball_type = this.solids;
            }
          }
        } else {
          this.player['one'].callback().currently_up = true;
        }
        this.breaking_player_still_shooting = false;
      }
      return this.on_break = false;
    };

    EightBall.prototype.toJSON = function() {
      return {
        PlayerOneTimeoutsTaken: this.player['one'].timeouts_taken,
        PlayerTwoTimeoutsTaken: this.player['two'].timeouts_taken,
        PlayerOneEightOnSnap: this.player['one'].eight_on_snap,
        PlayerOneBreakAndRun: this.player['one'].break_and_run,
        PlayerTwoEightOnSnap: this.player['two'].eight_on_snap,
        PlayerTwoBreakAndRun: this.player['two'].break_and_run,
        PlayerOneBallType: this.player['one'].ball_type,
        PlayerTwoBallType: this.player['two'].ball_type,
        PlayerOneEightBall: this.player['one'].eight_ball,
        PlayerTwoEightBall: this.player['two'].eight_ball,
        PlayerOneWon: this.player['one'].has_won,
        PlayerTwoWon: this.player['two'].has_won,
        NumberOfInnings: this.number_of_innings,
        EarlyEight: this.early_eight,
        ScratchOnEight: this.scratch_on_eight,
        BreakingPlayerStillShooting: this.breaking_player_still_shooting,
        StripedBallsHitIn: this.balls_hit_in.stripes,
        SolidBallsHitIn: this.balls_hit_in.solids,
        LastBallHitIn: this.last_ball_hit_in,
        OnBreak: this.on_break,
        Ended: this.ended
      };
    };

    EightBall.prototype.fromJSON = function(gameJSON) {
      this.player['one'].timeouts_taken = gameJSON.PlayerOneTimeoutsTaken;
      this.player['two'].timeouts_taken = gameJSON.PlayerTwoTimeoutsTaken;
      this.player['one'].eight_on_snap = gameJSON.PlayerOneEightOnSnap;
      this.player['one'].break_and_run = gameJSON.PlayerOneBreakAndRun;
      this.player['two'].eight_on_snap = gameJSON.PlayerTwoEightOnSnap;
      this.player['two'].break_and_run = gameJSON.PlayerTwoBreakAndRun;
      this.player['one'].ball_type = gameJSON.PlayerOneBallType;
      this.player['two'].ball_type = gameJSON.PlayerTwoBallType;
      this.player['one'].eight_ball = gameJSON.PlayerOneEightBall;
      this.player['two'].eight_ball = gameJSON.PlayerTwoEightBall;
      this.player['one'].has_won = gameJSON.PlayerOneWon;
      this.player['two'].has_won = gameJSON.PlayerTwoWon;
      this.number_of_innints = gameJSON.NumberOfInnings;
      this.breaking_player_still_shooting = gameJSON.BreakingPlayerStillHitting;
      this.balls_hit_in.solids = gameJSON.SolidBallsHitIn;
      this.balls_hit_in.stripes = gameJSON.StripedBallsHitIn;
      this.last_ball_hit_in = gameJSON.LastBallHitIn;
      this.on_break = gameJSON.OnBreak;
      return this.ended = gameJSON.Ended;
    };

    return EightBall;

  })($CS.Models.Game);

  $CS.Models.Game.EightBall = EightBall;

}).call(this);