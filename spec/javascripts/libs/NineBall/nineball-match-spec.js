/**
 * @author jamesa
 */
describe('NineBall Match', function () {
		var match;
		var matchCallback;
	
		beforeEach(function() {  
			matchCallback = jasmine.createSpy();
		    match = new NineBallMatch("Player1", "Player2", 1, 7, "12345", "987654", "123", "456", matchCallback);
		    match.PlayerOne.CurrentlyUp = true;
		});
		
	describe('Constructor', function() {  	
		it('should take 4 parameters', function() {
			expect(match).toNotEqual(null);
	  	});
  
  		it('should have 2 players', function() {
			expect(match.PlayerOne.Name).toEqual("Player1");
			expect(match.PlayerOne.Rank).toEqual(1);
			expect(match.PlayerOne.Number).toEqual("12345");
			expect(match.PlayerOne.TeamNumber).toEqual("123");
			expect(match.PlayerTwo.Name).toEqual("Player2");
			expect(match.PlayerTwo.Rank).toEqual(7);
			expect(match.PlayerTwo.Number).toEqual("987654");
			expect(match.PlayerTwo.TeamNumber).toEqual("456");
		});

		it('should set Player 1 to break first', function() {
			expect(match.PlayerOne.CurrentlyUp).toEqual(true);
		});
		
		it('should set create the first Game and set it to CurrentGame', function() {
			expect(match.CurrentGame).toNotEqual(null);
		});
	});
	
	describe('Scoring', function() {
		it('should accept a number for the ball that was hit in', function() {
			match.scoreNumberedBall(1);
		});
		
		it('should add 1 to the current Ball Count for the current player up for balls #1-8', function() {
			expect(match.CurrentGame.PlayerOneScore).toEqual(0);
			match.scoreNumberedBall(1);
			expect(match.CurrentGame.PlayerOneScore).toEqual(1);
			match.scoreNumberedBall(2);
			expect(match.CurrentGame.PlayerOneScore).toEqual(2);
			match.scoreNumberedBall(3);
			expect(match.CurrentGame.PlayerOneScore).toEqual(3);
			match.scoreNumberedBall(4);
			expect(match.CurrentGame.PlayerOneScore).toEqual(4);
			match.scoreNumberedBall(5);
			expect(match.CurrentGame.PlayerOneScore).toEqual(5);
			match.scoreNumberedBall(6);
			expect(match.CurrentGame.PlayerOneScore).toEqual(6);
			match.scoreNumberedBall(7);
			expect(match.CurrentGame.PlayerOneScore).toEqual(7);
			match.scoreNumberedBall(8);
			expect(match.CurrentGame.PlayerOneScore).toEqual(8);
		});
		
		it('should add 2 to the current Ball Count for the current player up for ball #9', function() {
			expect(match.CurrentGame.PlayerOneScore).toEqual(0);
			match.scoreNumberedBall(9);
			expect(match.CurrentGame.PlayerOneScore).toEqual(2);
		});
		
		it('should be able to get match\'s points by the team number', function() {

			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.getMatchPointsByTeamNumber("123")).toEqual(20);
		});
		
		it('should be able to remember the last person that was winning incase of a tie', function() {
			match.scoreNumberedBall(1);
			expect(match.PlayerNumberWinning).toEqual(1);
			match.shotMissed();
			match.shotMissed();
			expect(match.PlayerTwo.CurrentlyUp).toEqual(true);
			match.scoreNumberedBall(2);
			expect(match.PlayerNumberWinning).toEqual(1);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			expect(match.PlayerNumberWinning).toEqual(2);
			match.shotMissed();
			match.scoreNumberedBall(7);
			expect(match.PlayerNumberWinning).toEqual(1);
		});
	
	});

	describe('Match/Game Ending', function() {
		it('should add current game to the CompletedGames list and start a new Game when all 8 balls are accounted for on a DeadBall and 9 is scored', function() {
			expect(match.CompletedGames.length).toEqual(0);
			match.hitDeadBall(1);
			match.hitDeadBall(2);
			match.hitDeadBall(3);
			match.hitDeadBall(4);
			match.hitDeadBall(5);
			match.hitDeadBall(6);
			match.hitDeadBall(7);
			match.hitDeadBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame();
			expect(match.CompletedGames.length).toEqual(1);
			expect(match.CurrentGame.getDeadBalls()).toEqual(0);
			expect(match.CurrentGame.Ended).toEqual(false);
			expect(match.CompletedGames[0].Ended).toEqual(true);
		});
		
		it('should add current game to the CompletedGames list and start a new Game when all 9 balls are accounted for on a ScoredBall', function() {
			expect(match.CompletedGames.length).toEqual(0);
			match.hitDeadBall(1);
			match.hitDeadBall(2);
			match.hitDeadBall(3);
			match.hitDeadBall(4);
			match.hitDeadBall(5);
			match.hitDeadBall(6);
			match.hitDeadBall(7);
			match.hitDeadBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame();
			expect(match.CompletedGames.length).toEqual(1);
			expect(match.CurrentGame.getDeadBalls()).toEqual(0);
			expect(match.CurrentGame.Ended).toEqual(false);
			expect(match.CompletedGames[0].Ended).toEqual(true);
		});
		
		it('should know if the match is completed', function() {
			expect(match.Ended).toEqual(false);
		});
		
		it('match should be ended when ball #1-8 scores, which then raises CurrentPlayers Score to equal Ball Count', function() {
			expect(match.Ended).toEqual(false);
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame();
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.Ended).toEqual(true);
		});
	
		it('match should be ended when ball#9 scores, which then raises CurrentPlayers Score to above or equal Ball Count', function() {
			expect(match.Ended).toEqual(false);
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame();
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(9);
			expect(match.Ended).toEqual(true);
		});
		
		it('should hold multiple completed games', function() {
			expect(match.CompletedGames).toNotEqual(null); 
		});
	});
	
	describe('Players', function() {
		it('should be able to find the losing player', function() {
			match.scoreNumberedBall(9);
			expect(match.getLosingPlayer().Name).toEqual("Player2");
		});
		
		it('should be able to find the winning player', function() {
			match.scoreNumberedBall(9);
			expect(match.getWinningPlayer().Name).toEqual("Player1");
		});
		
		it('should change currently up player on missed shot', function() {
			expect(match.PlayerOne.CurrentlyUp).toEqual(true);
			match.shotMissed();
			expect(match.PlayerTwo.CurrentlyUp).toEqual(true);
		});

		it('should be able to get the player twos match points earned', function() {
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.getPlayerTwoMatchPoints()).toEqual(0);
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame()
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			expect(match.getPlayerTwoMatchPoints()).toEqual(18);
		});
			
		it('should be able to see if Player One is winning', function() {
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.isPlayerOneWinning()).toEqual(true);
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			expect(match.isPlayerOneWinning()).toEqual(true); //Ratio (4/14) > (6/55)
		});
	
		it('should be able to see if Player Two is winning', function() {
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			expect(match.isPlayerTwoWinning()).toEqual(false);
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			expect(match.isPlayerTwoWinning()).toEqual(false); //Ratio (3/14) > (5/55)
		});
				
		it('should be able to get the losing players match points earned', function() {
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.getLosingPlayersMatchPoints()).toEqual(0);
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame()
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame()
			match.scoreNumberedBall(1);
			expect(match.getLosingPlayersMatchPoints()).toEqual(2);
		});
		
		it('should be able to get the winning players match points earned', function() {
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.getWinningPlayersMatchPoints()).toEqual(20);
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame()
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame()
			match.scoreNumberedBall(1);
			expect(match.getWinningPlayersMatchPoints()).toEqual(18);
		});
		
		it('should be able to get the the match points. (example 20-0)', function() {
			expect(match.getMatchPoints()).toEqual('Tied');
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.getMatchPoints()).toEqual('20-0');
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame()
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.scoreNumberedBall(9);
			match.startNewGame()
			match.scoreNumberedBall(1);
			expect(match.getMatchPoints()).toEqual('2-18');
		});
	});
	
	it('should be able to set the a ball to be a deadball', function() {
		match.hitDeadBall(3);
		expect(match.CurrentGame.PlayerOneDeadBalls[0]).toEqual(3);
		match.shotMissed();
		match.hitDeadBall(2);
		expect(match.CurrentGame.PlayerTwoDeadBalls[0]).toEqual(2);
	});

	it('should be able to get the total number of innings', function() {
		expect(match.getTotalInnings()).toEqual('0');
		match.shotMissed();
		match.shotMissed();
		match.shotMissed();
		match.shotMissed();
		expect(match.getTotalInnings()).toEqual('2');
		match.shotMissed();
		match.shotMissed();
		expect(match.getTotalInnings()).toEqual('3');
	});
	
	it('should be able to get the total number of dead balls', function() {
		expect(match.getTotalDeadBalls()).toEqual('0');
		match.scoreNumberedBall(9);
		expect(match.getTotalDeadBalls()).toEqual('8');
		match.startNewGame();
		match.hitDeadBall(1);
		match.hitDeadBall(2);
		expect(match.getTotalDeadBalls()).toEqual('10');
		match.hitDeadBall(3);
		match.hitDeadBall(4);
		match.hitDeadBall(5);
		match.hitDeadBall(6);
		expect(match.getTotalDeadBalls()).toEqual('14');
	});	
	
	it('should be able to hold on to the OriginalId from the database', function() {
		expect(match.OriginalId).toEqual(0);
	});

	it('should be able to hold on to the LeagueMatchId from the database', function() {
		expect(match.LeagueMatchId).toEqual(0);
	});
		
	it('should be able to know the current game number', function() {
		expect(match.getCurrentGameNumber()).toEqual('1');
		match.hitDeadBall(1);
		match.hitDeadBall(2);
		match.hitDeadBall(3);
		match.hitDeadBall(4);
		match.hitDeadBall(5);
		match.hitDeadBall(6);
		match.hitDeadBall(7);
		match.hitDeadBall(8);
		match.scoreNumberedBall(9);
		match.startNewGame();
		expect(match.getCurrentGameNumber()).toEqual('2');
	});
	
	it('should be able to get total number of safeties', function() {
		expect(match.getTotalSafeties()).toEqual('0 to 0');
	});
	
	it('should be able to hit a safety', function() {
		expect(match.getTotalSafeties()).toEqual('0 to 0');
		match.hitSafety();
		expect(match.getTotalSafeties()).toEqual('1 to 0');
		expect(match.PlayerOne.Safeties).toEqual(1);
		match.shotMissed();
		match.hitSafety();
		expect(match.getTotalSafeties()).toEqual('2 to 0');
		expect(match.PlayerTwo.Safeties).toEqual(0);
		match.hitSafety();
		expect(match.getTotalSafeties()).toEqual('2 to 1');
		expect(match.PlayerTwo.Safeties).toEqual(1);
	});
	
	it('should reset Timeouts taken for each player when a game has ended', function() {
		expect(match.CurrentGame.PlayerOneTimeoutsTaken).toEqual(0);
		expect(match.CurrentGame.PlayerTwoTimeoutsTaken).toEqual(0);
		match.CurrentGame.takeTimeout();
		expect(match.CurrentGame.PlayerOneTimeoutsTaken).toEqual(1);
		match.shotMissed();
		match.CurrentGame.takeTimeout();
		expect(match.CurrentGame.PlayerTwoTimeoutsTaken).toEqual(1);
		match.scoreNumberedBall(9);
		match.startNewGame();
		expect(match.CurrentGame.PlayerOneTimeoutsTaken).toEqual(0);
		expect(match.CurrentGame.PlayerTwoTimeoutsTaken).toEqual(0);
	});
	
	describe('toJSON/fromJSON', function() {
		it('should be able to take a new Match and turn it into a JSON object', function() {
			expect(match.toJSON()).toEqual({
				PlayerOne: {
					Name: "Player1",
					Rank: 1,
					BallCount: "14",
					Number: "12345",
					TeamNumber: "123",
					Score: 0,
					Safeties: 0,
					NineOnSnaps: 0,
					BreakAndRuns: 0,
					CurrentlyUp: true
				},
				PlayerTwo:{
					Name: "Player2",
					Rank: 7,
					BallCount: "55",
					Number: "987654",
					TeamNumber: "456",
					Score: 0,
					Safeties: 0,
					NineOnSnaps: 0,
					BreakAndRuns: 0,
					CurrentlyUp: false
				},
				PlayerOneMatchPointsEarned: 0,
				PlayerTwoMatchPointsEarned: 0,
				CurrentGame: {
					PlayerOneScore: 0,
					PlayerTwoScore: 0,
					PlayerOneTimeoutsTaken: 0,
					PlayerTwoTimeoutsTaken: 0,
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
				LeagueMatchId: 0
			});
		});
		
		it('should be able to take a filled Match and turn it into a JSON object', function() {
			match.scoreNumberedBall(1);
			match.shotMissed();
			match.hitDeadBall(2);
			match.shotMissed();
			match.scoreNumberedBall(9);
			match.startNewGame();
			
			expect(match.toJSON()).toEqual({
				PlayerOne: {
					Name: "Player1",
					Rank: 1,
					BallCount: "14",
					Number: "12345",
					TeamNumber: "123",
					Score: 1,
					Safeties: 0,
					NineOnSnaps: 0,
					BreakAndRuns: 0,
					CurrentlyUp: false
				},
				PlayerTwo:{
					Name: "Player2",
					Rank: 7,
					BallCount: "55",
					Number: "987654",
					TeamNumber: "456",
					Score: 2,
					Safeties: 0,
					NineOnSnaps: 0,
					BreakAndRuns: 0,
					CurrentlyUp: true
				},
				PlayerOneMatchPointsEarned: 20,
				PlayerTwoMatchPointsEarned: 0,
				CurrentGame: {
					PlayerOneScore: 0,
					PlayerTwoScore: 0,
					PlayerOneTimeoutsTaken: 0,
					PlayerTwoTimeoutsTaken: 0,
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
				CompletedGames: [{
					PlayerOneScore: 1,
					PlayerTwoScore: 2,
					PlayerOneTimeoutsTaken: 0,
					PlayerTwoTimeoutsTaken: 0,
					NumberOfInnings: 0, 
					PlayerOneNineOnSnap: false,
					PlayerOneBreakAndRun: false,
					PlayerTwoNineOnSnap: false,
					PlayerTwoBreakAndRun: false,
					Ended: true,
					PlayerOneBallsHitIn: [1],
					PlayerTwoBallsHitIn: [9],
					PlayerOneDeadBalls: [2],
					PlayerTwoDeadBalls: [3, 4, 5, 6, 7, 8],
					PlayerOneLastBall: null,
					PlayerTwoLastBall: 9,
					OnBreak: false,
					BreakingPlayerStillHitting: false
				}],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 0
			});
		});
		
		it('should be able to put a matches completed games into a JSON object', function() {
			match.scoreNumberedBall(1);
			match.shotMissed(); //Ending breaking
			match.hitDeadBall(2);
			match.shotMissed();
			match.scoreNumberedBall(9);
			match.startNewGame();
							
			expect(match.completedGamesToJSON()).toEqual([{
				PlayerOneScore: 1,
				PlayerTwoScore: 2,
				PlayerOneTimeoutsTaken: 0,
				PlayerTwoTimeoutsTaken: 0,
				NumberOfInnings: 0, 
				PlayerOneNineOnSnap: false,
				PlayerOneBreakAndRun: false,
				PlayerTwoNineOnSnap: false,
				PlayerTwoBreakAndRun: false,
				Ended: true,
				PlayerOneBallsHitIn: [1],
				PlayerTwoBallsHitIn: [9],
				PlayerOneDeadBalls: [2],
				PlayerTwoDeadBalls: [3, 4, 5, 6, 7, 8],
				PlayerOneLastBall: null,
				PlayerTwoLastBall: 9,
				OnBreak: false,
				BreakingPlayerStillHitting: false
			}]);
		});
		
		it('should be able to take a Player JSON and fill a Player object and return it', function() {
			var player = match.playerFromJSON({
				Name: "James Armstead",
				Rank: 2,
				Number: "4321",
				TeamNumber: "789",
				Score: 12,
				Safeties: 1,
				NineOnSnaps: 2,
				BreakAndRuns: 3,
				CurrentlyUp: false
			});
			expect(player.Name).toEqual("James Armstead");
			expect(player.Rank).toEqual(2);
			expect(player.Number).toEqual("4321");
			expect(player.TeamNumber).toEqual("789");
			expect(player.Score).toEqual(12);
			expect(player.Safeties).toEqual(1);
			expect(player.NineOnSnaps).toEqual(2);
			expect(player.BreakAndRuns).toEqual(3);
			expect(player.BallCount).toEqual("19");
			expect(player.CurrentlyUp).toEqual(false);
			
			player.addOneToNineOnSnaps();
			
			expect(player.NineOnSnaps).toEqual(3);
		});
		
		it('should be able to take a Match JSON and fill its values', function() {
			match = new NineBallMatch();
			match.fromJSON({
				PlayerOne: {
					Name: "Player1",
					Rank: 1,
					BallCount: "14",
					Number: "12345",
					TeamNumber: "123",
					Score: 1,
					Safeties: 0,
					NineOnSnaps: 0,
					BreakAndRuns: 0,
					CurrentlyUp: false
				},
				PlayerTwo:{
					Name: "Player2",
					Rank: 7,
					BallCount: "55",
					Number: "987654",
					TeamNumber: "456",
					Score: 2,
					Safeties: 0,
					NineOnSnaps: 0,
					BreakAndRuns: 0,
					CurrentlyUp: true
				},
				PlayerOneMatchPointsEarned: 20,
				PlayerTwoMatchPointsEarned: 0,
				CurrentGame: {
					PlayerOneScore: 0,
					PlayerTwoScore: 0,
					PlayerOneTimeoutsTaken: 0,
					PlayerTwoTimeoutsTaken: 0,
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
					OnBreak: false,
					BreakingPlayerStillHitting: false
				},
				CompletedGames: [{
					PlayerOneScore: 1,
					PlayerTwoScore: 2,
					PlayerOneTimeoutsTaken: 0,
					PlayerTwoTimeoutsTaken: 0,
					NumberOfInnings: 0, 
					PlayerOneNineOnSnap: false,
					PlayerOneBreakAndRun: false,
					PlayerTwoNineOnSnap: false,
					PlayerTwoBreakAndRun: false,
					Ended: true,
					PlayerOneBallsHitIn: [1],
					PlayerTwoBallsHitIn: [9],
					PlayerOneDeadBalls: [2],
					PlayerTwoDeadBalls: [3, 4, 5, 6, 7, 8],
					PlayerOneLastBall: null,
					PlayerTwoLastBall: 9,
					OnBreak: false,
					BreakingPlayerStillHitting: false
				}],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 0
			});
			expect(match.PlayerOneMatchPointsEarned).toEqual(20);
			expect(match.PlayerTwoMatchPointsEarned).toEqual(0);
			expect(match.Ended).toEqual(false);
			expect(match.OriginalId).toEqual(0);
			expect(match.PlayerOne.Name).toEqual("Player1");
			expect(match.PlayerTwo.Name).toEqual("Player2");
			expect(match.CurrentGame.BreakingPlayerStillHitting).toEqual(false);
			expect(match.CompletedGames[0].BreakingPlayerStillHitting).toEqual(false);
			expect(match.CompletedGames[0].PlayerOneScore).toEqual(1);
		});
		
		it('should be able to take a CompletedGames JSON array and convert it to JS Array with Objects', function() {
			var completedGames = match.completedGamesFromJSON([{
					PlayerOneScore: 1,
					PlayerTwoScore: 2,
					PlayerOneTimeoutsTaken: 0,
					PlayerTwoTimeoutsTaken: 0,
					NumberOfInnings: 0, 
					PlayerOneNineOnSnap: false,
					PlayerOneBreakAndRun: false,
					PlayerTwoNineOnSnap: false,
					PlayerTwoBreakAndRun: false,
					Ended: true,
					PlayerOneBallsHitIn: [1],
					PlayerTwoBallsHitIn: [9],
					PlayerOneDeadBalls: [2],
					PlayerTwoDeadBalls: [3, 4, 5, 6, 7, 8],
					PlayerOneLastBall: null,
					PlayerTwoLastBall: 9,
					OnBreak: false,
					BreakingPlayerStillHitting: false
				}]);
			expect(completedGames[0].PlayerOneScore).toEqual(1);
		});
	});
});