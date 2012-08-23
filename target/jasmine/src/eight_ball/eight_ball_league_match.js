// Generated by CoffeeScript 1.3.3
(function() {
  var LeagueMatch,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  LeagueMatch = (function(_super) {

    __extends(LeagueMatch, _super);

    LeagueMatch.prototype.defaults = {
      match: {
        one: null,
        two: null,
        three: null,
        four: null,
        five: null
      },
      teamNumber: "",
      homeTeamNumber: null,
      homeTeamName: null,
      homeTeamSigned: false,
      awayTeamNumber: null,
      awayTeamName: null,
      awayTeamSigned: false,
      startTime: null,
      endTime: "",
      tableType: null,
      smallJson: false,
      leagueMatchId: 0
    };

    function LeagueMatch(options) {
      var _ref, _ref1, _ref2, _ref3, _ref4, _ref5,
        _this = this;
      _.extend(this, this.defaults);
      this.homeTeamNumber = (_ref = options.homeTeamNumber) != null ? _ref : options.homeTeamNumber = null;
      this.homeTeamName = (_ref1 = options.homeTeamName) != null ? _ref1 : options.homeTeamName = null;
      this.awayTeamNumber = (_ref2 = options.awayTeamNumber) != null ? _ref2 : options.awayTeamNumber = null;
      this.awayTeamName = (_ref3 = options.awayTeamName) != null ? _ref3 : options.awayTeamName = null;
      this.startTime = (_ref4 = options.startTime) != null ? _ref4 : options.startTime = null;
      this.tableType = (_ref5 = options.tableType) != null ? _ref5 : options.tableType = null;
      this.staticId = options.staticId != null;
      this.DataService = new $CS.Utilities.DataService;
      this.DataService.saveLeagueMatch(this, function(id) {
        return _this.leagueMatchId = id;
      });
    }

    LeagueMatch.prototype.getHomeTeamScore = function() {
      var totalScore;
      totalScore = 0;
      totalScore = this.match.one.getMatchPointsByTeamNumber(this.homeTeamNumber);
      totalScore += this.match.two.getMatchPointsByTeamNumber(this.homeTeamNumber);
      totalScore += this.match.three.getMatchPointsByTeamNumber(this.homeTeamNumber);
      totalScore += this.match.four.getMatchPointsByTeamNumber(this.homeTeamNumber);
      totalScore += this.match.five.getMatchPointsByTeamNumber(this.homeTeamNumber);
      return totalScore;
    };

    LeagueMatch.prototype.getAwayTeamScore = function() {
      var totalScore;
      totalScore = this.match.one.getMatchPointsByTeamNumber(this.awayTeamNumber);
      totalScore += this.match.two.getMatchPointsByTeamNumber(this.awayTeamNumber);
      totalScore += this.match.three.getMatchPointsByTeamNumber(this.awayTeamNumber);
      totalScore += this.match.four.getMatchPointsByTeamNumber(this.awayTeamNumber);
      totalScore += this.match.five.getMatchPointsByTeamNumber(this.awayTeamNumber);
      return totalScore;
    };

    LeagueMatch.prototype.setMatch = function(matchData, matchNum) {
      var matchNumString;
      matchNumString = null;
      if (matchNum === 1) {
        matchNumString = "one";
      } else if (matchNum === 2) {
        matchNumString = "two";
      } else if (matchNum === 3) {
        matchNumString = "three";
      } else if (matchNum === 4) {
        matchNumString = "four";
      } else if (matchNum === 5) {
        matchNumString = "five";
      }
      this.match[matchNumString] = matchData;
      this.match[matchNumString].leagueMatchId = matchNum;
      if (!(this.match[matchNumString].originalId != null) || this.match[matchNumString].originalId === 0) {
        return this.DataService.saveMatch(this.match[matchNumString], function(id) {
          return this.match[matchNumString].originalId = id;
        });
      }
    };

    LeagueMatch.prototype.getMatchPointsByTeam = function(team) {
      var awayScore, homeScore, name, names, _fn, _fn1, _i, _j, _len, _len1,
        _this = this;
      if (team === "home") {
        homeScore = 0;
        names = ['one', 'two', 'three', 'four', 'five'];
        _fn = function(name) {
          name = name;
          if (_this.match[name].player.one.teamNumber = _this.homeTeamNumber) {
            return homeScore += _this.match[name].getMatchPointsByPlayer(1);
          } else {
            return homeScore += _this.match[name].getMatchPointsByPlayer(2);
          }
        };
        for (_i = 0, _len = names.length; _i < _len; _i++) {
          name = names[_i];
          _fn(name);
        }
        return homeScore;
      } else if (team === "away") {
        awayScore = 0;
        names = ['one', 'two', 'three', 'four', 'five'];
        _fn1 = function(name) {
          name = name.toString();
          if (_this.match[name].player.one.teamNumber === _this.awayTeamNumber) {
            return awayScore += _this.match[name].getMatchPointsByPlayer(1);
          } else {
            return awayScore += _this.match[name].getMatchPointsByPlayer(2);
          }
        };
        for (_j = 0, _len1 = names.length; _j < _len1; _j++) {
          name = names[_j];
          _fn1(name);
        }
        return awayScore;
      }
    };

    LeagueMatch.prototype.isHomeTeamWinning = function() {
      if (this.getMatchPointsByTeam('home') > this.getMatchPointsByTeam('away')) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.isAwayTeamWinning = function() {
      if (this.getMatchPointsByTeam('home') < this.getMatchPointsByTeam('away')) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.getWinningTeamNumber = function() {
      if (this.getMatchPointsByTeam('home') < this.getMatchPointsByTeam('away')) {
        return this.awayTeamNumber;
      }
      return this.homeTeamNumber;
    };

    LeagueMatch.prototype.toJSON = function() {
      if (this.smallJson === true) {
        return this.toSmallJSON();
      }
      return {
        match: {
          one: this.match.one.toJSON(),
          two: this.match.two.toJSON(),
          three: this.match.three.toJSON(),
          four: this.match.four.toJSON(),
          five: this.match.five.toJSON()
        },
        teamNumber: this.teamNumber,
        homeTeamNumber: this.homeTeamNumber,
        awayTeamNumber: this.awayTeamNumber,
        homeTeamName: this.homeTeamName,
        awayTeamName: this.awayTeamName,
        startTime: this.startTime,
        endTime: this.endTime,
        tableType: this.tableType,
        leagueMatchId: this.leagueMatchId
      };
    };

    LeagueMatch.prototype.fromJSON = function(jsonLeagueMatch) {
      var matchFive, matchFour, matchOne, matchThree, matchTwo;
      if (jsonLeagueMatch == null) {
        matchOne = new $CS.Models.EightBall.LeagueMatch({
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber,
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber,
          homeTeamName: jsonLeagueMatch.homeTeamName,
          awayTeamName: jsonLeagueMatch.awayTeamName,
          startTime: jsonLeagueMatch.startTime,
          tableType: jsonLeagueMatch.tableType
        });
        matchTwo = new $CS.Models.EightBall.LeagueMatch({
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber,
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber,
          homeTeamName: jsonLeagueMatch.homeTeamName,
          awayTeamName: jsonLeagueMatch.awayTeamName,
          startTime: jsonLeagueMatch.startTime,
          tableType: jsonLeagueMatch.tableType
        });
        matchThree = new $CS.Models.EightBall.LeagueMatch({
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber,
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber,
          homeTeamName: jsonLeagueMatch.homeTeamName,
          awayTeamName: jsonLeagueMatch.awayTeamName,
          startTime: jsonLeagueMatch.startTime,
          tableType: jsonLeagueMatch.tableType
        });
        matchFour = new $CS.Models.EightBall.LeagueMatch({
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber,
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber,
          homeTeamName: jsonLeagueMatch.homeTeamName,
          awayTeamName: jsonLeagueMatch.awayTeamName,
          startTime: jsonLeagueMatch.startTime,
          tableType: jsonLeagueMatch.tableType
        });
        matchFive = new $CS.Models.EightBall.LeagueMatch({
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber,
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber,
          homeTeamName: jsonLeagueMatch.homeTeamName,
          awayTeamName: jsonLeagueMatch.awayTeamName,
          startTime: jsonLeagueMatch.startTime,
          tableType: jsonLeagueMatch.tableType
        });
        matchOne.fromJSON(jsonLeagueMatch.matchOne);
        matchTwo.fromJSON(jsonLeagueMatch.matchTwo);
        matchThree.fromJSON(jsonLeagueMatch.matchThree);
        matchFour.fromJSON(jsonLeagueMatch.matchFour);
        matchFive.fromJSON(jsonLeagueMatch.matchFive);
        this.match.one = matchOne;
        this.match.two = matchTwo;
        this.match.three = matchThree;
        this.match.four = matchFour;
        this.match.five = matchFive;
        this.teamNumber = jsonLeagueMatch.teamNumber;
        this.homeTeamNumber = jsonLeagueMatch.homeTeamNumber;
        this.awayTeamNumber = jsonLeagueMatch.awayTeamNumber;
        this.startTime = jsonLeagueMatch.startTime;
        this.endTime = jsonLeagueMatch.endTime;
        this.tableType = jsonLeagueMatch.tableType;
        return this.leagueMatchId = jsonLeagueMatch.leagueMatchId;
      }
    };

    LeagueMatch.prototype.toSmallJSON = function() {
      return {
        teamNumber: this.teamNumber,
        homeTeamNumber: this.homeTeamNumber,
        awayTeamNumber: this.awayTeamNumber,
        startTime: this.startTime,
        endTime: this.endTime,
        tableType: this.tableType,
        leagueMatchId: this.leagueMatchId
      };
    };

    LeagueMatch.prototype.fromSmallJSON = function(jsonLeagueMatch) {
      this.teamNumber = jsonLeagueMatch.teamNumber;
      this.homeTeamNumber = jsonLeagueMatch.homeTeamNumber;
      this.awayTeamNumber = jsonLeagueMatch.awayTeamNumber;
      this.startTime = jsonLeagueMatch.startTime;
      this.endTime = jsonLeagueMatch.endTime;
      this.tableType = jsonLeagueMatch.tableType;
      return this.leagueMatchId = jsonLeagueMatch.leagueMatchId;
    };

    LeagueMatch.prototype.ended = function() {
      return this.match.one.ended && this.match.two.ended && this.match.three.ended && this.match.four.ended && this.match.five.ended;
    };

    return LeagueMatch;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.LeagueMatch = LeagueMatch;

}).call(this);
