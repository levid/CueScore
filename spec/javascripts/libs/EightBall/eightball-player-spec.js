/**
* @author jamesa
*/
describe('Eight Ball Player', function () {
    var player;

    beforeEach(function() {
        player = new EightBallPlayer("Isaac Wooten", 1, "123456", "123");
    });

	describe('Constructor', function() {
  		it('should store the parameters', function() {
			expect(player.Name).toEqual("Isaac Wooten");
			expect(player.Rank).toEqual(1);
			expect(player.Number).toEqual("123456");
			expect(player.TeamNumber).toEqual("123");
		});
	});

	it('should have Games Won', function() {
		expect(player.GamesWon).toEqual(0);
	});

    it('should be able to return a string of the games needed to win', function() {
        player.GamesNeededToWin = 2;
        expect(player.getGamesNeededToWin()).toEqual("2");
    });

	it('should be able to add a game win to total games won', function() {
		expect(player.GamesWon).toEqual(0);
		player.addOneToGamesWon();
		expect(player.GamesWon).toEqual(1);
		player.addOneToGamesWon();
		expect(player.GamesWon).toEqual(2);
    });

    it('should know if the player is a captain', function() {
        expect(player.IsCaptain).toEqual(false);
        player.IsCaptain = true;
        expect(player.IsCaptain).toEqual(true);
    });

	it('should keep track of Safeties', function() {
		expect(player.Safeties).toEqual(0);
	});

	it('should be able to add 1 to Safeties', function() {
		player.addOneToSafeties();
		expect(player.Safeties).toEqual(1);
	});

	it('should be able to keep track if it is the currently up player', function() {
		expect(player.CurrentlyUp).toNotEqual(null);
	});

	it('should be able to set currently up to true or false', function() {
		player.CurrentlyUp = true;
		expect(player.CurrentlyUp).toEqual(true);
		player.CurrentlyUp = false;
		expect(player.CurrentlyUp).toEqual(false);
	});

	it('should be able to keep track of number of 8 on snap', function() {
		expect(player.EightOnSnaps).toEqual(0);
	});

	it('should be able to keep track of number of break and run', function() {
		expect(player.BreakAndRuns).toEqual(0);
	});

	it('should be able to add one to number of 8 on snap', function() {
		expect(player.EightOnSnaps).toEqual(0);
		player.addOneToEightOnSnaps();
		expect(player.EightOnSnaps).toEqual(1);
	});

	it('should be able add one to break and run', function() {
		expect(player.BreakAndRuns).toEqual(0);
		player.addOneToBreakAndRuns();
		expect(player.BreakAndRuns).toEqual(1);
	});

	it('should be able to return first name and last name as initial', function() {
		expect(player.getFirstNameWithInitials()).toEqual("Isaac W.");
	});

	it('should return just the first name if no last name is defined', function() {
		player = new EightBallPlayer("Isaac", 1, "123456", "123");
		expect(player.getFirstNameWithInitials()).toEqual("Isaac");
	});

	it('should return the Score as a string', function() {
		expect(player.getGamesWon()).toEqual('0');
	});

	it('should return Nine On Snap as a string', function() {
		expect(player.getEightOnSnaps()).toEqual('0')
		player.addOneToEightOnSnaps();
		expect(player.getEightOnSnaps()).toEqual('1');
	});

	it('should return Break And Runs as a string', function() {
		expect(player.getBreakAndRuns()).toEqual('0')
		player.addOneToBreakAndRuns();
		expect(player.getBreakAndRuns()).toEqual('1');
	});

    it('should be able to hold Timeouts Allowed', function() {
        expect(player.TimeoutsAllowed).toEqual(2);
    });

    it('should be able to store GamesNeededToWin', function() {
        expect(player.GamesNeededToWin).toEquall
    });

	describe('toJSON/fromJSON', function() {
		it('should be able to take a new Player and turn it into a JSON object',function() {
			expect(player.toJSON()).toEqual({
				Name: "Isaac Wooten",
				Rank: 1,
				GamesNeededToWin: 0, 
				Number: "123456",
				TeamNumber: "123",
				GamesWon: 0,       
				Safeties: 0,
				EightOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			});
		});

		it('should be able to take a Player with all variables filled and turn it into a JSON object',function() {
			player.GamesWon = 1;
			player.Safeties = 1;
			player.EightOnSnaps = 2;
			player.BreakAndRuns = 3;
			player.TimeoutsTaken = 1;
			player.CurrentlyUp = true;

			expect(player.toJSON()).toEqual({
				Name: "Isaac Wooten",
				Rank: 1,
				GamesNeededToWin: 0,
				Number: "123456",
				TeamNumber: "123",
				GamesWon: 1,
				Safeties: 1,
				EightOnSnaps: 2,
				BreakAndRuns: 3,
				CurrentlyUp: true
			});
		});

		it('should be able to take a Player JSON and fill a Player object with it', function() {
			player.fromJSON({
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
	});

});