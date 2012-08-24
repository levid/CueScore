// Generated by CoffeeScript 1.3.3
(function() {

  describe("Nine Ball League Match", function() {
    var leagueMatch;
    leagueMatch = void 0;
    beforeEach(function() {
      var options, setUpMatchDefaults;
      leagueMatch = new $CS.Models.NineBall.LeagueMatch(options = {
        homeTeamNumber: "123",
        awayTeamNumber: "345",
        homeTeamName: "HomeTeam",
        awayTeamName: "AwayTeam",
        startTime: "10:00 pm",
        tableType: "Coin-Operated"
      });
      leagueMatch.setMatch(new $CS.Models.NineBall.Match(options = {
        playerOneName: "Player1",
        playerTwoName: "Player2",
        playerOneRank: 2,
        playerTwoRank: 2,
        playerOneNumber: "1",
        playerTwoNumber: "2",
        playerOneTeamNumber: "123",
        playerTwoTeamNumber: "345"
      }), 1);
      leagueMatch.match.one.player.one.currentlyUp = true;
      leagueMatch.setMatch(new $CS.Models.NineBall.Match(options = {
        playerOneName: "Player1",
        playerTwoName: "Player2",
        playerOneRank: 2,
        playerTwoRank: 2,
        playerOneNumber: "1",
        playerTwoNumber: "2",
        playerOneTeamNumber: "345",
        playerTwoTeamNumber: "123"
      }), 2);
      leagueMatch.match.two.player.one.currentlyUp = true;
      leagueMatch.setMatch(new $CS.Models.NineBall.Match(options = {
        playerOneName: "Player1",
        playerTwoName: "Player2",
        playerOneRank: 2,
        playerTwoRank: 2,
        playerOneNumber: "1",
        playerTwoNumber: "2",
        playerOneTeamNumber: "123",
        playerTwoTeamNumber: "345"
      }), 3);
      leagueMatch.match.three.player.one.currentlyUp = true;
      leagueMatch.setMatch(new $CS.Models.NineBall.Match(options = {
        playerOneName: "Player1",
        playerTwoName: "Player2",
        playerOneRank: 2,
        playerTwoRank: 2,
        playerOneNumber: "1",
        playerTwoNumber: "2",
        playerOneTeamNumber: "345",
        playerTwoTeamNumber: "123"
      }), 4);
      leagueMatch.match.four.player.one.currentlyUp = true;
      leagueMatch.setMatch(new $CS.Models.NineBall.Match(options = {
        playerOneName: "Player1",
        playerTwoName: "Player2",
        playerOneRank: 2,
        playerTwoRank: 2,
        playerOneNumber: "1",
        playerTwoNumber: "2",
        playerOneTeamNumber: "123",
        playerTwoTeamNumber: "345"
      }), 5);
      leagueMatch.match.five.player.one.currentlyUp = true;
      setUpMatchDefaults = function(matchNum) {
        leagueMatch.match[matchNum].player.one.currentlyUp = true;
        leagueMatch.match[matchNum].completedGames = [];
        leagueMatch.match[matchNum].ended = false;
        leagueMatch.match[matchNum].originalId = 0;
        leagueMatch.match[matchNum].leagueMatchId = 0;
        leagueMatch.match[matchNum].playerNumberWinning = 0;
        leagueMatch.match[matchNum].suddenDeath = false;
        leagueMatch.match[matchNum].forfeit = false;
        leagueMatch.match[matchNum].currentGame.player.one.score = 0;
        leagueMatch.match[matchNum].currentGame.player.one.nineOnSnap = false;
        leagueMatch.match[matchNum].currentGame.player.one.breakAndRun = false;
        leagueMatch.match[matchNum].currentGame.player.one.ballsHitIn = [];
        leagueMatch.match[matchNum].currentGame.player.one.deadBalls = [];
        leagueMatch.match[matchNum].currentGame.player.one.lastBall = null;
        leagueMatch.match[matchNum].currentGame.player.one.timeoutsTaken = 0;
        leagueMatch.match[matchNum].currentGame.player.two.score = 0;
        leagueMatch.match[matchNum].currentGame.player.two.nineOnSnap = false;
        leagueMatch.match[matchNum].currentGame.player.two.breakAndRun = false;
        leagueMatch.match[matchNum].currentGame.player.two.ballsHitIn = [];
        leagueMatch.match[matchNum].currentGame.player.two.deadBalls = [];
        leagueMatch.match[matchNum].currentGame.player.two.lastBall = null;
        leagueMatch.match[matchNum].currentGame.player.two.timeoutsTaken = 0;
        leagueMatch.match[matchNum].currentGame.numberOfInnings = 0;
        leagueMatch.match[matchNum].currentGame.ended = false;
        leagueMatch.match[matchNum].currentGame.onBreak = true;
        return leagueMatch.match[matchNum].currentGame.breakingPlayerStillShooting = true;
      };
      setUpMatchDefaults('one');
      setUpMatchDefaults('two');
      setUpMatchDefaults('three');
      setUpMatchDefaults('four');
      return setUpMatchDefaults('five');
    });
    it("should have homeTeamNumber, awayTeamNumber, startTime, and tableType initialized from constructor", function() {
      expect(leagueMatch.homeTeamNumber).toEqual("123");
      expect(leagueMatch.awayTeamNumber).toEqual("345");
      expect(leagueMatch.startTime).toEqual("10:00 pm");
      return expect(leagueMatch.tableType).toEqual("Coin-Operated");
    });
    it("should hold 5 different games", function() {
      expect(leagueMatch.match.one).toNotEqual(null);
      expect(leagueMatch.match.two).toNotEqual(null);
      expect(leagueMatch.match.three).toNotEqual(null);
      expect(leagueMatch.match.four).toNotEqual(null);
      return expect(leagueMatch.match.five).toNotEqual(null);
    });
    it("should hold a home and away team numbers", function() {
      expect(leagueMatch.homeTeamNumber).toEqual("123");
      return expect(leagueMatch.awayTeamNumber).toEqual("345");
    });
    it("should keep scorecard team owners number", function() {
      return expect(leagueMatch.teamNumber).toEqual("");
    });
    it("should have the Start Time and End Time", function() {
      return expect(leagueMatch.endTime).toEqual("");
    });
    it("should be able to calculate home and away teams scores", function() {
      leagueMatch.match.one.scoreNumberedBall(1);
      leagueMatch.match.one.scoreNumberedBall(2);
      leagueMatch.match.one.scoreNumberedBall(3);
      leagueMatch.match.one.scoreNumberedBall(4);
      expect(leagueMatch.getMatchPointsByTeam('home')).toEqual(20);
      expect(leagueMatch.getMatchPointsByTeam('away')).toEqual(0);
      leagueMatch.match.two.scoreNumberedBall(1);
      leagueMatch.match.two.scoreNumberedBall(2);
      leagueMatch.match.two.scoreNumberedBall(3);
      leagueMatch.match.two.shotMissed();
      leagueMatch.match.two.scoreNumberedBall(4);
      leagueMatch.match.two.scoreNumberedBall(5);
      leagueMatch.match.two.scoreNumberedBall(6);
      leagueMatch.match.two.scoreNumberedBall(7);
      leagueMatch.match.three.scoreNumberedBall(1);
      leagueMatch.match.three.scoreNumberedBall(2);
      leagueMatch.match.three.scoreNumberedBall(3);
      leagueMatch.match.three.shotMissed();
      leagueMatch.match.three.scoreNumberedBall(4);
      leagueMatch.match.three.scoreNumberedBall(5);
      leagueMatch.match.three.scoreNumberedBall(6);
      leagueMatch.match.three.scoreNumberedBall(7);
      leagueMatch.match.four.scoreNumberedBall(1);
      leagueMatch.match.four.scoreNumberedBall(2);
      leagueMatch.match.four.scoreNumberedBall(3);
      leagueMatch.match.four.scoreNumberedBall(4);
      leagueMatch.match.four.shotMissed();
      leagueMatch.match.four.scoreNumberedBall(4);
      leagueMatch.match.four.scoreNumberedBall(5);
      leagueMatch.match.four.scoreNumberedBall(6);
      leagueMatch.match.four.scoreNumberedBall(9);
      leagueMatch.match.five.scoreNumberedBall(1);
      leagueMatch.match.five.scoreNumberedBall(2);
      leagueMatch.match.five.scoreNumberedBall(3);
      leagueMatch.match.five.scoreNumberedBall(4);
      leagueMatch.match.five.shotMissed();
      leagueMatch.match.five.scoreNumberedBall(4);
      leagueMatch.match.five.scoreNumberedBall(5);
      leagueMatch.match.five.scoreNumberedBall(6);
      leagueMatch.match.five.scoreNumberedBall(9);
      expect(leagueMatch.getMatchPointsByTeam('home')).toEqual(60);
      return expect(leagueMatch.getMatchPointsByTeam('away')).toEqual(40);
    });
    it("should know which team is winning the match", function() {
      leagueMatch.match.one.scoreNumberedBall(1);
      leagueMatch.match.one.scoreNumberedBall(2);
      leagueMatch.match.one.scoreNumberedBall(3);
      leagueMatch.match.one.scoreNumberedBall(4);
      expect(leagueMatch.isHomeTeamWinning()).toEqual(true);
      expect(leagueMatch.isAwayTeamWinning()).toEqual(false);
      leagueMatch.match.two.scoreNumberedBall(1);
      leagueMatch.match.two.scoreNumberedBall(2);
      leagueMatch.match.two.scoreNumberedBall(3);
      leagueMatch.match.two.shotMissed();
      leagueMatch.match.two.scoreNumberedBall(4);
      leagueMatch.match.two.scoreNumberedBall(5);
      leagueMatch.match.two.scoreNumberedBall(6);
      leagueMatch.match.two.scoreNumberedBall(7);
      leagueMatch.match.three.shotMissed();
      leagueMatch.match.three.scoreNumberedBall(1);
      leagueMatch.match.three.scoreNumberedBall(2);
      leagueMatch.match.three.scoreNumberedBall(3);
      leagueMatch.match.three.scoreNumberedBall(4);
      leagueMatch.match.three.scoreNumberedBall(5);
      leagueMatch.match.three.scoreNumberedBall(6);
      leagueMatch.match.three.scoreNumberedBall(7);
      leagueMatch.match.four.shotMissed();
      leagueMatch.match.four.scoreNumberedBall(1);
      leagueMatch.match.four.scoreNumberedBall(2);
      leagueMatch.match.four.scoreNumberedBall(3);
      leagueMatch.match.four.scoreNumberedBall(4);
      leagueMatch.match.four.scoreNumberedBall(4);
      leagueMatch.match.four.scoreNumberedBall(5);
      leagueMatch.match.four.scoreNumberedBall(6);
      leagueMatch.match.four.scoreNumberedBall(9);
      leagueMatch.match.five.shotMissed();
      leagueMatch.match.five.scoreNumberedBall(1);
      leagueMatch.match.five.scoreNumberedBall(2);
      leagueMatch.match.five.scoreNumberedBall(3);
      leagueMatch.match.five.scoreNumberedBall(4);
      leagueMatch.match.five.scoreNumberedBall(4);
      leagueMatch.match.five.scoreNumberedBall(5);
      leagueMatch.match.five.scoreNumberedBall(6);
      leagueMatch.match.five.scoreNumberedBall(9);
      expect(leagueMatch.isHomeTeamWinning()).toEqual(false);
      return expect(leagueMatch.isAwayTeamWinning()).toEqual(true);
    });
    it("should be able to get the winning teams number", function() {
      leagueMatch.match.one.scoreNumberedBall(1);
      leagueMatch.match.one.scoreNumberedBall(2);
      leagueMatch.match.one.scoreNumberedBall(3);
      leagueMatch.match.one.scoreNumberedBall(4);
      expect(leagueMatch.getWinningTeamNumber()).toEqual("123");
      leagueMatch.match.two.scoreNumberedBall(1);
      leagueMatch.match.two.scoreNumberedBall(2);
      leagueMatch.match.two.scoreNumberedBall(3);
      leagueMatch.match.two.shotMissed();
      leagueMatch.match.two.scoreNumberedBall(4);
      leagueMatch.match.two.scoreNumberedBall(5);
      leagueMatch.match.two.scoreNumberedBall(6);
      leagueMatch.match.two.scoreNumberedBall(7);
      leagueMatch.match.three.shotMissed();
      leagueMatch.match.three.scoreNumberedBall(1);
      leagueMatch.match.three.scoreNumberedBall(2);
      leagueMatch.match.three.scoreNumberedBall(3);
      leagueMatch.match.three.scoreNumberedBall(4);
      leagueMatch.match.three.scoreNumberedBall(5);
      leagueMatch.match.three.scoreNumberedBall(6);
      leagueMatch.match.three.scoreNumberedBall(7);
      leagueMatch.match.four.shotMissed();
      leagueMatch.match.four.scoreNumberedBall(1);
      leagueMatch.match.four.scoreNumberedBall(2);
      leagueMatch.match.four.scoreNumberedBall(3);
      leagueMatch.match.four.scoreNumberedBall(4);
      leagueMatch.match.four.scoreNumberedBall(4);
      leagueMatch.match.four.scoreNumberedBall(5);
      leagueMatch.match.four.scoreNumberedBall(6);
      leagueMatch.match.four.scoreNumberedBall(9);
      leagueMatch.match.five.shotMissed();
      leagueMatch.match.five.scoreNumberedBall(1);
      leagueMatch.match.five.scoreNumberedBall(2);
      leagueMatch.match.five.scoreNumberedBall(3);
      leagueMatch.match.five.scoreNumberedBall(4);
      leagueMatch.match.five.scoreNumberedBall(4);
      leagueMatch.match.five.scoreNumberedBall(5);
      leagueMatch.match.five.scoreNumberedBall(6);
      leagueMatch.match.five.scoreNumberedBall(9);
      return expect(leagueMatch.getWinningTeamNumber()).toEqual("345");
    });
    it("should be able to set each match and set the leagueMatchId for each", function() {
      expect(leagueMatch.match.one.leagueMatchId).toEqual(1);
      expect(leagueMatch.match.two.leagueMatchId).toEqual(1);
      expect(leagueMatch.match.three.leagueMatchId).toEqual(1);
      expect(leagueMatch.match.four.leagueMatchId).toEqual(1);
      return expect(leagueMatch.match.five.leagueMatchId).toEqual(1);
    });
    it("should be able to keep team names", function() {
      expect(leagueMatch.homeTeamName).toEqual("HomeTeam");
      return expect(leagueMatch.awayTeamName).toEqual("AwayTeam");
    });
    it("should be able to tell which team has signed the match", function() {
      expect(leagueMatch.homeTeamSigned).toEqual(false);
      expect(leagueMatch.awayTeamSigned).toEqual(false);
      leagueMatch.homeTeamSigned = true;
      leagueMatch.awayTeamSigned = true;
      expect(leagueMatch.homeTeamSigned).toEqual(true);
      return expect(leagueMatch.awayTeamSigned).toEqual(true);
    });
    it("should know when all of the matches have ended and the league match is complete", function() {
      leagueMatch.match.one.ended = true;
      leagueMatch.match.two.ended = true;
      leagueMatch.match.three.ended = true;
      leagueMatch.match.four.ended = true;
      leagueMatch.match.five.ended = true;
      return expect(leagueMatch.ended()).toEqual(true);
    });
    return describe("toJSON/fromJSON", function() {
      it("should be able to take a new League Match and turn it into a JSON object", function() {
        return expect(leagueMatch.toJSON()).toEqual({
          match: {
            one: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                BallCount: "14",
                number: "1",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                BallCount: "14",
                number: "2",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: false
              },
              PlayerOneMatchPointsEarned: 0,
              PlayerTwoMatchPointsEarned: 0,
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                PlayerOneTimeoutsTaken: 0,
                PlayerTwoTimeoutsTaken: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            two: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                BallCount: "14",
                number: "1",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                BallCount: "14",
                number: "2",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: false
              },
              PlayerOneMatchPointsEarned: 0,
              PlayerTwoMatchPointsEarned: 0,
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                PlayerOneTimeoutsTaken: 0,
                PlayerTwoTimeoutsTaken: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            three: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                BallCount: "14",
                number: "1",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                BallCount: "14",
                number: "2",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: false
              },
              PlayerOneMatchPointsEarned: 0,
              PlayerTwoMatchPointsEarned: 0,
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                PlayerOneTimeoutsTaken: 0,
                PlayerTwoTimeoutsTaken: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            four: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                BallCount: "14",
                number: "1",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                BallCount: "14",
                number: "2",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: false
              },
              PlayerOneMatchPointsEarned: 0,
              PlayerTwoMatchPointsEarned: 0,
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                PlayerOneTimeoutsTaken: 0,
                PlayerTwoTimeoutsTaken: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            five: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                BallCount: "14",
                number: "1",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                BallCount: "14",
                number: "2",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                currentlyUp: false
              },
              PlayerOneMatchPointsEarned: 0,
              PlayerTwoMatchPointsEarned: 0,
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                PlayerOneTimeoutsTaken: 0,
                PlayerTwoTimeoutsTaken: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            }
          },
          teamNumber: "",
          homeTeamNumber: "123",
          awayTeamNumber: "345",
          startTime: "10:00 pm",
          endTime: "",
          tableType: "Coin-Operated",
          leagueMatchId: 1
        });
      });
      it("should be able to take a new League Match and turn it into a small JSON object", function() {
        return expect(leagueMatch.toSmallJSON()).toEqual({
          teamNumber: "",
          homeTeamNumber: "123",
          awayTeamNumber: "345",
          startTime: "10:00 pm",
          endTime: "",
          tableType: "Coin-Operated",
          leagueMatchId: 1
        });
      });
      it("should be able to set SmallJSON = true to return only the small JSON object when toJSON is called.", function() {
        leagueMatch.SmallJSON = true;
        return expect(leagueMatch.toJSON()).toEqual({
          teamNumber: "",
          homeTeamNumber: "123",
          awayTeamNumber: "345",
          startTime: "10:00 pm",
          endTime: "",
          tableType: "Coin-Operated",
          leagueMatchId: 1
        });
      });
      it("should be able to take a json object and fill its own values", function() {
        var options;
        leagueMatch = new $CS.Models.NineBall.LeagueMatch(options = {
          homeTeamNumber: "123",
          awayTeamNumber: "345",
          homeTeamName: "HomeTeam",
          awayTeamName: "AwayTeam",
          startTime: "10:00 pm",
          tableType: "Coin-Operated"
        });
        leagueMatch.fromJSON({
          match: {
            one: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                number: "1",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                number: "2",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: false
              },
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            two: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                number: "1",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: false
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                number: "2",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: true
              },
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            three: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                number: "1",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                number: "2",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: false
              },
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            four: {
              PlayerOne: {
                name: "PlayerOne",
                rank: 1,
                number: "1",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                number: "2",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: false
              },
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            },
            five: {
              PlayerOne: {
                name: "TestPlayer",
                rank: 1,
                number: "1",
                teamNumber: "345",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: true
              },
              PlayerTwo: {
                name: "Player2",
                rank: 1,
                number: "2",
                teamNumber: "123",
                score: 0,
                safeties: 0,
                nineOnSnaps: 0,
                breakAndRuns: 0,
                timeoutsTaken: 0,
                currentlyUp: false
              },
              currentGame: {
                PlayerOneScore: 0,
                PlayerTwoScore: 0,
                NumberOfInnings: 0,
                PlayerOneNineOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoNineOnSnap: false,
                PlayerTwoBreakAndRun: false,
                ended: false,
                PlayerOneBallsHitIn: [],
                PlayerTwoBallsHitIn: [],
                PlayerOneDeadBalls: [],
                PlayerTwoDeadBalls: [],
                PlayerOneLastBall: null,
                PlayerTwoLastBall: null,
                OnBreak: true,
                BreakingPlayerStillHitting: true
              },
              completedGames: [],
              ended: false,
              originalId: 0,
              leagueMatchId: 1
            }
          },
          teamNumber: "",
          homeTeamNumber: "123",
          awayTeamNumber: "345",
          startTime: "10:00 pm",
          endTime: "",
          tableType: "Coin-Operated",
          leagueMatchId: null
        });
        expect(leagueMatch.teamNumber).toEqual("");
        expect(leagueMatch.homeTeamNumber).toEqual("123");
        expect(leagueMatch.awayTeamNumber).toEqual("345");
        expect(leagueMatch.startTime).toEqual("10:00 pm");
        expect(leagueMatch.endTime).toEqual("");
        expect(leagueMatch.tableType).toEqual("Coin-Operated");
        expect(leagueMatch.leagueMatchId).toEqual(null);
        expect(leagueMatch.match.five.PlayerOne.name).toEqual("TestPlayer");
        leagueMatch.match.five.scoreNumberedBall(9);
        expect(leagueMatch.match.five.currentGame.getBallsScored()).toEqual([9]);
        leagueMatch.match.five.startNewGame();
        expect(leagueMatch.match.five.currentGame.getBallsScored()).toEqual([]);
        return expect(leagueMatch.match.five.completedGames.length).toEqual(1);
      });
      return it("should be able to take a small json object and fill its own values", function() {
        var options;
        leagueMatch = new $CS.Models.NineBall.LeagueMatch(options = {
          homeTeamNumber: "123",
          awayTeamNumber: "345",
          homeTeamName: "HomeTeam",
          awayTeamName: "AwayTeam",
          startTime: "10:00 pm",
          tableType: "Coin-Operated"
        });
        leagueMatch.fromSmallJSON({
          teamNumber: "",
          homeTeamNumber: "123",
          awayTeamNumber: "345",
          startTime: "10:00 pm",
          endTime: "",
          tableType: "Coin-Operated",
          leagueMatchId: null
        });
        expect(leagueMatch.teamNumber).toEqual("");
        expect(leagueMatch.homeTeamNumber).toEqual("123");
        expect(leagueMatch.awayTeamNumber).toEqual("345");
        expect(leagueMatch.startTime).toEqual("10:00 pm");
        expect(leagueMatch.endTime).toEqual("");
        expect(leagueMatch.tableType).toEqual("Coin-Operated");
        return expect(leagueMatch.leagueMatchId).toEqual(null);
      });
    });
  });

}).call(this);
