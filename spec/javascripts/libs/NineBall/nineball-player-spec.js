/**
 * @author jamesa
 */
describe('NineBall Player', function () {
		var player;
		
		beforeEach(function() {
		    player = new NineBallPlayer("Isaac Wooten", 1, "123456", "123");
		});
	
	describe('Constructor', function() {  
  		it('should store the parameters', function() {
			expect(player.Name).toEqual("Isaac Wooten");
			expect(player.Rank).toEqual(1);
			expect(player.Number).toEqual("123456");
			expect(player.TeamNumber).toEqual("123");
		});
		
		it('should look up and store ball count', function() {
			expect(player.BallCount).toEqual('14');
		});
	});


    it('should know if the player is a captain', function() {
        expect(player.IsCaptain).toEqual(false);
        player.IsCaptain = true;
        expect(player.IsCaptain).toEqual(true);
    });


	it('should have a Score', function() {
		expect(player.Score).toEqual(0);
	});
	
	it('should be able to add a number to the current score', function() {
		expect(player.Score).toEqual(0);
		player.addToScore(12);
		expect(player.Score).toEqual(12);
		player.addToScore(8);
		expect(player.Score).toEqual(20);
	});
	
	it('should be able to find the remaining ball count', function() {
		player.addToScore(12);
		expect(player.getRemainingBallCount()).toEqual('2');
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
	
	it('should know if player won', function() {
		player.addToScore(13);
		expect(player.hasWon()).toEqual(false);
		player.addToScore(1);
		expect(player.hasWon()).toEqual(true);
	});
	
	it('should be able to keep track of number of 9 on snap', function() {
		expect(player.NineOnSnaps).toEqual(0);
	});
	
	it('should be able to keep track of number of break and run', function() {
		expect(player.BreakAndRuns).toEqual(0);
	});
	
	it('should be able to add one to number of 9 on snap', function() {
		expect(player.NineOnSnaps).toEqual(0);
		player.addOneToNineOnSnaps();
		expect(player.NineOnSnaps).toEqual(1);
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
		player = new NineBallPlayer("Isaac", 1, "123456", "123");
		expect(player.getFirstNameWithInitials()).toEqual("Isaac");
	});
	
	it('should return the Score as a string', function() {
		expect(player.getScore()).toEqual('0');
	});
	
	it('should return Nine On Snap as a string', function() {
		expect(player.getNineOnSnaps()).toEqual('0')
		player.addOneToNineOnSnaps();
		expect(player.getNineOnSnaps()).toEqual('1');
	});
	
	it('should return Break And Runs as a string', function() {
		expect(player.getBreakAndRuns()).toEqual('0')
		player.addOneToBreakAndRuns();
		expect(player.getBreakAndRuns()).toEqual('1');
	});
	
	it('should be able to have the Rank changed and have the BallCounts and TimeoutsAllowed automatically', function() {
		expect(player.BallCount).toEqual("14");
		expect(player.TimeoutsAllowed).toEqual(2);
		
		player.Rank = 7;
		player.resetPlayerRankStats();
		
		expect(player.BallCount).toEqual("55");
		expect(player.TimeoutsAllowed).toEqual(1);
	});
	
	it('should be able to return a Ratio Score', function() {
		player.addToScore(1);
		expect(player.getRatioScore()).toEqual((1 / 14));
	})
	
	describe('toJSON/fromJSON', function() { 
	
		it('should be able to take a new Player and turn it into a JSON object',function() {
			expect(player.toJSON()).toEqual({
				Name: "Isaac Wooten",
				Rank: 1,
				BallCount: "14",
				Number: "123456",
				TeamNumber: "123",
				Score: 0,
				Safeties: 0,
				NineOnSnaps: 0,
				BreakAndRuns: 0,
				CurrentlyUp: false
			});
		});
	
		it('should be able to take a Player with all variables filled and turn it into a JSON object',function() {
			player.Score = 12;
			player.Safeties = 1;
			player.NineOnSnaps = 2;
			player.BreakAndRuns = 3;
			player.TimeoutsTaken = 1;
			player.CurrentlyUp = true;
			
			expect(player.toJSON()).toEqual({
				Name: "Isaac Wooten",
				Rank: 1,
				BallCount: "14",
				Number: "123456",
				TeamNumber: "123",
				Score: 12,
				Safeties: 1,
				NineOnSnaps: 2,
				BreakAndRuns: 3,
				CurrentlyUp: true
			});
		});
		
		it('should be able to take a Player JSON and fill a Player object with it', function() {
			player.fromJSON({
				Name: "James Armstead",
				Rank: 2,
				Number: "4321",
				TeamNumber: "789",
				Score: 12,
				Safeties: 1,
				NineOnSnaps: 2,
				BreakAndRuns: 3,
				CurrentlyUp: true
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
			expect(player.CurrentlyUp).toEqual(true);
			
			player.addOneToNineOnSnaps();
			
			expect(player.NineOnSnaps).toEqual(3);
		});
	});

});