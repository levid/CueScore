describe "NineBall Rank", ->
  model = undefined
  
  beforeEach ->
    model = new $CS.Models.NineBall.Ranks()
      
  describe "Scoring", ->
    it "should return the correct Ball Counts for each rank", ->
      expect(model.getBallCount(1)).toEqual 14
      expect(model.getBallCount(2)).toEqual 19
      expect(model.getBallCount(3)).toEqual 25
      expect(model.getBallCount(4)).toEqual 31
      expect(model.getBallCount(5)).toEqual 38
      expect(model.getBallCount(6)).toEqual 46
      expect(model.getBallCount(7)).toEqual 55
      expect(model.getBallCount(8)).toEqual 65
      expect(model.getBallCount(9)).toEqual 75
      
    it "should be able to return the match points for the losing player", ->
      expect(model.getLosingPlayersMatchPoints(1, 12)).toEqual 8
      
    it "should be able to return the match points for the winning player", ->
      expect(model.getWinningPlayersMatchPoints(1, 2)).toEqual 20

    it "should be able to return the number of timeouts based on model", ->
      expect(model.getTimeouts(1)).toEqual 2
      expect(model.getTimeouts(2)).toEqual 2
      expect(model.getTimeouts(3)).toEqual 2
      expect(model.getTimeouts(4)).toEqual 1
      expect(model.getTimeouts(5)).toEqual 1
      expect(model.getTimeouts(6)).toEqual 1
      expect(model.getTimeouts(7)).toEqual 1
      expect(model.getTimeouts(8)).toEqual 1
      expect(model.getTimeouts(9)).toEqual 1
      expect(model.getTimeouts(20)).toEqual 0 # Make sure bogus entries return 0
