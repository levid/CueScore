// Generated by CoffeeScript 1.3.1
(function() {
  var LeagueMatch,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  LeagueMatch = (function(_super) {

    __extends(LeagueMatch, _super);

    LeagueMatch.name = 'LeagueMatch';

    LeagueMatch.prototype.defaults = {};

    function LeagueMatch(HomeTeamNumber, AwayTeamNumber, HomeTeamName, AwayTeamName, StartTime, TableType) {
      var me;
      _.extend(this, this.defaults);
      this.GameType = "NineBall";
      this.MatchOne = null;
      this.MatchTwo = null;
      this.MatchThree = null;
      this.MatchFour = null;
      this.MatchFive = null;
      this.TeamNumber = "";
      this.HomeTeamNumber = HomeTeamNumber;
      this.AwayTeamNumber = AwayTeamNumber;
      this.HomeTeamName = HomeTeamName;
      this.AwayTeamName = AwayTeamName;
      this.HomeTeamSigned = false;
      this.AwayTeamSigned = false;
      this.StartTime = StartTime;
      this.EndTime = "";
      this.TableType = TableType;
      this.SmallJSON = false;
      this.LeagueMatchId = 0;
      me = this;
      DataService.saveLeagueMatch(this, function(id) {
        return me.LeagueMatchId = id;
      });
    }

    LeagueMatch.prototype.getHomeTeamMatchPoints = function() {
      var totalScore;
      totalScore = 0;
      totalScore = this.MatchOne.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchTwo.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchThree.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchFour.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchFive.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      return totalScore;
    };

    LeagueMatch.prototype.getAwayTeamMatchPoints = function() {
      var totalScore;
      totalScore = this.MatchOne.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchTwo.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchThree.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchFour.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchFive.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      return totalScore;
    };

    LeagueMatch.prototype.isHomeTeamWinning = function() {
      if (this.getHomeTeamMatchPoints() > this.getAwayTeamMatchPoints()) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.isAwayTeamWinning = function() {
      if (this.getHomeTeamMatchPoints() < this.getAwayTeamMatchPoints()) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.getWinningTeamNumber = function() {
      if (this.getHomeTeamMatchPoints() < this.getAwayTeamMatchPoints()) {
        return this.AwayTeamNumber;
      }
      return this.HomeTeamNumber;
    };

    LeagueMatch.prototype.setMatchOne = function(match) {
      this.MatchOne = match;
      this.MatchOne.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchOne.OriginalId != null) || this.MatchOne.OriginalId === 0) {
        return DataService.saveMatch(this.MatchOne, function(id) {
          return me.MatchOne.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchTwo = function(match) {
      this.MatchTwo = match;
      this.MatchTwo.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchTwo.OriginalId != null) || this.MatchTwo.OriginalId === 0) {
        return DataService.saveMatch(this.MatchTwo, function(id) {
          return me.MatchTwo.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchThree = function(match) {
      this.MatchThree = match;
      this.MatchThree.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchThree.OriginalId != null) || this.MatchThree.OriginalId === 0) {
        return DataService.saveMatch(this.MatchThree, function(id) {
          return me.MatchThree.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchFour = function(match) {
      this.MatchFour = match;
      this.MatchFour.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchFour.OriginalId != null) || this.MatchFour.OriginalId === 0) {
        return DataService.saveMatch(this.MatchFour, function(id) {
          return me.MatchFour.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchFive = function(match) {
      this.MatchFive = match;
      this.MatchFive.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchFive.OriginalId != null) || this.MatchFive.OriginalId === 0) {
        return DataService.saveMatch(this.MatchFive, function(id) {
          return me.MatchFive.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.toJSON = function() {
      if (this.SmallJSON === true) {
        return this.toSmallJSON();
      }
      return {
        MatchOne: this.MatchOne.toJSON(),
        MatchTwo: this.MatchTwo.toJSON(),
        MatchThree: this.MatchThree.toJSON(),
        MatchFour: this.MatchFour.toJSON(),
        MatchFive: this.MatchFive.toJSON(),
        TeamNumber: this.TeamNumber,
        HomeTeamNumber: this.HomeTeamNumber,
        AwayTeamNumber: this.AwayTeamNumber,
        StartTime: this.StartTime,
        EndTime: this.EndTime,
        TableType: this.TableType,
        LeagueMatchId: this.LeagueMatchId
      };
    };

    LeagueMatch.prototype.toSmallJSON = function() {
      return {
        TeamNumber: this.TeamNumber,
        HomeTeamNumber: this.HomeTeamNumber,
        AwayTeamNumber: this.AwayTeamNumber,
        StartTime: this.StartTime,
        EndTime: this.EndTime,
        TableType: this.TableType,
        LeagueMatchId: this.LeagueMatchId
      };
    };

    LeagueMatch.prototype.fromJSON = function(jsonLeagueMatch) {
      var matchFive, matchFour, matchOne, matchThree, matchTwo;
      matchOne = new NineBallMatch();
      matchOne.fromJSON(jsonLeagueMatch.MatchOne);
      matchTwo = new NineBallMatch();
      matchTwo.fromJSON(jsonLeagueMatch.MatchTwo);
      matchThree = new NineBallMatch();
      matchThree.fromJSON(jsonLeagueMatch.MatchThree);
      matchFour = new NineBallMatch();
      matchFour.fromJSON(jsonLeagueMatch.MatchFour);
      matchFive = new NineBallMatch();
      matchFive.fromJSON(jsonLeagueMatch.MatchFive);
      this.MatchOne = matchOne;
      this.MatchTwo = matchTwo;
      this.MatchThree = matchThree;
      this.MatchFour = matchFour;
      this.MatchFive = matchFive;
      this.TeamNumber = jsonLeagueMatch.TeamNumber;
      this.HomeTeamNumber = jsonLeagueMatch.HomeTeamNumber;
      this.AwayTeamNumber = jsonLeagueMatch.AwayTeamNumber;
      this.StartTime = jsonLeagueMatch.StartTime;
      this.EndTime = jsonLeagueMatch.EndTime;
      this.TableType = jsonLeagueMatch.TableType;
      return this.LeagueMatchId = jsonLeagueMatch.LeagueMatchId;
    };

    LeagueMatch.prototype.fromSmallJSON = function(jsonLeagueMatch) {
      this.TeamNumber = jsonLeagueMatch.TeamNumber;
      this.HomeTeamNumber = jsonLeagueMatch.HomeTeamNumber;
      this.AwayTeamNumber = jsonLeagueMatch.AwayTeamNumber;
      this.StartTime = jsonLeagueMatch.StartTime;
      this.EndTime = jsonLeagueMatch.EndTime;
      this.TableType = jsonLeagueMatch.TableType;
      return this.LeagueMatchId = jsonLeagueMatch.LeagueMatchId;
    };

    LeagueMatch.prototype.Ended = function() {
      return this.MatchOne.Ended && this.MatchTwo.Ended && this.MatchThree.Ended && this.MatchFour.Ended && this.MatchFive.Ended;
    };

    return LeagueMatch;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.LeagueMatch = LeagueMatch;

}).call(this);
