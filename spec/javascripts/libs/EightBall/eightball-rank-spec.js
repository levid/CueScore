/**
 * @author jamesa
 */
describe('EightBall Rank', function () {
	
	var rank;
	
	beforeEach(function() {
	    rank = new EightBallRanks();
	});
	
	describe('get games needed to win', function() {  
		it('should return the correct games needed to win for each Rank', function() {
			expect(rank.getGamesNeedToWin(2,2)).toEqual(2);
			expect(rank.getGamesNeedToWin(3,2)).toEqual(3);
			expect(rank.getGamesNeedToWin(4,2)).toEqual(4);
			expect(rank.getGamesNeedToWin(5,2)).toEqual(5);
			expect(rank.getGamesNeedToWin(6,2)).toEqual(6);
			expect(rank.getGamesNeedToWin(7,2)).toEqual(7);

			expect(rank.getGamesNeedToWin(2,3)).toEqual(2);
			expect(rank.getGamesNeedToWin(3,3)).toEqual(2);
			expect(rank.getGamesNeedToWin(4,3)).toEqual(3);
			expect(rank.getGamesNeedToWin(5,3)).toEqual(4);
			expect(rank.getGamesNeedToWin(6,3)).toEqual(5);
			expect(rank.getGamesNeedToWin(7,3)).toEqual(6);

			expect(rank.getGamesNeedToWin(2,4)).toEqual(2);
			expect(rank.getGamesNeedToWin(3,4)).toEqual(2);
			expect(rank.getGamesNeedToWin(4,4)).toEqual(3);
			expect(rank.getGamesNeedToWin(5,4)).toEqual(4);
			expect(rank.getGamesNeedToWin(6,4)).toEqual(5);
			expect(rank.getGamesNeedToWin(7,4)).toEqual(5);

			expect(rank.getGamesNeedToWin(2,5)).toEqual(2);
			expect(rank.getGamesNeedToWin(3,5)).toEqual(2);
			expect(rank.getGamesNeedToWin(4,5)).toEqual(3);
			expect(rank.getGamesNeedToWin(5,5)).toEqual(4);
			expect(rank.getGamesNeedToWin(6,5)).toEqual(5);
			expect(rank.getGamesNeedToWin(7,5)).toEqual(5);

			expect(rank.getGamesNeedToWin(2,6)).toEqual(2);
			expect(rank.getGamesNeedToWin(3,6)).toEqual(2);
			expect(rank.getGamesNeedToWin(4,6)).toEqual(3);
			expect(rank.getGamesNeedToWin(5,6)).toEqual(4);
			expect(rank.getGamesNeedToWin(6,6)).toEqual(5);
			expect(rank.getGamesNeedToWin(7,6)).toEqual(5);

			expect(rank.getGamesNeedToWin(2,7)).toEqual(2);
			expect(rank.getGamesNeedToWin(3,7)).toEqual(2);
			expect(rank.getGamesNeedToWin(4,7)).toEqual(2);
			expect(rank.getGamesNeedToWin(5,7)).toEqual(3);
			expect(rank.getGamesNeedToWin(6,7)).toEqual(4);
			expect(rank.getGamesNeedToWin(7,7)).toEqual(5);
	  	});
	});
	
	it('should be able to return the number of timeouts based on rank', function() {
		expect(rank.getTimeouts(2)).toEqual(2);
		expect(rank.getTimeouts(3)).toEqual(2);
		expect(rank.getTimeouts(4)).toEqual(1);
		expect(rank.getTimeouts(5)).toEqual(1);
		expect(rank.getTimeouts(6)).toEqual(1);
		expect(rank.getTimeouts(7)).toEqual(1);
	});
});