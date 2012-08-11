/**
* @author jamesa
*/
describe('EightBall Game', function () {
	var game;
	var playerOne;
	var playerTwo;
	var matchCallback;

	beforeEach(function() {
		matchCallback = jasmine.createSpy();
		playerOne = new EightBallPlayer("Isaac Wooten", 1, "123", "123");
		playerOne.TimeoutsAllowed = 2;
		playerTwo = new EightBallPlayer("James Armstead", 1, "1", "1");
		playerTwo.TimeoutsAllowed = 2;
		playerOne.CurrentlyUp = true;
	    game = new EightBallGame(function() { return playerOne; }, function() { return playerTwo; }, matchCallback);
	});

	describe('Scoring', function() {
		it('should be able to take a ball number 1-7 and 9-15 and score it correctly', function() {
			game.scoreBall(1);
			expect(game.PlayerOneBallType).toEqual(null);
			expect(game.StripedBallsHitIn).toEqual([]);
			expect(game.SolidBallsHitIn).toEqual([1]);
			game.breakIsOver();
			game.nextPlayerIsUp();
			game.scoreBall(9);
			expect(game.getPlayerOneBallsHitIn()).toEqual([1]);
			expect(game.getPlayerTwoBallsHitIn()).toEqual([9]);
		});

		it('should be able to take ball number 8 and score it correctly', function() {
			game.scoreBall(8);
			expect(game.Ended).toEqual(true);
		});

		it('should only allow each ball to be scored one time', function() {
			expect(game.getBallsHitIn().length).toEqual(0);
			game.scoreBall(1);
			expect(game.getBallsHitIn().length).toEqual(1);
			game.scoreBall(1);
			expect(game.getBallsHitIn().length).toEqual(1);
		});

		it('should be able to get the number of balls types each player has hit in', function() {
            game.scoreBall(1);
            game.breakIsOver(); 
            game.nextPlayerIsUp();
            game.scoreBall(10);
            expect(game.getPlayerOneBallsHitIn().length).toEqual(1);
            expect(game.getPlayerOneBallsHitIn().length).toEqual(1);
        });
	});

	describe('Innings', function() {
		it('should keep track of the number of innings', function() {
			expect(game.NumberOfInnings).toEqual(0);
		});

		it('should be able to add 1 to the number of innings', function() {
			game.addOneToNumberOfInnings();
			expect(game.NumberOfInnings).toEqual(1);
		});

		it('should be able to add 1 to the innings when player2\'s turn is over', function() {
			expect(game.NumberOfInnings).toEqual(0);
			game.nextPlayerIsUp();
			expect(game.NumberOfInnings).toEqual(0);
			expect(playerTwo.CurrentlyUp).toEqual(true);;
			game.nextPlayerIsUp();
			expect(game.NumberOfInnings).toEqual(1);
		});
	});

	describe('Game Ending', function() {
		it('should be able to be ended', function() {
			expect(game.Ended).toBeFalsy()
			game.End();
			expect(game.Ended).toBeTruthy();
		});

		it('should know the match has completed when the 8 his hit in', function() {
			playerOne = new EightBallPlayer("Isaac Wooten", 1, "123", "123");
			playerTwo = new EightBallPlayer("James Armstead", 1, "1", "1");
			playerOne.CurrentlyUp = true;
		    game = new EightBallGame(function() { return playerOne; }, function() { return playerTwo; }, function(){});
			expect(game.Ended).toEqual(false);
			game.scoreBall(8);
			expect(game.Ended).toEqual(true);
		});
	});

    it('should be able to set a game as Scratch On 8', function() {
        expect(game.ScratchOnEight).toEqual(false);
        game.hitScratchOnEight();
        expect(game.ScratchOnEight).toEqual(true);
        expect(game.Ended).toEqual(true);
        expect(game.PlayerTwoWon).toEqual(true);
        expect(playerTwo.CurrentlyUp).toEqual(true);
    });

	describe('Player Timeouts', function() {
		it('should allow the currentplayer to be able to take a timeout', function() {
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('2');
			game.takeTimeout();
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('1');
		});

		it('should not allow the current player to take more time outs than given', function() {
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('2');
			game.takeTimeout();
			game.takeTimeout();
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('0');
			game.takeTimeout();
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('0');
		});

		it('should be able to return the current player\'s remaining number of timeouts', function() {
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('2');
			game.takeTimeout();
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('1');
			game.takeTimeout();
			expect(game.getCurrentPlayerRemainingTimeouts()).toEqual('0');
		});
	});

    it('should be able to make a player win and add one to games won', function() {
        game.setPlayerOneWon();
        expect(game.PlayerOneWon).toEqual(true);
        expect(game.PlayerTwoWon).toEqual(false);
        expect(game.PlayerOneCallback().GamesWon).toEqual(1);
        expect(game.PlayerTwoCallback().GamesWon).toEqual(0);
        game.setPlayerTwoWon();
        expect(game.PlayerOneWon).toEqual(true);
        expect(game.PlayerTwoWon).toEqual(true);
        expect(game.PlayerOneCallback().GamesWon).toEqual(1);
        expect(game.PlayerTwoCallback().GamesWon).toEqual(1);
    });

    it('should end the game and give currently player up the win if they pocket the 8 ball on break', function() {
        expect(game.PlayerOneWon).toEqual(false);
        game.scoreBall(8);
        expect(game.PlayerOneWon).toEqual(true);
        expect(game.PlayerTwoWon).toEqual(false);
    });

    it('should be able to end the break if no balls were hit in',function() {
        game.nextPlayerIsUp();
        expect(game.OnBreak).toEqual(false);
        expect(game.BreakingPlayerStillHitting).toEqual(false);
    });

	it('should be able to change who is currentlyup', function() {
		game.nextPlayerIsUp();
		expect(playerTwo.CurrentlyUp).toEqual(true);
		game.nextPlayerIsUp();
		expect(playerOne.CurrentlyUp).toEqual(true);
	});

	it('should be able to know if a player is still breaking(balls scored) when they use NextPlayerIsUp while breaking', function() {
		expect(game.OnBreak).toEqual(true);
		game.scoreBall(1);
		game.nextPlayerIsUp();
		expect(playerTwo.CurrentlyUp).toEqual(false);
		expect(playerOne.CurrentlyUp).toEqual(true);
	});

	it('should be able to know if a players turn is over(no balls scored) when they use NextPlayerIsUp while breaking', function() {
		expect(game.OnBreak).toEqual(true);
		game.nextPlayerIsUp();
		expect(playerTwo.CurrentlyUp).toEqual(true);
		expect(playerOne.CurrentlyUp).toEqual(false);
	});

	it('should be able to keep track if player one had 8 on snap', function() {
		expect(game.PlayerOneEightOnSnap).toEqual(false);
	});

	it('should be able to keep track if player one had break and run', function() {
		expect(game.PlayerOneBreakAndRun).toEqual(false);
	});

	it('should be able to keep track if player two had 8 on snap', function() {
		expect(game.PlayerTwoEightOnSnap).toEqual(false);
	});

	it('should be able to keep track if player one two break and run', function() {
		expect(game.PlayerTwoBreakAndRun).toEqual(false);
	});

	it('should know if the 8 ball is pocketed on the break and give the current player a EightOnSnap', function() {
		expect(game.PlayerOneEightOnSnap).toEqual(false);
		game.scoreBall(8);
		expect(game.PlayerOneEightOnSnap).toEqual(true);
		expect(playerOne.EightOnSnaps).toEqual(1);
	});

	it('should know if the 8 ball is not pocketed on the break and not give the current player a EightOnSnap', function() {
		game.scoreBall(1);
		game.breakIsOver();
		expect(game.PlayerOneEightOnSnap).toEqual(false);
		game.scoreBall(8);
		expect(game.PlayerOneEightOnSnap).toEqual(false);
		expect(playerOne.EightOnSnaps).toEqual(0);
	});

	it('should know when a player has hit all the balls in and is still breaking and only give them a 8BR', function() {
		game.scoreBall(1);
		game.scoreBall(2);
		game.scoreBall(3);
		game.scoreBall(4);
		game.scoreBall(5);
		game.scoreBall(6);
		game.scoreBall(7);
		game.scoreBall(8);
		expect(game.PlayerOneEightOnSnap).toEqual(false);
		expect(game.SolidBallsHitIn.length).toEqual(7);
		expect(game.Ended).toEqual(true);
		expect(game.PlayerOneCallback().BreakAndRuns).toEqual(1);
		expect(game.PlayerOneBreakAndRun).toEqual(true);
	});

	it('should be able to set player one to have a eight on snap and if not already true add one to that players total eight on snaps.', function() {
		expect(game.PlayerOneEightOnSnap).toEqual(false);
		game.setPlayerOneEightOnSnap();
		expect(game.PlayerOneEightOnSnap).toEqual(true);
		expect(playerOne.EightOnSnaps).toEqual(1);
		game.setPlayerOneEightOnSnap();
		expect(playerOne.EightOnSnaps).toEqual(1);
	});

	it('should be able to set player two to have a eight on snap and if not already true add one to that players total eight on snaps.', function() {
		expect(game.PlayerTwoEightOnSnap).toEqual(false);
		game.setPlayerTwoEightOnSnap();
		expect(game.PlayerTwoEightOnSnap).toEqual(true);
		expect(playerTwo.EightOnSnaps).toEqual(1);
		game.setPlayerTwoEightOnSnap();
		expect(playerTwo.EightOnSnaps).toEqual(1);
	});

	it('should be able to set player one to have a break and run and if not already true add one to that players total break and runs.', function() {
		expect(game.PlayerOneBreakAndRun).toEqual(false);
		game.setPlayerOneBreakAndRun();
		expect(game.PlayerOneBreakAndRun).toEqual(true);
		expect(playerOne.BreakAndRuns).toEqual(1);
		game.setPlayerOneBreakAndRun();
		expect(playerOne.BreakAndRuns).toEqual(1);
	});

    it('should be able to tell if the game is an early eight ball', function() {
        game.shotMissed();
        game.scoreBall(8);
        expect(game.EarlyEight).toEqual(true);
    });

	it('should be able to set player two to have a break and run and if not already true add one to that players total break and runs.', function() {
		expect(game.PlayerTwoBreakAndRun).toEqual(false);
		game.setPlayerTwoBreakAndRun();
		expect(game.PlayerTwoBreakAndRun).toEqual(true);
		expect(playerTwo.BreakAndRuns).toEqual(1);
		game.setPlayerTwoBreakAndRun();
		expect(playerTwo.BreakAndRuns).toEqual(1);
	});

	it('should know when the player breaks and then continues on to all the balls in without missing one', function() {
		expect(game.OnBreak).toEqual(true);
		game.scoreBall(1);
		game.nextPlayerIsUp();
		game.scoreBall(2);
		game.scoreBall(3);
		game.scoreBall(4);
		game.scoreBall(5);
		game.scoreBall(6);
		game.scoreBall(7);
		game.scoreBall(8);
		expect(game.OnBreak).toEqual(false);
		expect(game.BreakingPlayerStillHitting).toEqual(true);
		expect(game.PlayerOneBreakAndRun).toEqual(true);
		expect(playerOne.BreakAndRuns).toEqual(1);
	});

    it('should able to assign a ball type after the break if only one ball type has been hit in', function() {
        game.scoreBall(1);
        game.nextPlayerIsUp();
        expect(game.PlayerOneBallType).toEqual(2);
        expect(game.PlayerTwoBallType).toEqual(1);
    });

    it('should able to assign a ball type after the break if only one ball type has been hit in', function() {
        game.scoreBall(9);
        game.nextPlayerIsUp();
        expect(game.PlayerOneBallType).toEqual(1);
        expect(game.PlayerTwoBallType).toEqual(2);
    });

	it('should be able to keep track of which solid balls have been hit in', function() {
		expect(game.SolidBallsHitIn.length).toEqual(0);
		game.scoreBall(1);
		game.scoreBall(2);
		game.scoreBall(3);
		game.scoreBall(4);
		expect(game.SolidBallsHitIn.length).toEqual(4);
		expect(game.SolidBallsHitIn[0]).toEqual(1);
		expect(game.SolidBallsHitIn[1]).toEqual(2);
		expect(game.SolidBallsHitIn[2]).toEqual(3);
		expect(game.SolidBallsHitIn[3]).toEqual(4);
	});

	it('should be able to keep track of which striped balls have been hit in', function() {
		expect(game.StripedBallsHitIn.length).toEqual(0);
		game.scoreBall(9);
		game.scoreBall(10);
		game.scoreBall(11);
		game.scoreBall(12);
		expect(game.StripedBallsHitIn.length).toEqual(4);
		expect(game.StripedBallsHitIn[0]).toEqual(9);
		expect(game.StripedBallsHitIn[1]).toEqual(10);
		expect(game.StripedBallsHitIn[2]).toEqual(11);
		expect(game.StripedBallsHitIn[3]).toEqual(12);
	});

    it('should be able to set player one to striped balls', function() {
        expect(game.PlayerOneBallType).toEqual(null);
        game.setPlayerOneBallTypeToStriped();
        expect(game.PlayerOneBallType).toEqual(game.STRIPS);
        expect(game.PlayerTwoBallType).toEqual(game.SOLIDS);
    });

    it('should be able to set player one to solid balls', function() {
        expect(game.PlayerOneBallType).toEqual(null);
        game.setPlayerOneBallTypeToSolid();
        expect(game.PlayerOneBallType).toEqual(game.SOLIDS);
        expect(game.PlayerTwoBallType).toEqual(game.STRIPS);
    });

    it('should be able to set player two to striped balls', function() {
        expect(game.PlayerTwoBallType).toEqual(null);
        game.setPlayerTwoBallTypeToStriped();
        expect(game.PlayerTwoBallType).toEqual(game.STRIPS);
        expect(game.PlayerOneBallType).toEqual(game.SOLIDS);
    });

    it('should be able to set player two to solid balls', function() {
        expect(game.PlayerTwoBallType).toEqual(null);
        game.setPlayerTwoBallTypeToSolid();
        expect(game.PlayerTwoBallType).toEqual(game.SOLIDS);
        expect(game.PlayerOneBallType).toEqual(game.STRIPS);
    });

	it('should be able to find out if there is a winner if a player hits a BR and set that player to won', function() {
	    game.scoreBall(1);
		game.scoreBall(2);
		game.scoreBall(3);
		game.scoreBall(4);
		expect(game.PlayerOneWon).toEqual(false);
		game.scoreBall(5);
		game.scoreBall(6);
		game.scoreBall(7);
		game.scoreBall(8);
		expect(game.getPlayerOneBallsHitIn().exists(8)).toEqual(true);
		expect(game.PlayerOneWon).toEqual(true);
	});

	it('should be able to find out if there is a winner if player two wins and set that player to won', function() {
	    game.scoreBall(1);
	    game.breakIsOver();
	    game.nextPlayerIsUp();
	    game.checkForWinner();
		expect(game.PlayerOneWon).toEqual(false);
		game.scoreBall(9);
		game.scoreBall(10);
		game.scoreBall(11);
		game.scoreBall(12);
		game.scoreBall(13);
		game.scoreBall(14);
		game.scoreBall(15);
		game.scoreBall(8);
		expect(game.PlayerTwoWon).toEqual(true);
	});

	it('should be able to find out if there is a winner after ball type has been selected and set that player to won', function() {
	    game.scoreBall(1);
	    game.scoreBall(10);
	    game.breakIsOver();
	    game.nextPlayerIsUp();
	    game.checkForWinner();
		expect(game.PlayerOneWon).toEqual(false);
		game.scoreBall(9);
		game.setPlayerTwoBallTypeToSolid();
		game.scoreBall(11);
		game.scoreBall(12);
		game.scoreBall(13);
		game.scoreBall(14);
		game.scoreBall(15);
		game.scoreBall(8);
		expect(game.PlayerTwoWon).toEqual(true);
	});

	it('should return winning players name', function() {
	    game.scoreBall(1);
		game.scoreBall(2);
		game.scoreBall(3);
		game.scoreBall(4);
		game.scoreBall(5);
		game.scoreBall(6);
		game.scoreBall(7);
		game.scoreBall(8);
		expect(game.getWinningPlayerName()).toEqual("Isaac W.");
	});

	it('should be able to return a list of all balls that have been hit in', function() {
		game.scoreBall(1);
		expect(game.getBallsHitIn()).toEqual([1]);
		game.nextPlayerIsUp();
		game.scoreBall(2);
		game.scoreBall(10);
		expect(game.getBallsHitIn()).toEqual([1,2,10]);
	});
	
	it('should be able to hit a safety', function() {
		game.hitSafety();
		expect(game.PlayerOneCallback().Safeties).toEqual(1);
		game.hitSafety();
		expect(game.PlayerTwoCallback().Safeties).toEqual(1);
	});

	it('should end the current players turn when they hit a safety', function() {
		game.hitSafety();
		expect(game.PlayerOneCallback().Safeties).toEqual(1);
		expect(game.getCurrentlyUpPlayer().Name).toEqual("James Armstead");
	});

	it('should be able to return the game score with player one\'s score first (example 2-3)', function(){
		game.scoreBall(1);
		game.scoreBall(4);
		game.nextPlayerIsUp(); //Ending the Break
		game.nextPlayerIsUp(); //Misses all balls
		game.scoreBall(10);
		game.scoreBall(11);
		game.scoreBall(12);
		expect(game.getGameScore()).toEqual("2-3");
	});

	it('should be able to have a state of breaking', function() {
		expect(game.OnBreak).toEqual(true);
	});

	it('should be able to have change the breaking state to false', function() {
		expect(game.OnBreak).toEqual(true);
		game.breakIsOver();
		expect(game.OnBreak).toEqual(false);
	});

	it('should know if the breaking player is still up', function() {
		expect(game.BreakingPlayerStillHitting).toEqual(true);
		game.scoreBall(2);
		game.nextPlayerIsUp(); //Ends Breaking
		game.scoreBall(3);
		game.scoreBall(5);
		expect(game.BreakingPlayerStillHitting).toEqual(true);
		game.nextPlayerIsUp();
		expect(game.BreakingPlayerStillHitting).toEqual(false);
	});

	it('should be able to keep track of the last ball scored', function() {
		expect(game.LastBallHitIn).toEqual(null);
		game.scoreBall(1);
		expect(game.LastBallHitIn).toEqual(1);
		game.scoreBall(3);
		expect(game.LastBallHitIn).toEqual(3);
		game.nextPlayerIsUp(); //Ending the break
		game.nextPlayerIsUp(); //All balls are missed
		game.scoreBall(4);
		expect(game.LastBallHitIn).toEqual(4);
	});

    it('should end the game if a player hits the 8 ball in when it is not their last ball or on break', function() {
        	game.scoreBall(1);
			game.nextPlayerIsUp();
			game.scoreBall(12);
			game.nextPlayerIsUp();
			game.scoreBall(8);
			expect(game.PlayerTwoEightBall).toEqual([8]);
			expect(game.Ended).toEqual(true);
			expect(game.PlayerOneWon).toEqual(true);
    });

	describe('toJSON/fromJSON', function() {
		it('should be able to take a new Game and turn it into a JSON object', function() {
			expect(game.toJSON()).toEqual({
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
			});
		});

		it('should be able to take a filled up Game and turn it into a JSON object', function() {
			game.PlayerTwoBallsHitIn = 2;
			game.PlayerTwoBallsHitIn = 13;
			game.NumberOfInnings = 2;
			game.PlayerOneEightOnSnap = true;
			game.PlayerOneBreakAndRun = false;
			game.PlayerTwoEightOnSnap = true;
			game.PlayerTwoBreakAndRun = true;
			game.PlayerOneBallType = 1;
			game.PlayerTwoBallType = 2;
			game.PlayerOneEightBall = [];
			game.PlayerTwoEightBall = [8];
			game.PlayerOneWon = true;
			game.PlayerTwoWon = false;
			game.Ended = true;
			game.StripedBallsHitIn = [1,2];
			game.SolidBallsHitIn = [9,10];
			game.LastBallHitIn = 1;
			game.OnBreak = false;
			game.BreakingPlayerStillHitting = false;
			game.PlayerOneCallback().CurrentlyUp = true;
			game.takeTimeout();

			expect(game.toJSON()).toEqual({
				PlayerOneTimeoutsTaken: 1,
				PlayerTwoTimeoutsTaken: 0,
				NumberOfInnings: 2,
				PlayerOneEightOnSnap: true,
				PlayerOneBreakAndRun: false,
				PlayerTwoEightOnSnap: true,
				PlayerTwoBreakAndRun: true,
				PlayerOneBallType: 1,
				PlayerTwoBallType: 2,
				PlayerOneEightBall: [],
				PlayerTwoEightBall: [8],
				PlayerOneWon: true,
				PlayerTwoWon: false,
				Ended: true,
				StripedBallsHitIn: [1,2],
				SolidBallsHitIn: [9,10],
				LastBallHitIn: 1,
				OnBreak: false,
				BreakingPlayerStillHitting: false
			});
		});

		it('should be able to take a Game JSON and fill a Game object with it', function() {
			game.fromJSON({
				PlayerOneTimeoutsTaken: 1,
				PlayerTwoTimeoutsTaken: 0,
				NumberOfInnings: 3,
				PlayerOneEightOnSnap: false,
				PlayerOneBreakAndRun: true,
				PlayerTwoEightOnSnap: false,
				PlayerTwoBreakAndRun: false,
				PlayerOneBallType: 1,
				PlayerTwoBallType: 2,
				PlayerOneEightBall: [8],
				PlayerTwoEightBall: [],
				PlayerOneWon: false,
				PlayerTwoWon: true,
				Ended: true,
				StripedBallsHitIn: [2],
				SolidBallsHitIn: [10],
				LastBallHitIn: 2,
				OnBreak: false,
				BreakingPlayerStillHitting: false
			});

			expect(game.NumberOfInnings).toEqual(3);
			expect(game.PlayerOneTimeoutsTaken).toEqual(1);
			expect(game.PlayerTwoTimeoutsTaken).toEqual(0);
			expect(game.PlayerOneEightOnSnap).toEqual(false);
			expect(game.PlayerOneBreakAndRun).toEqual(true);
			expect(game.PlayerTwoEightOnSnap).toEqual(false);
			expect(game.PlayerTwoBreakAndRun).toEqual(false);
			expect(game.PlayerOneBallType).toEqual(1);
			expect(game.PlayerTwoBallType).toEqual(2);
			expect(game.PlayerOneEightBall).toEqual([8]);
			expect(game.PlayerTwoEightBall).toEqual([]);
			expect(game.PlayerOneWon).toEqual(false);
			expect(game.PlayerTwoWon).toEqual(true);
			expect(game.Ended).toEqual(true);
			expect(game.StripedBallsHitIn).toEqual([2]);
			expect(game.SolidBallsHitIn).toEqual([10]);
			expect(game.LastBallHitIn).toEqual(2);
			expect(game.OnBreak).toEqual(false);

			game.addOneToNumberOfInnings();
			expect(game.NumberOfInnings).toEqual(4);

		});

	});
});