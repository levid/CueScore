describe "NineBall Rank", ->
  model = undefined
  
  beforeEach ->
    model = new $CS.Models.Rank.NineBall()

  describe "getBallCounts", ->
    it "should return the correct Ball Counts for each model", ->
      expect(model.getBallCount(1)).toEqual 14
      expect(model.getBallCount(2)).toEqual 19
      expect(model.getBallCount(3)).toEqual 25
      expect(model.getBallCount(4)).toEqual 31
      expect(model.getBallCount(5)).toEqual 38
      expect(model.getBallCount(6)).toEqual 46
      expect(model.getBallCount(7)).toEqual 55
      expect(model.getBallCount(8)).toEqual 65
      expect(model.getBallCount(9)).toEqual 75


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

