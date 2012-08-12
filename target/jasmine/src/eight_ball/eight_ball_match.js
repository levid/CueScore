// Generated by CoffeeScript 1.3.1
(function() {
  var Match,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Match = (function(_super) {

    __extends(Match, _super);

    Match.name = 'Match';

    Match.prototype.defaults = {
      player: {
        one: {},
        two: {}
      },
      completed_games: [],
      ended: false,
      original_id: 0,
      league_match_id: 0,
      player_number_winning: 0,
      player_one_won: false,
      player_two_won: false,
      are_players_switching: false,
      sudden_death: false,
      forfeit: false,
      current_game: null
    };

    function Match(options) {
      var player_one_name, player_one_number, player_one_rank, player_one_team_number, player_two_name, player_two_number, player_two_rank, player_two_team_number;
      _.extend(this, this.defaults);
      player_one_name = options.playerOneName;
      player_two_name = options.playerTwoName;
      player_one_rank = options.playerOneRank;
      player_two_rank = options.playerTwoRank;
      player_one_number = options.playerOneNumber;
      player_two_number = options.playerTwoNumber;
      player_one_team_number = options.playerOneTeamNumber;
      player_two_team_number = options.playerTwoTeamNumber;
      this.player.one = new $CS.Models.EightBall.Player(options = {
        name: player_one_name,
        rank: player_one_rank,
        playerNumber: player_one_number,
        teamNumber: player_one_team_number
      });
      this.player.two = new $CS.Models.EightBall.Player(options = {
        name: player_two_name,
        rank: player_two_rank,
        playerNumber: player_two_number,
        teamNumber: player_two_team_number
      });
      if ((this.player.one.rank != null) && (this.player.two.rank != null)) {
        this.player.one.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(player_one_rank, player_two_rank);
        this.player.two.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(player_two_rank, player_one_rank);
      }
      this.current_game = this.getNewGame();
    }

    Match.prototype.getNewGame = function() {
      var options,
        _this = this;
      return new $CS.Models.EightBall.Game(options = {
        addToPlayerOne: function() {
          return _this.player.one;
        },
        addToPlayerTwo: function() {
          return _this.player.two;
        },
        callback: function() {
          if (this.getRemainingGamesNeededToWinByPlayer(1) === 0) {
            this.player_one_won = true;
            return this.ended = true;
          } else if (this.getRemainingGamesNeededToWinByPlayer(2) === 0) {
            this.player_two_won = true;
            return this.ended = true;
          }
        }
      });
    };

    Match.prototype.getTotalInnings = function() {
      var i, totalInnings;
      totalInnings = this.current_game.number_of_innings;
      if (this.completed_games.length > 0) {
        i = 0;
        while (i <= (this.completed_games.length - 1)) {
          totalInnings += this.completed_games[i].number_of_innings;
          i++;
        }
      }
      return totalInnings.toString();
    };

    Match.prototype.getTotalSafeties = function() {
      return this.player.one.getSafeties() + " to " + this.player.two.getSafeties();
    };

    Match.prototype.getCurrentGameNumber = function() {
      return (this.completed_games.length + 1).toString();
    };

    Match.prototype.getMatchPointsByTeamNumber = function(teamNumber) {
      if (this.player.one.team_number === teamNumber) {
        return this.getMatchPointsByPlayer(1);
      } else {
        if (this.player.two.team_number === teamNumber) {
          return this.getMatchPointsByPlayer(2);
        }
      }
      return 0;
    };

    Match.prototype.getWinningPlayer = function() {
      if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
        return this.player.one;
      }
      return this.player.two;
    };

    Match.prototype.getRemainingGamesNeededToWinByPlayer = function(playerNum) {
      if (playerNum === 1) {
        return (this.player.one.games_needed_to_win - this.getGamesWonByPlayer(1)).toString();
      } else if (playerNum === 2) {
        return (this.player.two.games_needed_to_win - this.getGamesWonByPlayer(2)).toString();
      }
    };

    Match.prototype.getGamesWonByPlayer = function(playerNum) {
      var gamesWon, i;
      i = 0;
      if (playerNum === 1) {
        gamesWon = (this.current_game.player['one'].has_won === true ? 1 : 0);
        while (i <= (this.completed_games.length - 1)) {
          if (this.completed_games[i].player['one'].has_won === true) {
            gamesWon = gamesWon + 1;
          }
          i++;
        }
      } else if (playerNum === 2) {
        gamesWon = (this.current_game.player['two'].has_won === true ? 1 : 0);
        while (i <= (this.CompletedGames.length - 1)) {
          if (this.CompletedGames[i].player['two'].has_won === true) {
            gamesWon = gamesWon + 1;
          }
          i++;
        }
      }
      return gamesWon;
    };

    Match.prototype.getMatchPointsByPlayer = function(playerNum) {
      if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
        return 1;
      }
      return 0;
    };

    Match.prototype.getMatchPoints = function() {
      if (this.getMatchPointsByPlayer(1) === this.getMatchPointsByPlayer(2)) {
        return "TIE";
      }
      return this.getMatchPointsByPlayer(1) + "-" + this.getMatchPointsByPlayer(2);
    };

    Match.prototype.setSuddenDeathMode = function() {
      this.sudden_death = true;
      this.player.one.games_needed_to_win = 1;
      return this.player.two.games_needed_to_win = 1;
    };

    Match.prototype.scoreNumberedBall = function(ballNumber) {
      this.are_players_switching = false;
      this.current_game.scoreBall(ballNumber);
      if (this.isPlayerWinning(1) === true) {
        this.player_number_winning = 1;
      } else {
        this.player_number_winning = 2;
      }
      return this.checkForWin();
    };

    Match.prototype.shotMissed = function() {
      this.current_game.nextPlayerIsUp();
      if (this.current_game.breaking_player_still_shooting === false) {
        return this.are_players_switching = true;
      }
    };

    Match.prototype.hitSafety = function() {
      return this.current_game.hitSafety();
    };

    Match.prototype.checkForWin = function() {};

    Match.prototype.startNewGame = function() {
      if (this.current_game.ended === true) {
        this.completed_games.push(this.current_game);
        return this.current_game = this.getNewGame();
      }
    };

    Match.prototype.resetPlayerRankStats = function() {
      this.player.one.games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(this.player.one.rank, this.player.two.rank);
      this.player.two.games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(this.player.two.rank, this.player.one.rank);
      this.player.one.resetPlayerRankStats();
      return this.player.two.resetPlayerRankStats();
    };

    Match.prototype.isPlayerWinning = function(playerNum) {
      if (playerNum === 1) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
          return true;
        }
        return false;
      } else if (playerNum === 2) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) < (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
          return true;
        }
        return false;
      }
    };

    Match.prototype.toJSON = function() {
      return {
        player_one: this.player.one.toJSON(),
        player_two: this.player.two.toJSON(),
        player_one_games_won: this.getGamesWonByPlayer(1),
        player_two_games_won: this.getGamesWonByPlayer(2),
        current_game: this.current_game.toJSON(),
        completed_games: this.completedGamesToJSON(),
        sudden_death: this.sudden_death,
        forfeit: this.forfeit,
        ended: this.ended,
        original_id: this.original_id,
        league_match_id: this.league_match_id
      };
    };

    Match.prototype.completedGamesToJSON = function() {
      var arrayToReturn, i;
      arrayToReturn = [];
      i = 0;
      while (i <= this.completed_games.length - 1) {
        arrayToReturn[i] = this.completed_games[i].toJSON();
        i++;
      }
      return arrayToReturn;
    };

    Match.prototype.fromJSON = function(json) {
      var currentGame;
      this.player.one = this.playerFromJSON(json.player_one);
      this.player.two = this.playerFromJSON(json.player_two);
      this.resetPlayerRankStats();
      this.completed_games = this.completedGamesFromJSON(json.completed_games);
      this.sudden_death = json.sudden_death;
      this.forfeit = json.forfeit;
      this.ended = json.ended;
      this.original_id = json.original_id;
      this.league_match_id = json.league_match_id;
      currentGame = this.getNewGame();
      currentGame.fromJSON(new function() {
        return json.current_game;
      });
      return this.current_game = currentGame;
    };

    Match.prototype.playerFromJSON = function(json) {
      var player;
      player = new EightBallPlayer();
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
