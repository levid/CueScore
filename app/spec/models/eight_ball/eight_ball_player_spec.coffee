describe "Eight Ball Player", ->
  player = undefined
  
  beforeEach ->
    player = new $CS.Models.EightBall.Player(
      options = 
        name: "Isaac Wooten"
        rank: 1
        playerNumber: "123456"
        teamNumber: "123"
    )

  describe "Constructor", ->
    it "should be able to create a new Player", ->
      player = new $CS.Models.EightBall.Player(
        options = 
          name: "Isaac Wooten"
          rank: 1
          playerNumber: "123456"
          teamNumber: "123"
      )
      expect(player).not.toBeUndefined()

    it "should contain default attributes", ->
      expect(player.name).toBeDefined()
      expect(player.rank).toBeDefined()
      expect(player.number).toBeDefined()
      expect(player.teamNumber).toBeDefined()
      expect(player.name).toEqual "Isaac Wooten"
      expect(player.rank).toEqual 1
      expect(player.number).toEqual "123456"
      expect(player.teamNumber).toEqual "123"

    it "should store the parameters", ->
      player = new $CS.Models.EightBall.Player(
        options = 
          name: "Isaac Wooten"
          rank: 1
          playerNumber: "123456"
          teamNumber: "123"
      )
      expect(player.name).toEqual "Isaac Wooten"
      expect(player.rank).toEqual 1
      expect(player.number).toEqual "123456"
      expect(player.teamNumber).toEqual "123"
      

  describe "Scoring", -> 
    it "should have games won", ->
      expect(player.gamesWon).toEqual 0
  
    it "should be able to return a string of the games needed to win", ->
      player.gamesNeededToWin = 2
      expect(player.getGamesNeededToWin()).toEqual "2"
  
    it "should be able to add a game win to total games won", ->
      expect(player.gamesWon).toEqual 0
      player.addToGamesWon(1)
      expect(player.gamesWon).toEqual 1
      player.addToGamesWon(1)
      expect(player.gamesWon).toEqual 2

    it "should keep track of safeties", ->
      player.addToSafeties(1)
      expect(player.getSafeties()).toEqual 1
  
    it "should be able to add 1 to safeties", ->
      player.addToSafeties(1)
      expect(player.safeties).toEqual 1
      
    it "should be able to keep track of number of 8 on snap", ->
      expect(player.eightOnSnaps).toEqual 0
  
    it "should be able to keep track of number of break and run", ->
      expect(player.breakAndRuns).toEqual 0
  
    it "should be able to add one to number of 8 on snap", ->
      expect(player.eightOnSnaps).toEqual 0
      player.addToEightOnSnaps(1)
      expect(player.eightOnSnaps).toEqual 1
  
    it "should be able add one to break and run", ->
      expect(player.breakAndRuns).toEqual 0
      player.addToBreakAndRuns(1)
      expect(player.breakAndRuns).toEqual 1
  
    it "should return the Score as a string", ->
      expect(player.getGamesWon()).toEqual "0"
  
    it "should return Nine On Snap as a string", ->
      expect(player.getEightOnSnaps()).toEqual "0"
      player.addToEightOnSnaps(1)
      expect(player.getEightOnSnaps()).toEqual "1"
  
    it "should return Break And Runs as a string", ->
      expect(player.getBreakAndRuns()).toEqual "0"
      player.addToBreakAndRuns(1)
      expect(player.getBreakAndRuns()).toEqual "1"
  
    it "should be able to hold Timeouts Allowed", ->
      expect(player.timeouts_allowed).toEqual 2
  
    it "should be able to store gamesNeededToWin", ->
      player.gamesNeededToWin = 1
      expect(player.getGamesNeededToWin()).toEqual "1"
      

  describe "Innings", -> 
    it "should be able to keep track if it is the currently up player", ->
      expect(player.currentlyUp).toNotEqual null
  
    it "should be able to set currently up to true or false", ->
      player.currentlyUp = true
      expect(player.currentlyUp).toEqual true
      player.currentlyUp = false
      expect(player.currentlyUp).toEqual false
      

  describe "Player Details", -> 
    it "should be able to return first name and last name as initial", ->
      expect(player.getFirstNameWithInitials()).toEqual "Isaac W."
  
    it "should return just the first name if no last name is defined", ->
      player = new $CS.Models.EightBall.Player(
        options = 
          name: "Isaac"
          rank: 1
          playerNumber: "123456"
          teamNumber: "123"
      )
      expect(player.getFirstNameWithInitials()).toEqual "Isaac"
      
    it "should be able to return the full name of player", ->
      expect(player.name).toEqual "Isaac Wooten"
    
    it "should be able to return the rank of the player", ->
      expect(player.rank).toEqual 1
    
    it "should be able to return the player number", ->
      expect(player.number).toEqual '123456'
      
    it "should know if the player is a captain", ->
      expect(player.isCaptain).toEqual false
      player.isCaptain = true
      expect(player.isCaptain).toEqual true


  describe "toJSON/fromJSON", ->
    it "should be able to take a new Player and turn it into a JSON object", ->
      expect(player.toJSON()).toEqual
        name: "Isaac Wooten"
        rank: 1
        gamesNeededToWin: 0
        number: "123456"
        teamNumber: "123"
        gamesWon: 0
        safeties: 0
        eightOnSnaps: 0
        breakAndRuns: 0
        currentlyUp: false


    it "should be able to take a Player with all variables filled and turn it into a JSON object", ->
      player.gamesWon = 1
      player.safeties = 1
      player.eightOnSnaps = 2
      player.breakAndRuns = 3
      player.TimeoutsTaken = 1
      player.currentlyUp = true
      expect(player.toJSON()).toEqual
        name: "Isaac Wooten"
        rank: 1
        gamesNeededToWin: 0
        number: "123456"
        teamNumber: "123"
        gamesWon: 1
        safeties: 1
        eightOnSnaps: 2
        breakAndRuns: 3
        currentlyUp: true


    it "should be able to take a Player JSON and fill a Player object with it", ->
      player.fromJSON
        name: "James Armstead"
        rank: 2
        gamesNeededToWin: 0
        number: "4321"
        teamNumber: "789"
        gamesWon: 1
        safeties: 1
        eightOnSnaps: 2
        breakAndRuns: 3
        currentlyUp: true

      expect(player.name).toEqual "James Armstead"
      expect(player.rank).toEqual 2
      expect(player.number).toEqual "4321"
      expect(player.teamNumber).toEqual "789"
      expect(player.gamesWon).toEqual 1
      expect(player.safeties).toEqual 1
      expect(player.eightOnSnaps).toEqual 2
      expect(player.breakAndRuns).toEqual 3
      expect(player.currentlyUp).toEqual true
      player.addToEightOnSnaps(1)
      expect(player.eightOnSnaps).toEqual 3


