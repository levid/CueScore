/**
* @author jamesa
*/
describe('EightBall Match', function () {
		var match;

    beforeEach(function() {
        match = new EightBallMatch("Player1", "Player2", 2, 7, "12345", "987654", "123", "456");
        match.PlayerOne.CurrentlyUp = true;
    });

	describe('Constructor', function() {
  		it('should have 2 players', function() {
			expect(match.PlayerOne.Name).toEqual("Player1");
			expect(match.PlayerOne.Rank).toEqual(2);
			expect(match.PlayerOne.Number).toEqual("12345");
			expect(match.PlayerOne.TeamNumber).toEqual("123");
			expect(match.PlayerOne.GamesNeededToWin).toEqual(2);
			expect(match.PlayerTwo.Name).toEqual("Player2");
			expect(match.PlayerTwo.Rank).toEqual(7);
			expect(match.PlayerTwo.Number).toEqual("987654");
			expect(match.PlayerTwo.TeamNumber).toEqual("456");
			expect(match.PlayerTwo.GamesNeededToWin).toEqual(7);
		});

		it('should set Player 1 to break first', function() {
			expect(match.PlayerOne.CurrentlyUp).toEqual(true);
		});

		it('should create the first Game and set it to CurrentGame', function() {
			expect(match.CurrentGame).toNotEqual(null);
		});
	});

	describe('Scoring', function() {
		it('should accept a number for the ball that was hit in', function() {
			match.scoreNumberedBall(1);
		});

		it('should add 1 to the respective ball type array when a ball is scored', function() {
			match.scoreNumberedBall(1);
			expect(match.CurrentGame.SolidBallsHitIn).toEqual([1]);
			match.scoreNumberedBall(12);
			expect(match.CurrentGame.StripedBallsHitIn).toEqual([12]);
		});
	});

	describe('Match/Game Ending', function() {
        it('should know when the match is completed', function() {
            expect(match.getPlayerOneRemainingGamesNeededToWin()).toEqual('2');
            match.scoreNumberedBall(1);
            match.scoreNumberedBall(2);
            match.scoreNumberedBall(3);
            match.scoreNumberedBall(4);
            match.scoreNumberedBall(5);
            match.scoreNumberedBall(6);
            match.scoreNumberedBall(7);
            match.scoreNumberedBall(8);
            expect(match.getPlayerOneRemainingGamesNeededToWin()).toEqual('1');
			expect(match.CurrentGame.Ended).toEqual(true);
			expect(match.CurrentGame.PlayerOneWon).toEqual(true);
			expect(match.Ended).toEqual(false);
			match.startNewGame();
            match.scoreNumberedBall(1);
            match.scoreNumberedBall(2);
            match.scoreNumberedBall(3);
            match.scoreNumberedBall(4);
            match.scoreNumberedBall(5);
            match.scoreNumberedBall(6);
            match.scoreNumberedBall(7);
            match.scoreNumberedBall(8);
            expect(match.getPlayerOneRemainingGamesNeededToWin()).toEqual('0');
			expect(match.Ended).toEqual(true);
		});

		it('should be able to find the remaining games needed to win for player one', function() {
            expect(match.getPlayerOneRemainingGamesNeededToWin()).toEqual('2');
            match.scoreNumberedBall(1);
            match.scoreNumberedBall(2);
            match.scoreNumberedBall(3);
            match.scoreNumberedBall(4);
            match.scoreNumberedBall(5);
            match.scoreNumberedBall(6);
            match.scoreNumberedBall(7);
            match.scoreNumberedBall(8);
            expect(match.getPlayerOneRemainingGamesNeededToWin()).toEqual('1');
	    });

		it('should be able to find the remaining games needed to win for player two', function() {
            expect(match.getPlayerTwoRemainingGamesNeededToWin()).toEqual('7');
            match.shotMissed();
            match.scoreNumberedBall(1);
            match.scoreNumberedBall(2);
            match.scoreNumberedBall(3);
            match.scoreNumberedBall(4);
            match.scoreNumberedBall(5);
            match.scoreNumberedBall(6);
            match.scoreNumberedBall(7);
            match.scoreNumberedBall(8);
            match.CurrentGame.setPlayerTwoBallTypeToStriped();
            expect(match.CurrentGame.PlayerTwoWon).toEqual(true);
            expect(match.getPlayerTwoRemainingGamesNeededToWin()).toEqual('6');
	    });

		it('should add current game to the CompletedGames list and start a new Game when the game has completed', function() {
			expect(match.CompletedGames.length).toEqual(0);
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			match.startNewGame();
			expect(match.CompletedGames.length).toEqual(1);
			expect(match.CurrentGame.Ended).toEqual(false);
			expect(match.CompletedGames[0].Ended).toEqual(true);
		});

		it('should know if the match is completed', function() {
			expect(match.Ended).toEqual(false);
		});

		it('should hold multiple completed games', function() {
			expect(match.CompletedGames).toNotEqual(null);
		});
	});

	describe('Players', function() {
		it('should be able to have the Rank changed and have the BallCounts and TimeoutsAllowed automatically', function() {
            expect(match.PlayerOne.GamesNeededToWin).toEqual(2); //Opponent is a 7
            expect(match.PlayerTwo.GamesNeededToWin).toEqual(7); //Opponent is a 2
            expect(match.PlayerOne.TimeoutsAllowed).toEqual(2);

            match.PlayerOne.Rank = 7;
            match.resetPlayerRankStats();

            expect(match.PlayerOne.GamesNeededToWin).toEqual(5); //Opponent is a 7
            expect(match.PlayerOne.TimeoutsAllowed).toEqual(1);
            expect(match.PlayerTwo.GamesNeededToWin).toEqual(5); //Opponent is a 7
	    });

		it('should change currently up player on missed shot', function() {
			expect(match.PlayerOne.CurrentlyUp).toEqual(true);
			match.shotMissed();
			expect(match.PlayerTwo.CurrentlyUp).toEqual(true);
		});

		it('should be able to get the player twos games won', function() {
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.getPlayerTwoGamesWon()).toEqual(0);
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(9);
			match.scoreNumberedBall(10);
			match.scoreNumberedBall(11);
			match.scoreNumberedBall(12);
			match.scoreNumberedBall(13);
			match.scoreNumberedBall(14);
			match.scoreNumberedBall(15);
			match.scoreNumberedBall(8);
			expect(match.getPlayerTwoGamesWon()).toEqual(1);
			match.startNewGame()
			expect(match.getPlayerTwoGamesWon()).toEqual(1);
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			match.scoreNumberedBall(5);
			match.scoreNumberedBall(6);
			match.scoreNumberedBall(7);
			match.scoreNumberedBall(8);
			expect(match.getPlayerTwoGamesWon()).toEqual(2);
		});

		it('should be able to get the the games won. (example 2-0)', function() {
			expect(match.getMatchPoints()).toEqual('TIE');
			match.scoreNumberedBall(1);
			match.scoreNumberedBall(2);
			match.scoreNumberedBall(3);
			match.scoreNumberedBall(4);
			expect(match.getMatchPoints()).toEqual('TIE');
			match.shotMissed(); //Ending Break
			match.shotMissed(); //All Balls are missed
			match.scoreNumberedBall(9);
			match.scoreNumberedBall(10);
			match.scoreNumberedBall(11);
			match.scoreNumberedBall(12);
			match.scoreNumberedBall(13);
			match.scoreNumberedBall(14);
			match.scoreNumberedBall(15);
			match.scoreNumberedBall(8);
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
			expect(match.getMatchPoints()).toEqual('0-1');
		});
	});

    it('should be able to get the winning player', function() {
    	match.scoreNumberedBall(1);
		match.scoreNumberedBall(2);
		match.scoreNumberedBall(3);
		match.scoreNumberedBall(4);
		match.scoreNumberedBall(5);
		match.scoreNumberedBall(6);
		match.scoreNumberedBall(7);
		match.scoreNumberedBall(8);
		match.startNewGame();
		expect(match.getWinningPlayer().Name).toEqual("Player1");
    });

    it('should be able to return playerones match points', function() {
        expect(match.getPlayerOneMatchPoints()).toEqual(0);
        match.scoreNumberedBall(8);
        expect(match.getPlayerOneMatchPoints()).toEqual(1);
    });

    it('should be able to return playertwos match points', function() {
        expect(match.getPlayerTwoMatchPoints()).toEqual(0);
        match.shotMissed();
        match.scoreNumberedBall(8);
        match.startNewGame();
        match.scoreNumberedBall(8);
        match.startNewGame();
        match.scoreNumberedBall(8);
        match.startNewGame();
        match.scoreNumberedBall(8);
        match.startNewGame();
        match.scoreNumberedBall(8);
        expect(match.getPlayerTwoMatchPoints()).toEqual(1);
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

	it('should be able to hold on to the OriginalId from the database', function() {
		expect(match.OriginalId).toEqual(0);
	});

	it('should be able to hold on to the LeagueMatchId from the database', function() {
		expect(match.LeagueMatchId).toEqual(0);
	});

    it('should be able to know when the last thing that happened was a player switch', function() {
        expect(match.ArePlayersSwitching).toEqual(false);
        match.shotMissed();
        expect(match.ArePlayersSwitching).toEqual(true);
        match.scoreNumberedBall(1);
        expect(match.ArePlayersSwitching).toEqual(false);
    });

    it('should be able to put match into sudden death mode', function() {
        expect(match.SuddenDeath).toEqual(false);
        expect(match.PlayerOne.GamesNeededToWin).toEqual(2);
        expect(match.PlayerTwo.GamesNeededToWin).toEqual(7);
        match.setSuddenDeathMode();
        expect(match.SuddenDeath).toEqual(true);
        expect(match.PlayerOne.GamesNeededToWin).toEqual(1);
        expect(match.PlayerTwo.GamesNeededToWin).toEqual(1);  
    });

    it('should switch players if eight ball is hit in without all other 7 balls', function() {
        match.shotMissed();
        expect(match.PlayerTwo.CurrentlyUp).toEqual(true);
        expect(match.PlayerOne.CurrentlyUp).toEqual(false);
        match.scoreNumberedBall(8);
        expect(match.PlayerOne.CurrentlyUp).toEqual(true);
        expect(match.PlayerTwo.CurrentlyUp).toEqual(false);
    });

	it('should be able to know the current game number', function() {
		expect(match.getCurrentGameNumber()).toEqual('1');
		match.scoreNumberedBall(1);
		match.scoreNumberedBall(2);
		match.scoreNumberedBall(3);
		match.scoreNumberedBall(4);
		match.scoreNumberedBall(5);
		match.scoreNumberedBall(6);
		match.scoreNumberedBall(7);
		match.scoreNumberedBall(8);
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
		match.scoreNumberedBall(8);
		match.startNewGame();
		expect(match.CurrentGame.PlayerOneTimeoutsTaken).toEqual(0);
		expect(match.CurrentGame.PlayerTwoTimeoutsTaken).toEqual(0);
	});

    it('should be able to tell who won the entire match', function() {
        expect(match.PlayerOneWon).toEqual(false);
        expect(match.PlayerTwoWon).toEqual(false);
        match.scoreNumberedBall(8);
		match.startNewGame();
		match.scoreNumberedBall(8);
		expect(match.getPlayerOneRemainingGamesNeededToWin()).toEqual('0');
        expect(match.PlayerOneWon).toEqual(true);
    });

	describe('toJSON/fromJSON', function() {
		it('should be able to take a new Match and turn it into a JSON object', function() {
			expect(match.toJSON()).toEqual({
				PlayerOne: {
				Name: "Player1",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "12345",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 7,
				GamesNeededToWin: 7,
				Number: "987654",
				TeamNumber: "456",
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
				LeagueMatchId: 0
			});
		});

		it('should be able to take a filled Match and turn it into a JSON object', function() {
			match.scoreNumberedBall(1);
			match.shotMissed();
			match.scoreNumberedBall(12);
			match.shotMissed();
			match.scoreNumberedBall(8);
			match.startNewGame();
            expect(match.toJSON()).toEqual({
				PlayerOne: {
				Name: "Player1",
				Rank: 2,
				GamesNeededToWin: 2,
				Number: "12345",
				TeamNumber: "123",
				GamesWon: 1,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 7,
				GamesNeededToWin: 7,
				Number: "987654",
				TeamNumber: "456",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerOneGamesWon: 1,
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
				CompletedGames: [{
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: 2,
                    PlayerTwoBallType: 1,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [8],
                    PlayerOneWon: true,
                    PlayerTwoWon: false,
                    Ended: true,
                    StripedBallsHitIn: [12],
                    SolidBallsHitIn: [1],
                    LastBallHitIn: 8,
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
			match.scoreNumberedBall(15);
			match.shotMissed();
			match.scoreNumberedBall(8);
			match.startNewGame();

			expect(match.completedGamesToJSON()).toEqual([{
                PlayerOneTimeoutsTaken: 0,
                PlayerTwoTimeoutsTaken: 0,
                NumberOfInnings: 0,
                PlayerOneEightOnSnap: false,
                PlayerOneBreakAndRun: false,
                PlayerTwoEightOnSnap: false,
                PlayerTwoBreakAndRun: false,
                PlayerOneBallType: 2,
                PlayerTwoBallType: 1,
                PlayerOneEightBall: [],
                PlayerTwoEightBall: [8],
                PlayerOneWon: true,
                PlayerTwoWon: false,
                Ended: true,
                StripedBallsHitIn: [15],
                SolidBallsHitIn: [1],
                LastBallHitIn: 8,
                OnBreak: false,
                BreakingPlayerStillHitting: false
            }]);
		});

		it('should be able to take a Player JSON and fill a Player object and return it', function() {
			var player = match.playerFromJSON({
				Name: "James Armstead",
				Rank: 2,
				GamesNeededToWin: 0,
				Number: "4321",
				TeamNumber: "789",
				GamesWon: 1,
				Safeties: 1,
				EightOnSnaps: 2,
				BreakAndRuns: 3,
				CurrentlyUp: true
			});
			expect(player.Name).toEqual("James Armstead");
			expect(player.Rank).toEqual(2);
			expect(player.Number).toEqual("4321");
			expect(player.TeamNumber).toEqual("789");
			expect(player.GamesWon).toEqual(1);
			expect(player.Safeties).toEqual(1);
			expect(player.EightOnSnaps).toEqual(2);
			expect(player.BreakAndRuns).toEqual(3);
			expect(player.CurrentlyUp).toEqual(true);

			player.addOneToEightOnSnaps();

			expect(player.EightOnSnaps).toEqual(3);
		});

		it('should be able to take a Match JSON and fill its values', function() {
			match.fromJSON({
				PlayerOne: {
				Name: "Player1",
				Rank: 2,
				Number: "12345",
				TeamNumber: "123",
				GamesWon: 0,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			    },
				PlayerTwo:{
				Name: "Player2",
				Rank: 7,
				Number: "897654",
				TeamNumber: "456",
				GamesWon: 1,
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: true
			    },
				PlayerOneGamesWon: 0,
				PlayerTwoGamesWon: 1,
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
				CompletedGames: [{
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: null,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [8],
                    PlayerTwoEightBall: [],
                    PlayerOneWon: false,
                    PlayerTwoWon: true,
                    Ended: true,
                    StripedBallsHitIn: [1],
                    SolidBallsHitIn: [12],
                    LastBallHitIn: 8,
                    OnBreak: false,
                    BreakingPlayerStillHitting: false
                }],
				Ended: false,
				OriginalId: 0,
				LeagueMatchId: 0
			});
			expect(match.getPlayerOneGamesWon()).toEqual(0);
			expect(match.getPlayerTwoGamesWon()).toEqual(1);
			expect(match.Ended).toEqual(false);
			expect(match.OriginalId).toEqual(0);
			expect(match.PlayerOne.Name).toEqual("Player1");
			expect(match.PlayerTwo.Name).toEqual("Player2");
			expect(match.CurrentGame.BreakingPlayerStillHitting).toEqual(true);
			expect(match.CompletedGames[0].BreakingPlayerStillHitting).toEqual(false);
			expect(match.CompletedGames[0].PlayerTwoWon).toEqual(true);
			expect(match.PlayerOne.getGamesNeededToWin()).toEqual("2");
		});

		it('should be able to take a CompletedGames JSON array and convert it to JS Array with Objects', function() {
			var completedGames = match.completedGamesFromJSON([{
                    PlayerOneTimeoutsTaken: 0,
                    PlayerTwoTimeoutsTaken: 0,
                    NumberOfInnings: 0,
                    PlayerOneEightOnSnap: false,
                    PlayerOneBreakAndRun: false,
                    PlayerTwoEightOnSnap: false,
                    PlayerTwoBreakAndRun: false,
                    PlayerOneBallType: 1,
                    PlayerTwoBallType: null,
                    PlayerOneEightBall: [],
                    PlayerTwoEightBall: [8],
                    PlayerOneWon: true,
                    PlayerTwoWon: false,
                    Ended: true,
                    StripedBallsHitIn: [1],
                    SolidBallsHitIn: [12],
                    LastBallHitIn: 12,
                    OnBreak: false,
                    BreakingPlayerStillHitting: false
                }]);
			expect(completedGames[0].getPlayerOneBallsHitIn()).toEqual([1]);
			expect(completedGames[0].PlayerOneWon).toEqual(true);
		});
	});
});