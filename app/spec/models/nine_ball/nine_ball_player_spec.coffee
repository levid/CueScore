describe "Nine Ball Player", ->
  player = undefined
  
  beforeEach ->
    player = new $CS.Models.NineBall.Player(
      options =
        name: "Isaac Wooten"
        rank: 1 
        number: "123456"
        teamNumber: "123"
    )

  describe "Constructor", ->
    it "should store the parameters", ->
      expect(player.name).toEqual "Isaac Wooten"
      expect(player.rank).toEqual 1
      expect(player.number).toEqual "123456"
      expect(player.teamNumber).toEqual "123"

    it "should look up and store ball count", ->
      expect(player.ballCount).toEqual "14"


  it "should know if the player is a captain", ->
    expect(player.isCaptain).toEqual false
    player.isCaptain = true
    expect(player.isCaptain).toEqual true

  it "should have a score", ->
    expect(player.score).toEqual 0

  it "should be able to add a number to the current score", ->
    expect(player.score).toEqual 0
    player.addToScore 12
    expect(player.score).toEqual 12
    player.addToScore 8
    expect(player.score).toEqual 20

  it "should be able to find the remaining ball count", ->
    player.addToScore 12
    expect(player.getRemainingBallCount()).toEqual "2"

  it "should keep track of safeties", ->
    expect(player.safeties).toEqual 0

  it "should be able to add 1 to safeties", ->
    player.addToSafeties(1)
    expect(player.safeties).toEqual 1

  it "should be able to keep track if it is the currently up player", ->
    expect(player.currentlyUp).toNotEqual null

  it "should be able to set currently up to true or false", ->
    player.currentlyUp = true
    expect(player.currentlyUp).toEqual true
    player.currentlyUp = false
    expect(player.currentlyUp).toEqual false

  it "should know if player won", ->
    player.addToScore 13
    expect(player.hasWon()).toEqual false
    player.addToScore 1
    expect(player.hasWon()).toEqual true

  it "should be able to keep track of number of 9 on snap", ->
    expect(player.nineOnSnaps).toEqual 0

  it "should be able to keep track of number of break and run", ->
    expect(player.breakAndRuns).toEqual 0

  it "should be able to add one to number of 9 on snap", ->
    expect(player.nineOnSnaps).toEqual 0
    player.addToNineOnSnaps(1)
    expect(player.nineOnSnaps).toEqual 1

  it "should be able add one to break and run", ->
    expect(player.breakAndRuns).toEqual 0
    player.addToBreakAndRuns(1)
    expect(player.breakAndRuns).toEqual 1

  it "should be able to return first name and last name as initial", ->
    expect(player.getFirstNameWithInitials()).toEqual "Isaac W."

  it "should return just the first name if no last name is defined", ->
    player = new $CS.Models.NineBall.Player(
      options =
        name: "Isaac"
        rank: 1 
        number: "123456"
        teamNumber: "123"
    )
    expect(player.getFirstNameWithInitials()).toEqual "Isaac"

  it "should return the score as a string", ->
    expect(player.getScore()).toEqual "0"

  it "should return Nine On Snap as a string", ->
    expect(player.getNineOnSnaps()).toEqual "0"
    player.addToNineOnSnaps(1)
    expect(player.getNineOnSnaps()).toEqual "1"

  it "should return Break And Runs as a string", ->
    expect(player.getBreakAndRuns()).toEqual "0"
    player.addToBreakAndRuns(1)
    expect(player.getBreakAndRuns()).toEqual "1"

  it "should be able to have the rank changed and have the BallCounts and timeoutsAllowed automatically", ->
    expect(player.ballCount).toEqual "14"
    expect(player.timeoutsAllowed).toEqual 2
    player.rank = 7
    player.resetPlayerRankStats()
    expect(player.ballCount).toEqual "55"
    expect(player.timeoutsAllowed).toEqual 1

  it "should be able to return a Ratio score", ->
    player.addToScore 1
    expect(player.getRatioScore()).toEqual (1 / 14)

  describe "toJSON/fromJSON", ->
    it "should be able to take a new Player and turn it into a JSON object", ->
      expect(player.toJSON()).toEqual
        name: "Isaac Wooten"
        rank: 1
        ballCount: "14"
        number: "123456"
        teamNumber: "123"
        score: 0
        safeties: 0
        nineOnSnaps: 0
        breakAndRuns: 0
        currentlyUp: false


    it "should be able to take a Player with all variables filled and turn it into a JSON object", ->
      player.score = 12
      player.safeties = 1
      player.nineOnSnaps = 2
      player.breakAndRuns = 3
      player.TimeoutsTaken = 1
      player.currentlyUp = true
      expect(player.toJSON()).toEqual
        name: "Isaac Wooten"
        rank: 1
        ballCount: "14"
        number: "123456"
        teamNumber: "123"
        score: 12
        safeties: 1
        nineOnSnaps: 2
        breakAndRuns: 3
        currentlyUp: true


    it "should be able to take a Player JSON and fill a Player object with it", ->
      player.fromJSON
        name: "James Armstead"
        rank: 2
        number: "4321"
        teamNumber: "789"
        score: 12
        safeties: 1
        nineOnSnaps: 2
        breakAndRuns: 3
        currentlyUp: true

      expect(player.name).toEqual "James Armstead"
      expect(player.rank).toEqual 2
      expect(player.number).toEqual "4321"
      expect(player.teamNumber).toEqual "789"
      expect(player.score).toEqual 12
      expect(player.safeties).toEqual 1
      expect(player.nineOnSnaps).toEqual 2
      expect(player.breakAndRuns).toEqual 3
      expect(player.ballCount).toEqual "19"
      expect(player.currentlyUp).toEqual true
      player.addToNineOnSnaps(1)
      expect(player.nineOnSnaps).toEqual 3


