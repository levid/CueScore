/**
 * @author jamesa
 */
describe('Common', function () {
	it('should return the correct score ratio based on the BallCount', function() {
		expect(getScoreRatio(1,2)).toEqual(.5);
	})
});