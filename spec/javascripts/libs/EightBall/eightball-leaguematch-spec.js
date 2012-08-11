/**
* @author jamesa
*/

//Mock out DataService
var DataService = {
	saveMatch: function(a){},
	saveLeagueMatch: function(a,b) { b(1);}
};

describe('EightBall LeagueMatch', function () {
	var leagueMatch;
	beforeEach(function() {
	    leagueMatch = new EightBallLeagueMatch("123","345","HomeTeam","AwayTeam","10:00 pm", "Coin-Operated");
		leagueMatch.setMatchOne(new EightBallMatch("PlayerOne","Player2",2,2,"1","2","123","345"));
		leagueMatch.MatchOne.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchTwo(new EightBallMatch("PlayerOne","Player2",2,2,"1","2","345","123"));
		leagueMatch.MatchTwo.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchThree(new EightBallMatch("PlayerOne","Player2",2,2,"1","2","123","345"));
		leagueMatch.MatchThree.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchFour(new EightBallMatch("PlayerOne","Player2",2,2,"1","2","123","345"));
		leagueMatch.MatchFour.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchFive(new EightBallMatch("PlayerOne","Player2",2,2,"1","2","345","123"));
		leagueMatch.MatchFive.PlayerOne.CurrentlyUp = true;
	});

	it('should know that it is a EightBall LeagueMatch', function() {
	    expect(leagueMatch.GameType).toEqual("EightBall");
    });

	it('should have HomeTeamNumber, AwayTeamNumber, StartTime, and TableType initialized from constructor', function() {
		expect(leagueMatch.HomeTeamNumber).toEqual("123");
		expect(leagueMatch.AwayTeamNumber).toEqual("345");
		expect(leagueMatch.StartTime).toEqual("10:00 pm");
		expect(leagueMatch.TableType).toEqual("Coin-Operated");
	})

	it('should hold 5 different games', function() {
		expect(leagueMatch.MatchOne).toNotEqual(null);
		expect(leagueMatch.MatchTwo).toNotEqual(null);
		expect(leagueMatch.MatchThree).toNotEqual(null);
		expect(leagueMatch.MatchFour).toNotEqual(null);
		expect(leagueMatch.MatchFive).toNotEqual(null);
	});

	it('should hold a home and away team numbers', function() {
		expect(leagueMatch.HomeTeamNumber).toEqual("123");
		expect(leagueMatch.AwayTeamNumber).toEqual("345");
	});

	it('should keep scorecard team owners number', function() {
		expect(leagueMatch.TeamNumber).toEqual("");
	});

	it('should have the Start Time and End Time', function() {
		expect(leagueMatch.EndTime).toEqual("");
	});
	
	it('should be able to set each match and set the LeagueMatchId for each', function() {
		expect(leagueMatch.MatchOne.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchTwo.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchThree.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchFour.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchFive.LeagueMatchId).toEqual(1);
	});

	it('should know when all of the matches have ended and the league match is complete', function() {
        leagueMatch.MatchOne.Ended = true;
        leagueMatch.MatchTwo.Ended = true;
        leagueMatch.MatchThree.Ended = true;
        leagueMatch.MatchFour.Ended = true;
        leagueMatch.MatchFive.Ended = true;
        expect(leagueMatch.Ended()).toEqual(true);
    });

    it('should be able to get the home teams total match points', function() {
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8);

        leagueMatch.MatchTwo.shotMissed();
        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchTwo.startNewGame();
        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchTwo.startNewGame();
        leagueMatch.MatchTwo.scoreNumberedBall(8);

        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8);

        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8);

        leagueMatch.MatchFive.shotMissed();
        leagueMatch.MatchFive.scoreNumberedBall(8);
        leagueMatch.MatchFive.startNewGame();
        leagueMatch.MatchFive.scoreNumberedBall(8);
        leagueMatch.MatchFive.startNewGame();
        leagueMatch.MatchFive.scoreNumberedBall(8);
        expect(leagueMatch.getHomeTeamMatchPoints()).toEqual(5);
    });

    it('should be able to get the away teams total match points', function() {
        leagueMatch.MatchOne.shotMissed();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8)
        
        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchTwo.startNewGame();
        leagueMatch.MatchTwo.scoreNumberedBall(8);

        leagueMatch.MatchThree.shotMissed();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8)
        
        leagueMatch.MatchFour.shotMissed();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8)

        leagueMatch.MatchFive.scoreNumberedBall(8);
        leagueMatch.MatchFive.startNewGame();
        leagueMatch.MatchFive.scoreNumberedBall(8);

        expect(leagueMatch.getAwayTeamMatchPoints()).toEqual(5);
        expect(leagueMatch.getHomeTeamMatchPoints()).toEqual(0);
    });
    
    it('should know if home team won the match', function() {
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchTwo.shotMissed();
        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchTwo.startNewGame();
        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFive.shotMissed();
        leagueMatch.MatchFive.scoreNumberedBall(8);
        leagueMatch.MatchFive.startNewGame();
        leagueMatch.MatchFive.scoreNumberedBall(8);
        expect(leagueMatch.isHomeTeamWinning()).toEqual(true);
    });

    it('should know if away team won the match', function() {
        leagueMatch.MatchOne.shotMissed();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8)

        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchTwo.startNewGame();
        leagueMatch.MatchTwo.scoreNumberedBall(8);

        leagueMatch.MatchThree.shotMissed();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8)

        leagueMatch.MatchFour.shotMissed();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8)

        leagueMatch.MatchFive.scoreNumberedBall(8);
        leagueMatch.MatchFive.startNewGame();
        leagueMatch.MatchFive.scoreNumberedBall(8);

        expect(leagueMatch.getAwayTeamMatchPoints()).toEqual(5);
        expect(leagueMatch.getHomeTeamMatchPoints()).toEqual(0);
        expect(leagueMatch.isAwayTeamWinning()).toEqual(true);
    });

    it('should be able to get the winning team number if its the away team', function() {
        leagueMatch.MatchOne.shotMissed();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8)

        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchTwo.startNewGame();
        leagueMatch.MatchTwo.scoreNumberedBall(8);

        leagueMatch.MatchThree.shotMissed();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8)

        leagueMatch.MatchFour.shotMissed();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8)

        leagueMatch.MatchFive.scoreNumberedBall(8);
        leagueMatch.MatchFive.startNewGame();
        leagueMatch.MatchFive.scoreNumberedBall(8);

        expect(leagueMatch.getWinningTeamNumber()).toEqual("345");
    });

     it('should be able to get the winning team number if it is the home team', function() {
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchOne.startNewGame();
        leagueMatch.MatchOne.scoreNumberedBall(8);
        leagueMatch.MatchTwo.shotMissed();
        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchTwo.startNewGame();
        leagueMatch.MatchTwo.scoreNumberedBall(8);
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchThree.startNewGame();
        leagueMatch.MatchThree.scoreNumberedBall(8);
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFour.startNewGame();
        leagueMatch.MatchFour.scoreNumberedBall(8);
        leagueMatch.MatchFive.shotMissed();
        leagueMatch.MatchFive.scoreNumberedBall(8);
        leagueMatch.MatchFive.startNewGame();
        leagueMatch.MatchFive.scoreNumberedBall(8);
        expect(leagueMatch.getWinningTeamNumber()).toEqual("123");
    });

    it('should be able to keep team names', function() {
        expect(leagueMatch.HomeTeamName).toEqual("HomeTeam");
        expect(leagueMatch.AwayTeamName).toEqual("AwayTeam");
    });

    it('should be able to tell which team has signed the match', function() {
        expect(leagueMatch.HomeTeamSigned).toEqual(false);
        expect(leagueMatch.AwayTeamSigned).toEqual(false);
        leagueMatch.HomeTeamSigned = true;
        leagueMatch.AwayTeamSigned = true;
        expect(leagueMatch.HomeTeamSigned).toEqual(true);
        expect(leagueMatch.AwayTeamSigned).toEqual(true);
    });

	describe('toJSON/fromJSON', function() {
		it('should be able to take a new League Match and turn it into a JSON object', function() {
			expect(leagueMatch.toJSON()).toEqual({
				MatchOne:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			}, MatchTwo:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			}, MatchThree:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			}, MatchFour:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			}, MatchFive:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			},
				TeamNumber: "",
				HomeTeamNumber: "123",
				AwayTeamNumber: "345",
				StartTime: "10:00 pm",
				EndTime: "",
				TableType: "Coin-Operated",
				LeagueMatchId: 1
			});
		});

		it('should be able to take a new League Match and turn it into a small JSON object', function() {
			expect(leagueMatch.toSmallJSON()).toEqual({
				TeamNumber: "",
				HomeTeamNumber: "123",
				AwayTeamNumber: "345",
				StartTime: "10:00 pm",
				EndTime: "",
				TableType: "Coin-Operated",
				LeagueMatchId: 1
			});
		});

		it('should be able to set SmallJSON = true to return only the small JSON object when toJSON is called.', function() {
			leagueMatch.SmallJSON = true;
			expect(leagueMatch.toJSON()).toEqual({
				TeamNumber: "",
				HomeTeamNumber: "123",
				AwayTeamNumber: "345",
				StartTime: "10:00 pm",
				EndTime: "",
				TableType: "Coin-Operated",
				LeagueMatchId: 1
			});
		});

		it('should be able to take a json object and fill its own values', function() {
			leagueMatch = new EightBallLeagueMatch;
			leagueMatch.fromJSON({
				MatchOne:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			},
			MatchTwo:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			},
			 MatchThree:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			},
			MatchFour:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			},
			 MatchFive:{
				PlayerOne: {
				Name: "PlayerOne",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "1",
				TeamNumber: "345",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "2",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 0,
				CurrentGame: {
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: false,
                    Ended: false,
                    StripedBallsHitIn: [],
                    SolidBallsHitIn: [],
                    LastBallHitIn: null,
                    OnBreak: true,
                    BreakingPlayerStillHitting: true
                },
				CompletedGames: [],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 1
			},
				TeamNumber: "",
				HomeTeamNumber: "123",
				AwayTeamNumber: "345",
				StartTime: "10:00 pm",
				EndTime: "",
				TableType: "Coin-Operated",
				LeagueMatchId: 1
			});
			expect(leagueMatch.TeamNumber).toEqual("");
			expect(leagueMatch.HomeTeamNumber).toEqual("123");
			expect(leagueMatch.AwayTeamNumber).toEqual("345");
			expect(leagueMatch.StartTime).toEqual("10:00 pm");
			expect(leagueMatch.EndTime).toEqual("");
			expect(leagueMatch.TableType).toEqual("Coin-Operated");
			expect(leagueMatch.LeagueMatchId).toEqual(1);
			expect(leagueMatch.MatchFive.PlayerOne.Name).toEqual("PlayerOne");

			leagueMatch.MatchFive.scoreNumberedBall(8);
			expect(leagueMatch.MatchFive.CurrentGame.getBallsHitIn()).toEqual([8]);
			leagueMatch.MatchFive.startNewGame();
			expect(leagueMatch.MatchFive.CurrentGame.getBallsHitIn()).toEqual([]);
			expect(leagueMatch.MatchFive.CompletedGames.length).toEqual(1);
		});

		it('should be able to take a small json object and fill its own values', function() {
			leagueMatch = new EightBallLeagueMatch;
			leagueMatch.fromSmallJSON({
				TeamNumber: "",
				HomeTeamNumber: "123",
				AwayTeamNumber: "345",
				StartTime: "10:00 pm",
				EndTime: "",
				TableType: "Coin-Operated",
				LeagueMatchId: null
			});
			expect(leagueMatch.TeamNumber).toEqual("");
			expect(leagueMatch.HomeTeamNumber).toEqual("123");
			expect(leagueMatch.AwayTeamNumber).toEqual("345");
			expect(leagueMatch.StartTime).toEqual("10:00 pm");
			expect(leagueMatch.EndTime).toEqual("");
			expect(leagueMatch.TableType).toEqual("Coin-Operated");
			expect(leagueMatch.LeagueMatchId).toEqual(null);
		});
	});
});
