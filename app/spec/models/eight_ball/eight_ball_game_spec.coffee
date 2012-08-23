describe "Eight Ball Game", ->
  game          = undefined
  player        = {}
  player.one    = undefined
  player.two    = undefined
  matchCallback = undefined
  
  beforeEach ->
    matchCallback = jasmine.createSpy()
    
    player.one = new $CS.Models.EightBall.Player(
      options = 
        name: "Isaac Wooten"
        rank: 1
        playerNumber: "123"
        teamNumber: "123"
    )
    player.two = new $CS.Models.EightBall.Player(
      options = 
        name: "James Armstead"
        rank: 1
        playerNumber: "1"
        teamNumber: "1"
    )
    player.one.currentlyUp = true
    
    game = new $CS.Models.EightBall.Game(
      options = 
        addToPlayerOne: ->
          player.one
        addToPlayerTwo: ->
          player.two
        callback: matchCallback
    )
    
  afterEach ->
    game.numberOfInnings = 0
    game.player.one.eightOnSnap = false
    game.player.one.breakAndRun = false
    game.player.two.eightOnSnap = false
    game.player.two.breakAndRun = false
    game.player.one.ballType = null
    game.player.two.ballType = null
    game.player.one.eightBall = []
    game.player.two.eightBall = []
    game.playerOneWon = false
    game.playerTwoWon = false
    game.ended = false
    game.ballsHitIn.stripes = []
    game.ballsHitIn.solids = []
    game.lastBallHitIn = null
    game.onBreak = true
    game.breakingPlayerStillShooting = true
    game.player.one.callback().currentlyUp = true
    game.player.two.callback().currentlyUp = false
    
    breakingPlayerStillShooting = true
    earlyEight = false
    ended = false
    lastBallHitIn = null
    numberOfInnings = 0
    onBreak = true
    playerOneBallType = null
    playerOneBreakAndRun = false
    playerOneEightBall = []
    playerOneEightOnSnap = false
    playerOneTimeoutsTaken = 0
    playerOneWon = false
    playerTwoBallType = null
    playerTwoBreakAndRun = false
    playerTwoEightBall = []
    playerTwoEightOnSnap = false
    playerTwoTimeoutsTaken = 0
    playerTwoWon = false
    scratchOnEight = false
    solidBallsHitIn = []
    stripedBallsHitIn = []
   

  describe "Scoring", ->
    it "should be able to take a ball number 1-7 and 9-15 and score it correctly", ->
      game.scoreBall 1
      expect(game.player.one.ballType).toEqual null
      expect(game.ballsHitIn.stripes).toEqual []
      expect(game.ballsHitIn.solids).toEqual [1]
      game.breakIsOver()
      game.nextPlayerIsUp()
      game.scoreBall 9
      expect(game.getBallsHitInByPlayer(1)).toEqual [1]
      expect(game.getBallsHitInByPlayer(2)).toEqual [9]

    it "should be able to take ball number 8 and score it correctly", ->
      game.scoreBall 8
      expect(game.ended).toEqual true

    it "should only allow each ball to be scored one time", ->
      expect(game.getBallsHitIn().length).toEqual 0
      game.scoreBall 1
      expect(game.getBallsHitIn().length).toEqual 1
      game.scoreBall 1
      expect(game.getBallsHitIn().length).toEqual 1

    it "should be able to get the number of balls types each player has hit in", ->
      
      game.scoreBall 1
      game.breakIsOver()
      game.nextPlayerIsUp()
      game.scoreBall 10
      expect(game.getBallsHitInByPlayer(1).length).toEqual 1
      expect(game.getBallsHitInByPlayer(2).length).toEqual 1
      
    it "should be able to set a game as Scratch On 8", ->
      expect(game.scratchOnEight).toEqual false
      game.hitScratchOnEight()
      expect(game.scratchOnEight).toEqual true
      expect(game.ended).toEqual true
      expect(game.playerTwoWon).toEqual true
      expect(player.two.currentlyUp).toEqual true
      
    it "should be able to keep track if player one had 8 on snap", ->
      expect(game.player.one.eightOnSnap).toEqual false
  
    it "should be able to keep track if player one had break and run", ->
      expect(game.player.one.breakAndRun).toEqual false
  
    it "should be able to keep track if player two had 8 on snap", ->
      expect(game.player.two.eightOnSnap).toEqual false
  
    it "should be able to keep track if player one two break and run", ->
      expect(game.player.one.breakAndRun).toEqual false
  
    it "should know if the 8 ball is pocketed on the break and give the current player a EightOnSnap", ->
      expect(game.player.one.eightOnSnap).toEqual false
      game.scoreBall(8)
      expect(game.player.one.eightOnSnap).toEqual true
      expect(player.one.eightOnSnaps).toEqual 1
  
    it "should know if the 8 ball is not pocketed on the break and not give the current player a EightOnSnap", ->
      game.scoreBall(1)
      game.breakIsOver()
      expect(game.player.one.eightOnSnap).toEqual false
      game.scoreBall(8)
      expect(game.player.one.eightOnSnap).toEqual false
      expect(player.one.eightOnSnaps).toEqual 0
  
    it "should know when a player has hit all the balls in and is still breaking and only give them a 8BR", ->
      game.scoreBall(1)
      game.scoreBall(2)
      game.scoreBall(3)
      game.scoreBall(4)
      game.scoreBall(5)
      game.scoreBall(6)
      game.scoreBall(7)
      game.scoreBall(8)
      expect(game.player.one.eightOnSnap).toEqual false
      expect(game.ballsHitIn.solids.length).toEqual 7
      expect(game.ended).toEqual true
      expect(game.player.one.callback().breakAndRuns).toEqual 1
      expect(game.player.one.breakAndRun).toEqual true
  
    it "should be able to set player one to have a eight on snap and if not already true add one to that players total eight on snaps.", ->
      expect(game.player.one.eightOnSnap).toEqual false
      game.setEightOnSnapByPlayer(1)
      expect(game.player.one.eightOnSnap).toEqual true
      expect(player.one.eightOnSnaps).toEqual 1
      game.setEightOnSnapByPlayer(1)
      expect(player.one.eightOnSnaps).toEqual 1
  
    it "should be able to set player two to have a eight on snap and if not already true add one to that players total eight on snaps.", ->
      expect(game.player.two.eightOnSnap).toEqual false
      game.setEightOnSnapByPlayer(2)
      expect(game.player.two.eightOnSnap).toEqual true
      expect(player.two.eightOnSnaps).toEqual 1
      game.setEightOnSnapByPlayer(2)
      expect(player.two.eightOnSnaps).toEqual 1
  
    it "should be able to set player one to have a break and run and if not already true add one to that players total break and runs.", ->
      expect(game.player.one.breakAndRun).toEqual false
      game.setBreakAndRunByPlayer(1)
      expect(game.player.one.breakAndRun).toEqual true
      expect(player.one.breakAndRuns).toEqual 1
      game.setBreakAndRunByPlayer(1)
      expect(player.one.breakAndRuns).toEqual 1
      
    it "should be able to tell if the game is an early eight ball", ->
      game.shotMissed()
      game.scoreBall(8)
      expect(game.earlyEight).toEqual true
  
    it "should be able to set player two to have a break and run and if not already true add one to that players total break and runs.", ->
      expect(game.player.two.breakAndRun).toEqual false
      game.setBreakAndRunByPlayer(2)
      expect(game.player.two.breakAndRun).toEqual true
      expect(player.two.breakAndRuns).toEqual 1
      game.setBreakAndRunByPlayer(2)
      expect(player.two.breakAndRuns).toEqual 1
  
    it "should know when the player breaks and then continues on to all the balls in without missing one", ->
      expect(game.onBreak).toEqual true
      game.scoreBall(1)
      game.nextPlayerIsUp()
      game.scoreBall(2)
      game.scoreBall(3)
      game.scoreBall(4)
      game.scoreBall(5)
      game.scoreBall(6)
      game.scoreBall(7)
      game.scoreBall(8)
      expect(game.onBreak).toEqual false
      expect(game.breakingPlayerStillShooting).toEqual true
      expect(game.player.one.breakAndRun).toEqual true
      expect(player.one.breakAndRuns).toEqual 1
  
    it "should able to assign a ball type after the break if only one ball type has been hit in", ->
      game.onBreak = false
      game.scoreBall(1)
      game.nextPlayerIsUp()
      expect(game.player.one.ballType).toEqual 2
      expect(game.player.two.ballType).toEqual 1
  
    it "should able to assign a ball type after the break if only one ball type has been hit in", ->
      game.onBreak = false
      game.scoreBall(9)
      game.nextPlayerIsUp()
      expect(game.player.one.ballType).toEqual 1
      expect(game.player.two.ballType).toEqual 2
  
    it "should be able to keep track of which solid balls have been hit in", ->
      expect(game.ballsHitIn.solids.length).toEqual 0
      game.scoreBall(1)
      game.scoreBall(2)
      game.scoreBall(3)
      game.scoreBall(4)
      expect(game.ballsHitIn.solids.length).toEqual 4
      expect(game.ballsHitIn.solids[0]).toEqual 1
      expect(game.ballsHitIn.solids[1]).toEqual 2
      expect(game.ballsHitIn.solids[2]).toEqual 3
      expect(game.ballsHitIn.solids[3]).toEqual 4
  
    it "should be able to keep track of which striped balls have been hit in", ->
      expect(game.ballsHitIn.stripes.length).toEqual 0
      game.scoreBall(9)
      game.scoreBall(10)
      game.scoreBall(11)
      game.scoreBall(12)
      expect(game.ballsHitIn.stripes.length).toEqual 4
      expect(game.ballsHitIn.stripes[0]).toEqual 9
      expect(game.ballsHitIn.stripes[1]).toEqual 10
      expect(game.ballsHitIn.stripes[2]).toEqual 11
      expect(game.ballsHitIn.stripes[3]).toEqual 12
  
    it "should be able to set player one to striped balls", ->
      expect(game.player.one.ballType).toEqual null
      game.setBallTypeByPlayer(1, 'stripes')
      expect(game.player.one.ballType).toEqual game.stripes
      expect(game.player.two.ballType).toEqual game.solids
  
    it "should be able to set player one to solid balls", ->
      expect(game.player.one.ballType).toEqual null
      game.setBallTypeByPlayer(1, 'solids')
      expect(game.player.one.ballType).toEqual game.solids
      expect(game.player.two.ballType).toEqual game.stripes
  
    it "should be able to set player two to striped balls", ->
      expect(game.player.one.ballType).toEqual null
      game.setBallTypeByPlayer(2, 'stripes')
      expect(game.player.two.ballType).toEqual game.stripes
      expect(game.player.one.ballType).toEqual game.solids
  
    it "should be able to set player two to solid balls", ->
      expect(game.player.two.ballType).toEqual null
      game.setBallTypeByPlayer(2, 'solids')
      expect(game.player.two.ballType).toEqual game.solids
      expect(game.player.one.ballType).toEqual game.stripes
  
    it "should be able to find out if there is a winner if a player hits a BR and set that player to won", ->
      game.scoreBall 1
      game.scoreBall 2
      game.scoreBall 3
      game.scoreBall 4
      expect(game.playerOneWon).toEqual false
      game.scoreBall 5
      game.scoreBall 6
      game.scoreBall 7
      game.scoreBall 8
      expect(game.getBallsHitInByPlayer(1).exists(8)).toEqual true
      expect(game.playerOneWon).toEqual true
  
    it "should be able to find out if there is a winner if player two wins and set that player to won", ->
      game.scoreBall 1
      game.breakIsOver()
      game.nextPlayerIsUp()
      game.checkForWinner()
      expect(game.playerOneWon).toEqual false
      game.scoreBall 9
      game.scoreBall 10
      game.scoreBall 11
      game.scoreBall 12
      game.scoreBall 13
      game.scoreBall 14
      game.scoreBall 15
      game.scoreBall 8
      expect(game.playerTwoWon).toEqual true
  
    it "should be able to find out if there is a winner after ball type has been selected and set that player to won", ->
      game.scoreBall 1
      game.scoreBall 10
      game.breakIsOver()
      game.nextPlayerIsUp()
      game.checkForWinner()
      expect(game.playerOneWon).toEqual false
      game.scoreBall 9
      game.setBallTypeByPlayer(2, 'solids')
      game.scoreBall 11
      game.scoreBall 12
      game.scoreBall 13
      game.scoreBall 14
      game.scoreBall 15
      game.scoreBall 8
      expect(game.playerOneWon).toEqual true
      
    it "should be able to return a list of all balls that have been hit in", ->
      game.scoreBall 1
      expect(game.getBallsHitIn()).toEqual [1]
      game.nextPlayerIsUp()
      game.scoreBall 2
      game.scoreBall 10
      expect(game.getBallsHitIn()).toEqual [1, 2, 10]
  
    it "should be able to hit a safety", ->
      game.hitSafety()
      expect(game.player.one.callback().safeties).toEqual 1
      game.hitSafety()
      expect(game.player.two.callback().safeties).toEqual 1
  
    it "should be able to return the game score with player one's score first (example 2-3)", ->
      game.scoreBall 1
      game.scoreBall 4
      game.nextPlayerIsUp() #Ending the Break
      game.nextPlayerIsUp() #Misses all balls
      game.scoreBall 10
      game.scoreBall 11
      game.scoreBall 12
      expect(game.getGameScore()).toEqual "2-3"
      
    it "should be able to keep track of the last ball scored", ->
      expect(game.lastBallHitIn).toEqual null
      game.scoreBall 1
      expect(game.lastBallHitIn).toEqual 1
      game.scoreBall 3
      expect(game.lastBallHitIn).toEqual 3
      game.nextPlayerIsUp() #Ending the break
      game.nextPlayerIsUp() #All balls are missed
      game.scoreBall 4
      expect(game.lastBallHitIn).toEqual 4


  describe "Innings", ->
    it "should keep track of the number of innings", ->
      expect(game.numberOfInnings).toEqual 0

    it "should be able to add 1 to the number of innings", ->
      game.addToNumberOfInnings(1)
      expect(game.numberOfInnings).toEqual 1

    it "should be able to add 1 to the innings when player2's turn is over", ->
      expect(game.numberOfInnings).toEqual 0
      game.nextPlayerIsUp()
      
      expect(game.numberOfInnings).toEqual 0
      expect(player.two.currentlyUp).toEqual true
      
      game.nextPlayerIsUp()
      expect(game.numberOfInnings).toEqual 1
      
    it "should be able to end the break if no balls were hit in", ->
      game.nextPlayerIsUp()
      expect(game.onBreak).toEqual false
      expect(game.breakingPlayerStillShooting).toEqual false
  
    it "should be able to change who is currentlyUp", ->
      game.nextPlayerIsUp()
      expect(player.two.currentlyUp).toEqual true
      game.nextPlayerIsUp()
      expect(player.one.currentlyUp).toEqual true
  
    it "should be able to know if a player is still breaking(balls scored) when they use NextPlayerIsUp while breaking", ->
      expect(game.onBreak).toEqual true
      game.scoreBall(1)
      game.nextPlayerIsUp()
      expect(player.two.currentlyUp).toEqual false
      expect(player.one.currentlyUp).toEqual true
  
    it "should be able to know if a players turn is over(no balls scored) when they use NextPlayerIsUp while breaking", ->
      expect(game.onBreak).toEqual true
      game.nextPlayerIsUp()
      expect(player.two.currentlyUp).toEqual true
      expect(player.one.currentlyUp).toEqual false
      
    it "should end the current players turn when they hit a safety", ->
      game.hitSafety()
      expect(game.player.one.callback().safeties).toEqual 1
      expect(game.getCurrentlyUpPlayer().name).toEqual "James Armstead"
      
    it "should be able to have a state of breaking", ->
      expect(game.onBreak).toEqual true
  
    it "should be able to have change the breaking state to false", ->
      expect(game.onBreak).toEqual true
      game.breakIsOver()
      expect(game.onBreak).toEqual false
  
    it "should know if the breaking player is still up", ->
      expect(game.breakingPlayerStillShooting).toEqual true
      game.scoreBall 2
      game.nextPlayerIsUp() #Ends Breaking
      game.scoreBall 3
      game.scoreBall 5
      expect(game.breakingPlayerStillShooting).toEqual true
      game.nextPlayerIsUp()
      expect(game.breakingPlayerStillShooting).toEqual false


  describe "Game Ending", ->
    it "should be able to be ended", ->
      expect(game.ended).toBeFalsy()
      game.end()
      expect(game.ended).toBeTruthy()
      
    it "should be able to make a player win and add one to games won", ->
      game.setPlayerWon(1)
      expect(game.playerOneWon).toEqual true
      expect(game.playerTwoWon).toEqual false
      expect(game.player.one.callback().gamesWon).toEqual 1
      expect(game.player.two.callback().gamesWon).toEqual 0
      game.setPlayerWon(2)
      expect(game.playerOneWon).toEqual true
      expect(game.playerTwoWon).toEqual true
      expect(game.player.one.callback().gamesWon).toEqual 1
      expect(game.player.two.callback().gamesWon).toEqual 1
  
    it "should end the game and give currently player up the win if they pocket the 8 ball on break", ->
      expect(game.playerOneWon).toEqual false
      game.scoreBall(8)
      expect(game.playerOneWon).toEqual true
      expect(game.playerTwoWon).toEqual false


    it "should know the match has completed when the 8 his hit in", ->
      expect(game.ended).toEqual false
      game.scoreBall(8)
      expect(game.ended).toEqual true
      
    it "should end the game if a player hits the 8 ball in when it is not their last ball or on break", ->
      game.scoreBall 1
      game.nextPlayerIsUp()
      game.scoreBall 12
      game.nextPlayerIsUp()
      game.scoreBall 8
      expect(game.player.two.eightBall).toEqual [8]
      expect(game.ended).toEqual true
      expect(game.playerOneWon).toEqual true


  describe "Player Timeouts", ->
    it "should allow the currentplayer to be able to take a timeout", ->
      game.player.one.timeoutsTaken = 0
      game.player.two.timeoutsTaken = 0
      
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 2
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 1

    it "should not allow the current player to take more time outs than given", ->
      game.player.one.timeoutsTaken = 0
      game.player.two.timeoutsTaken = 0
    
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 2
      game.takeTimeout()
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 0
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 0

    it "should be able to return the current player's remaining number of timeouts", ->
      game.player.one.timeoutsTaken = 0
      game.player.two.timeoutsTaken = 0
      
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 2
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 1
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 0
  
  
  describe "Player Information", ->
    it "should return winning players name (player one)", ->
      game.scoreBall 1
      game.scoreBall 2
      game.scoreBall 3
      game.scoreBall 4
      game.scoreBall 5
      game.scoreBall 6
      game.scoreBall 7
      game.scoreBall 8
      expect(game.getWinningPlayerName()).toEqual "Isaac W."
  

  describe "toJSON/fromJSON", ->
    
    it "should be able to take a new Game and turn it into a JSON object", ->
      expect(game.toJSON()).toEqual
        playerOneTimeoutsTaken: 0
        playerTwoTimeoutsTaken: 0
        playerOneEightOnSnap: false
        playerOneBreakAndRun: false
        playerTwoEightOnSnap: false
        playerTwoBreakAndRun: false
        playerOneBallType: null
        playerTwoBallType: null
        playerOneEightBall: []
        playerTwoEightBall: []
        playerOneWon: false
        playerTwoWon: false
        numberOfInnings: 0
        earlyEight: false
        scratchOnEight: false
        breakingPlayerStillShooting: true
        stripedBallsHitIn: []
        solidBallsHitIn: []
        lastBallHitIn: null
        onBreak: true
        ended: false

    it "should be able to take a filled up Game and turn it into a JSON object", ->
      game.numberOfInnings = 2
      game.player.one.eightOnSnap = true
      game.player.one.breakAndRun = false
      game.player.two.eightOnSnap = true
      game.player.two.breakAndRun = true
      game.player.one.ballType = 1
      game.player.two.ballType = 2
      game.player.one.eightBall = []
      game.player.two.eightBall = [8]
      game.playerOneWon = true
      game.playerTwoWon = false
      game.ended = true
      game.ballsHitIn.stripes = [1, 2]
      game.ballsHitIn.solids = [9, 10]
      game.lastBallHitIn = 1
      game.onBreak = false
      game.breakingPlayerStillShooting = false
      game.player.one.callback().currentlyUp = true
      game.takeTimeout()
      
      expect(game.toJSON()).toEqual
        playerOneTimeoutsTaken: 1
        playerTwoTimeoutsTaken: 0
        playerOneEightOnSnap: true
        playerOneBreakAndRun: false
        playerTwoEightOnSnap: true
        playerTwoBreakAndRun: true
        playerOneBallType: 1
        playerTwoBallType: 2
        playerOneEightBall: []
        playerTwoEightBall: [8]
        playerOneWon: true
        playerTwoWon: false
        numberOfInnings: 2
        earlyEight: false
        scratchOnEight: false
        breakingPlayerStillShooting: false
        stripedBallsHitIn: [1, 2]
        solidBallsHitIn: [9, 10]
        lastBallHitIn: 1
        onBreak: false
        ended: true


    it "should be able to take a Game JSON and fill a Game object with it", ->
      game.fromJSON
        breakingPlayerStillShooting: false
        earlyEight: false
        ended: true
        lastBallHitIn: [2]
        numberOfInnings: 2
        onBreak: false
        playerOneBallType: 1
        playerOneBreakAndRun: false
        playerOneEightBall: []
        playerOneEightOnSnap: true
        playerOneTimeoutsTaken: 1
        playerOneWon: true
        playerTwoBallType: 2
        playerTwoBreakAndRun: true
        playerTwoEightBall: [ 8 ]
        playerTwoEightOnSnap: true
        playerTwoTimeoutsTaken: 0
        playerTwoWon: false
        scratchOnEight: false
        solidBallsHitIn: [ 10 ]
        stripedBallsHitIn: [ 2 ]
    
      expect(game.numberOfInnings).toEqual 2
      expect(game.player.one.timeoutsTaken).toEqual 1
      expect(game.player.two.timeoutsTaken).toEqual 0
      expect(game.player.one.eightOnSnap).toEqual true
      expect(game.player.one.breakAndRun).toEqual false
      expect(game.player.two.eightOnSnap).toEqual true
      expect(game.player.two.breakAndRun).toEqual true
      expect(game.player.one.ballType).toEqual 1
      expect(game.player.two.ballType).toEqual 2
      expect(game.player.one.eightBall).toEqual []
      expect(game.player.two.eightBall).toEqual [8]
      expect(game.playerOneWon).toEqual true
      expect(game.playerTwoWon).toEqual false
      expect(game.ended).toEqual true
      expect(game.ballsHitIn.stripes).toEqual [2]
      expect(game.ballsHitIn.solids).toEqual [10]
      expect(game.lastBallHitIn).toEqual [2]
      expect(game.onBreak).toEqual false
      game.addToNumberOfInnings(1)
      expect(game.numberOfInnings).toEqual 3


