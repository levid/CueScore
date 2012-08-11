/**
 * @author jamesa
 */
describe('NineBall Rank', function () {
	
	var rank;
	
	beforeEach(function() {
	    rank = new NineBallRanks();
	});
	
	describe('getBallCounts', function() {  
		it('should return the correct Ball Counts for each Rank', function() {
			expect(rank.getBallCount(1)).toEqual(14);
			expect(rank.getBallCount(2)).toEqual(19);
			expect(rank.getBallCount(3)).toEqual(25);
			expect(rank.getBallCount(4)).toEqual(31);
			expect(rank.getBallCount(5)).toEqual(38);
			expect(rank.getBallCount(6)).toEqual(46);
			expect(rank.getBallCount(7)).toEqual(55);
			expect(rank.getBallCount(8)).toEqual(65);
			expect(rank.getBallCount(9)).toEqual(75);
	  	});
	});
	
	it('should be able to return the number of timeouts based on rank', function() {
		expect(rank.getTimeouts(1)).toEqual(2);
		expect(rank.getTimeouts(2)).toEqual(2);
		expect(rank.getTimeouts(3)).toEqual(2);
		expect(rank.getTimeouts(4)).toEqual(1);
		expect(rank.getTimeouts(5)).toEqual(1);
		expect(rank.getTimeouts(6)).toEqual(1);
		expect(rank.getTimeouts(7)).toEqual(1);
		expect(rank.getTimeouts(8)).toEqual(1);
		expect(rank.getTimeouts(9)).toEqual(1);
	});
});