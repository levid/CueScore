/**
 * @author jamesa
 */

//Mock out DataService
var DataService = {
	saveMatch: function(a){},
	saveLeagueMatch: function(a,b) { b(1);}
};

describe('NineBall LeagueMatch', function () {
	var leagueMatch;
	beforeEach(function() {  
	    leagueMatch = new NineBallLeagueMatch("123","345", "HomeTeam", "AwayTeam", "10:00 pm", "Coin-Operated");
		leagueMatch.setMatchOne(new NineBallMatch("PlayerOne","Player2",1,1,"1","2","123","345"));
		leagueMatch.MatchOne.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchTwo(new NineBallMatch("PlayerOne","Player2",1,1,"1","2","345","123"));
		leagueMatch.MatchTwo.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchThree(new NineBallMatch("PlayerOne","Player2",1,1,"1","2","123","345"));
		leagueMatch.MatchThree.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchFour(new NineBallMatch("PlayerOne","Player2",1,1,"1","2","123","345"));
		leagueMatch.MatchFour.PlayerOne.CurrentlyUp = true;
		leagueMatch.setMatchFive(new NineBallMatch("PlayerOne","Player2",1,1,"1","2","345","123"));
		leagueMatch.MatchFive.PlayerOne.CurrentlyUp = true;
	});

	it('should know that it is a NineBall LeagueMatch', function() {
	    expect(leagueMatch.GameType).toEqual("NineBall");
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
	
	it('should be able to calculate home and away teams scores', function() {
		//Player1 20 points (Home)
		leagueMatch.MatchOne.scoreNumberedBall(1);
		leagueMatch.MatchOne.scoreNumberedBall(2);
		leagueMatch.MatchOne.scoreNumberedBall(3);
		leagueMatch.MatchOne.scoreNumberedBall(4);
	
		expect(leagueMatch.getHomeTeamMatchPoints()).toEqual(20);
		expect(leagueMatch.getAwayTeamMatchPoints()).toEqual(0);
		
		//PlayerTwo 19 points (Home)
		leagueMatch.MatchTwo.scoreNumberedBall(1);
		leagueMatch.MatchTwo.scoreNumberedBall(2);
		leagueMatch.MatchTwo.scoreNumberedBall(3);
		leagueMatch.MatchTwo.shotMissed();
		leagueMatch.MatchTwo.scoreNumberedBall(4);
		leagueMatch.MatchTwo.scoreNumberedBall(5);
		leagueMatch.MatchTwo.scoreNumberedBall(6);
		leagueMatch.MatchTwo.scoreNumberedBall(7);

		//PlayerTwo 19 Points (Away)
		leagueMatch.MatchThree.scoreNumberedBall(1);
		leagueMatch.MatchThree.scoreNumberedBall(2);
		leagueMatch.MatchThree.scoreNumberedBall(3);
		leagueMatch.MatchThree.shotMissed();
		leagueMatch.MatchThree.scoreNumberedBall(4);
		leagueMatch.MatchThree.scoreNumberedBall(5);
		leagueMatch.MatchThree.scoreNumberedBall(6);
		leagueMatch.MatchThree.scoreNumberedBall(7);

		//PlayerTwo 18 points (Away)
		leagueMatch.MatchFour.scoreNumberedBall(1);
		leagueMatch.MatchFour.scoreNumberedBall(2);
		leagueMatch.MatchFour.scoreNumberedBall(3);
		leagueMatch.MatchFour.scoreNumberedBall(4);
		leagueMatch.MatchFour.shotMissed();
		leagueMatch.MatchFour.scoreNumberedBall(4);
		leagueMatch.MatchFour.scoreNumberedBall(5);
		leagueMatch.MatchFour.scoreNumberedBall(6);
		leagueMatch.MatchFour.scoreNumberedBall(9);
		
		//PlayerTwo 18 points (Home)
		leagueMatch.MatchFive.scoreNumberedBall(1);
		leagueMatch.MatchFive.scoreNumberedBall(2);
		leagueMatch.MatchFive.scoreNumberedBall(3);
		leagueMatch.MatchFive.scoreNumberedBall(4);
		leagueMatch.MatchFive.shotMissed();
		leagueMatch.MatchFive.scoreNumberedBall(4);
		leagueMatch.MatchFive.scoreNumberedBall(5);
		leagueMatch.MatchFive.scoreNumberedBall(6);
		leagueMatch.MatchFive.scoreNumberedBall(9);
		
		expect(leagueMatch.getHomeTeamMatchPoints()).toEqual(60);
		expect(leagueMatch.getAwayTeamMatchPoints()).toEqual(40);
	});

	it('should know which team is winning the match', function() {
		leagueMatch.MatchOne.scoreNumberedBall(1);
		leagueMatch.MatchOne.scoreNumberedBall(2);
		leagueMatch.MatchOne.scoreNumberedBall(3);
		leagueMatch.MatchOne.scoreNumberedBall(4);

		expect(leagueMatch.isHomeTeamWinning()).toEqual(true);
		expect(leagueMatch.isAwayTeamWinning()).toEqual(false);

		leagueMatch.MatchTwo.scoreNumberedBall(1);
		leagueMatch.MatchTwo.scoreNumberedBall(2);
		leagueMatch.MatchTwo.scoreNumberedBall(3);
		leagueMatch.MatchTwo.shotMissed();
		leagueMatch.MatchTwo.scoreNumberedBall(4);
		leagueMatch.MatchTwo.scoreNumberedBall(5);
		leagueMatch.MatchTwo.scoreNumberedBall(6);
		leagueMatch.MatchTwo.scoreNumberedBall(7);

		leagueMatch.MatchThree.shotMissed();
		leagueMatch.MatchThree.scoreNumberedBall(1);
		leagueMatch.MatchThree.scoreNumberedBall(2);
		leagueMatch.MatchThree.scoreNumberedBall(3);
		leagueMatch.MatchThree.scoreNumberedBall(4);
		leagueMatch.MatchThree.scoreNumberedBall(5);
		leagueMatch.MatchThree.scoreNumberedBall(6);
		leagueMatch.MatchThree.scoreNumberedBall(7);

		leagueMatch.MatchFour.shotMissed();
		leagueMatch.MatchFour.scoreNumberedBall(1);
		leagueMatch.MatchFour.scoreNumberedBall(2);
		leagueMatch.MatchFour.scoreNumberedBall(3);
		leagueMatch.MatchFour.scoreNumberedBall(4);
		leagueMatch.MatchFour.scoreNumberedBall(4);
		leagueMatch.MatchFour.scoreNumberedBall(5);
		leagueMatch.MatchFour.scoreNumberedBall(6);
		leagueMatch.MatchFour.scoreNumberedBall(9);

		leagueMatch.MatchFive.shotMissed();
		leagueMatch.MatchFive.scoreNumberedBall(1);
		leagueMatch.MatchFive.scoreNumberedBall(2);
		leagueMatch.MatchFive.scoreNumberedBall(3);
		leagueMatch.MatchFive.scoreNumberedBall(4);
		leagueMatch.MatchFive.scoreNumberedBall(4);
		leagueMatch.MatchFive.scoreNumberedBall(5);
		leagueMatch.MatchFive.scoreNumberedBall(6);
		leagueMatch.MatchFive.scoreNumberedBall(9);

		expect(leagueMatch.isHomeTeamWinning()).toEqual(false);
		expect(leagueMatch.isAwayTeamWinning()).toEqual(true);
    });

    	it('should be able to get the winning teams number', function() {
		leagueMatch.MatchOne.scoreNumberedBall(1);
		leagueMatch.MatchOne.scoreNumberedBall(2);
		leagueMatch.MatchOne.scoreNumberedBall(3);
		leagueMatch.MatchOne.scoreNumberedBall(4);

		expect(leagueMatch.getWinningTeamNumber()).toEqual("123");

		leagueMatch.MatchTwo.scoreNumberedBall(1);
		leagueMatch.MatchTwo.scoreNumberedBall(2);
		leagueMatch.MatchTwo.scoreNumberedBall(3);
		leagueMatch.MatchTwo.shotMissed();
		leagueMatch.MatchTwo.scoreNumberedBall(4);
		leagueMatch.MatchTwo.scoreNumberedBall(5);
		leagueMatch.MatchTwo.scoreNumberedBall(6);
		leagueMatch.MatchTwo.scoreNumberedBall(7);

		leagueMatch.MatchThree.shotMissed();
		leagueMatch.MatchThree.scoreNumberedBall(1);
		leagueMatch.MatchThree.scoreNumberedBall(2);
		leagueMatch.MatchThree.scoreNumberedBall(3);
		leagueMatch.MatchThree.scoreNumberedBall(4);
		leagueMatch.MatchThree.scoreNumberedBall(5);
		leagueMatch.MatchThree.scoreNumberedBall(6);
		leagueMatch.MatchThree.scoreNumberedBall(7);

		leagueMatch.MatchFour.shotMissed();
		leagueMatch.MatchFour.scoreNumberedBall(1);
		leagueMatch.MatchFour.scoreNumberedBall(2);
		leagueMatch.MatchFour.scoreNumberedBall(3);
		leagueMatch.MatchFour.scoreNumberedBall(4);
		leagueMatch.MatchFour.scoreNumberedBall(4);
		leagueMatch.MatchFour.scoreNumberedBall(5);
		leagueMatch.MatchFour.scoreNumberedBall(6);
		leagueMatch.MatchFour.scoreNumberedBall(9);

		leagueMatch.MatchFive.shotMissed();
		leagueMatch.MatchFive.scoreNumberedBall(1);
		leagueMatch.MatchFive.scoreNumberedBall(2);
		leagueMatch.MatchFive.scoreNumberedBall(3);
		leagueMatch.MatchFive.scoreNumberedBall(4);
		leagueMatch.MatchFive.scoreNumberedBall(4);
		leagueMatch.MatchFive.scoreNumberedBall(5);
		leagueMatch.MatchFive.scoreNumberedBall(6);
		leagueMatch.MatchFive.scoreNumberedBall(9);

		expect(leagueMatch.getWinningTeamNumber()).toEqual("345");
    });

	it('should be able to set each match and set the LeagueMatchId for each', function() {
		expect(leagueMatch.MatchOne.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchTwo.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchThree.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchFour.LeagueMatchId).toEqual(1);
		expect(leagueMatch.MatchFive.LeagueMatchId).toEqual(1);
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

	it('should know when all of the matches have ended and the league match is complete', function() {
        leagueMatch.MatchOne.Ended = true;
        leagueMatch.MatchTwo.Ended = true;
        leagueMatch.MatchThree.Ended = true;
        leagueMatch.MatchFour.Ended = true;
        leagueMatch.MatchFive.Ended = true;
        expect(leagueMatch.Ended()).toEqual(true);
    });


	describe('toJSON/fromJSON', function() {
		it('should be able to take a new League Match and turn it into a JSON object', function() {
			expect(leagueMatch.toJSON()).toEqual({
				MatchOne:{
					PlayerOne: {
						Name: "PlayerOne",
						Rank: 1,
						BallCount: "14",
						Number: "1",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: true
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						BallCount: "14",
						Number: "2",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: false
					},
					PlayerOneMatchPointsEarned : 0, 
					PlayerTwoMatchPointsEarned : 0,
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						PlayerOneTimeoutsTaken : 0, 
						PlayerTwoTimeoutsTaken : 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
						Rank: 1,
						BallCount: "14",
						Number: "1",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: true
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						BallCount: "14",
						Number: "2",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: false
					},
					PlayerOneMatchPointsEarned : 0, 
					PlayerTwoMatchPointsEarned : 0,
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						PlayerOneTimeoutsTaken : 0, 
						PlayerTwoTimeoutsTaken : 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
						Rank: 1,
						BallCount: "14",
						Number: "1",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: true
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						BallCount: "14",
						Number: "2",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: false
					},
					PlayerOneMatchPointsEarned : 0, 
					PlayerTwoMatchPointsEarned : 0,
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						PlayerOneTimeoutsTaken : 0, 
						PlayerTwoTimeoutsTaken : 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
						Rank: 1,
						BallCount: "14",
						Number: "1",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: true
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						BallCount: "14",
						Number: "2",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						CurrentlyUp: false
					},
					PlayerOneMatchPointsEarned : 0, 
					PlayerTwoMatchPointsEarned : 0,
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						PlayerOneTimeoutsTaken : 0, 
						PlayerTwoTimeoutsTaken : 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
							Rank: 1,
							BallCount: "14",
							Number: "1",
							TeamNumber: "345",
							Score: 0,
							Safeties: 0,
							NineOnSnaps: 0,
							BreakAndRuns: 0,
							CurrentlyUp: true
						},
						PlayerTwo:{
							Name: "Player2",
							Rank: 1,
							BallCount: "14",
							Number: "2",
							TeamNumber: "123",
							Score: 0,
							Safeties: 0,
							NineOnSnaps: 0,
							BreakAndRuns: 0,
							CurrentlyUp: false
						},
						PlayerOneMatchPointsEarned : 0, 
						PlayerTwoMatchPointsEarned : 0,
						CurrentGame: {
							PlayerOneScore: 0,
							PlayerTwoScore: 0,
							PlayerOneTimeoutsTaken : 0, 
							PlayerTwoTimeoutsTaken : 0,
							NumberOfInnings: 0, 
							PlayerOneNineOnSnap: false,
							PlayerOneBreakAndRun: false,
							PlayerTwoNineOnSnap: false,
							PlayerTwoBreakAndRun: false,
							Ended: false,
							PlayerOneBallsHitIn: [],
							PlayerTwoBallsHitIn: [],
							PlayerOneDeadBalls: [],
							PlayerTwoDeadBalls: [],
							PlayerOneLastBall: null,
							PlayerTwoLastBall: null,
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
			leagueMatch = new NineBallLeagueMatch;
			leagueMatch.fromJSON({
				MatchOne:{
					PlayerOne: {
						Name: "PlayerOne",
						Rank: 1,
						Number: "1",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: true
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						Number: "2",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: false
					},
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
						Rank: 1,
						Number: "1",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: false
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						Number: "2",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: true
					},
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
						Rank: 1,
						Number: "1",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: true
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						Number: "2",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: false
					},
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
						Rank: 1,
						Number: "1",
						TeamNumber: "123",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: true
					},
					PlayerTwo:{
						Name: "Player2",
						Rank: 1,
						Number: "2",
						TeamNumber: "345",
						Score: 0,
						Safeties: 0,
						NineOnSnaps: 0,
						BreakAndRuns: 0,
						TimeoutsTaken: 0,
						CurrentlyUp: false
					},
					CurrentGame: {
						PlayerOneScore: 0,
						PlayerTwoScore: 0,
						NumberOfInnings: 0, 
						PlayerOneNineOnSnap: false,
						PlayerOneBreakAndRun: false,
						PlayerTwoNineOnSnap: false,
						PlayerTwoBreakAndRun: false,
						Ended: false,
						PlayerOneBallsHitIn: [],
						PlayerTwoBallsHitIn: [],
						PlayerOneDeadBalls: [],
						PlayerTwoDeadBalls: [],
						PlayerOneLastBall: null,
						PlayerTwoLastBall: null,
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
							Name: "TestPlayer",
							Rank: 1,
							Number: "1",
							TeamNumber: "345",
							Score: 0,
							Safeties: 0,
							NineOnSnaps: 0,
							BreakAndRuns: 0,
							TimeoutsTaken: 0,
							CurrentlyUp: true
						},
						PlayerTwo:{
							Name: "Player2",
							Rank: 1,
							Number: "2",
							TeamNumber: "123",
							Score: 0,
							Safeties: 0,
							NineOnSnaps: 0,
							BreakAndRuns: 0,
							TimeoutsTaken: 0,
							CurrentlyUp: false
						},
						CurrentGame: {
							PlayerOneScore: 0,
							PlayerTwoScore: 0,
							NumberOfInnings: 0, 
							PlayerOneNineOnSnap: false,
							PlayerOneBreakAndRun: false,
							PlayerTwoNineOnSnap: false,
							PlayerTwoBreakAndRun: false,
							Ended: false,
							PlayerOneBallsHitIn: [],
							PlayerTwoBallsHitIn: [],
							PlayerOneDeadBalls: [],
							PlayerTwoDeadBalls: [],
							PlayerOneLastBall: null,
							PlayerTwoLastBall: null,
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
				LeagueMatchId: null
			});
			expect(leagueMatch.TeamNumber).toEqual("");
			expect(leagueMatch.HomeTeamNumber).toEqual("123");
			expect(leagueMatch.AwayTeamNumber).toEqual("345");
			expect(leagueMatch.StartTime).toEqual("10:00 pm");
			expect(leagueMatch.EndTime).toEqual("");
			expect(leagueMatch.TableType).toEqual("Coin-Operated");
			expect(leagueMatch.LeagueMatchId).toEqual(null);
			expect(leagueMatch.MatchFive.PlayerOne.Name).toEqual("TestPlayer");
			
			leagueMatch.MatchFive.scoreNumberedBall(9);
			expect(leagueMatch.MatchFive.CurrentGame.getBallsScored()).toEqual([9]);
			leagueMatch.MatchFive.startNewGame();
			expect(leagueMatch.MatchFive.CurrentGame.getBallsScored()).toEqual([]);
			expect(leagueMatch.MatchFive.CompletedGames.length).toEqual(1);
		});
		
		it('should be able to take a small json object and fill its own values', function() {
			leagueMatch = new NineBallLeagueMatch;
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
