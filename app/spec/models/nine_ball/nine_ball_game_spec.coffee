describe "Nine Ball Game", ->
  game          = undefined
  player        = {}
  player.one    = undefined
  player.two    = undefined
  matchCallback = undefined
  
  beforeEach ->
    matchCallback = jasmine.createSpy()
    
    player.one = new $CS.Models.NineBall.Player(
      options =
        name: "Isaac Wooten"
        rank: 1 
        number: "123"
        teamNumber: "123"
    )
    
    player.two = new $CS.Models.NineBall.Player(
      options =
        name: "James Armstead"
        rank: 1 
        number: "1"
        teamNumber: "1"
    )
    
    player.one.currentlyUp = true
    
    game = new $CS.Models.NineBall.Game(
      options = 
        addToPlayerOne: ->
          player.one
        addToPlayerTwo: ->
          player.two
        callback: matchCallback
    )
    
  afterEach ->
    game.player.one.score = 0
    game.player.one.nineOnSnap = false
    game.player.one.breakAndRun = false
    game.player.one.ballsHitIn = []
    game.player.one.deadBalls = []
    game.player.one.lastBall = null
    game.player.one.timeoutsTaken = 0
    game.player.two.score = 0
    game.player.two.nineOnSnap = false
    game.player.two.breakAndRun = false
    game.player.two.ballsHitIn = []
    game.player.two.deadBalls = []
    game.player.two.lastBall = null
    game.player.two.timeoutsTaken = 0
    
    numberOfInnings: 0
    ended: false
    onBreak: true
    breakingPlayerStillShooting: true
    
  describe "Scoring", ->
    it "should be able to keep track of 2 Players scores", ->
      expect(game.player.one.score).toNotEqual null
      expect(game.player.two.score).toNotEqual null

    it "should be able to take a ball number 1-8 and score it correctly", ->
      game.scoreBall 1
      expect(game.player.one.score).toEqual 1
      player.one.currentlyUp = false
      player.two.currentlyUp = true
      game.scoreBall 2
      expect(game.player.two.score).toEqual 1

    it "should be able to take ball number 9 and score it correctly", ->
      game.scoreBall 9
      expect(game.player.one.score).toEqual 2

    it "should add 1 to currently up player's total score, when it adds 1 to game score", ->
      game.scoreBall 1
      expect(player.one.score).toEqual 1
      player.one.currentlyUp = false
      player.two.currentlyUp = true
      game.scoreBall 2
      expect(player.two.score).toEqual 1

    it "should only allow each ball to be scored/deadball one time", ->
      expect(player.one.score).toEqual 0
      game.scoreBall 1
      expect(player.one.score).toEqual 1
      game.scoreBall 1
      expect(player.one.score).toEqual 1
      game.hitDeadBall 1
      expect(game.player.one.deadBalls.length).toEqual 0
      
    it "should return the correct score ratio based on the BallCount", ->
      expect(game.getScoreRatio(1, 2)).toEqual .5


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


  describe "Game Ending", ->
    it "should be able to be ended", ->
      expect(game.ended).toBeFalsy()
      game.end()
      expect(game.ended).toBeTruthy()

    it "should know when the match is completed with 1 point and end the game", ->
      player.one = new $CS.Models.NineBall.Player(
        options =
          name: "Isaac Wooten"
          rank: 1 
          number: "123"
          teamNumber: "123"
      )
      player.one.score = 13
      player.two = new $CS.Models.NineBall.Player(
        options =
          name: "James Armstead"
          rank: 1 
          number: "1"
          teamNumber: "1"
      )

      player.one.currentlyUp = true
      
      game = new $CS.Models.NineBall.Game(
        options = 
          addToPlayerOne: ->
            player.one
          addToPlayerTwo: ->
            player.two
          callback: matchCallback
      )
    
      expect(game.ended).toEqual false
      game.scoreBall 1
      expect(game.ended).toEqual true

    it "should know when the match is completed with 2 points and end the game", ->
      i = 1
      while i <= 13
        game.scoreBall 1
        i++
      expect(game.ended).toEqual false
      game.scoreBall 9
      expect(game.ended).toEqual true

    it "should execute matchEndedCallBack if match is completed", ->
      player.one = new $CS.Models.NineBall.Player(
        options =
          name: "Isaac Wooten"
          rank: 1 
          number: "123"
          teamNumber: "123"
      )
      player.one.score = 13
      player.two = new $CS.Models.NineBall.Player(
        options =
          name: "James Armstead"
          rank: 1 
          number: "1"
          teamNumber: "1"
      )
      player.one.currentlyUp = true
      
      game = new $CS.Models.NineBall.Game(
        options = 
          addToPlayerOne: ->
            player.one
          addToPlayerTwo: ->
            player.two
          callback: matchCallback
      )
      
      game.scoreBall 1
      expect(matchCallback).wasCalled()

    it "should set all balls left on the table to deadballs and end the game if the Nine ball is hit in before the table is cleared", ->
      game.scoreBall 9
      expect(game.player.one.ballsHitIn[0]).toEqual 9
      expect(game.player.one.deadBalls[0]).toEqual 1
      expect(game.player.one.deadBalls[1]).toEqual 2
      expect(game.player.one.deadBalls[2]).toEqual 3
      expect(game.player.one.deadBalls[3]).toEqual 4
      expect(game.player.one.deadBalls[4]).toEqual 5
      expect(game.player.one.deadBalls[5]).toEqual 6
      expect(game.player.one.deadBalls[6]).toEqual 7
      expect(game.player.one.deadBalls[7]).toEqual 8
      expect(game.ended).toEqual true


  describe "Player Timeouts", ->
    it "should allow the currentplayer to be able to take a timeout", ->
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "2"
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "1"

    it "should not allow the current player to take more time outs than given", ->
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "2"
      game.takeTimeout()
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "0"
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "0"

    it "should be able to return the current player's remaining number of timeouts", ->
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "2"
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "1"
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual "0"


  describe "Deadballs", ->
    it "should be able to keep track of DeadBalls", ->
      expect(game.getDeadBalls()).toNotEqual null
      game.hitDeadBall 1
      game.hitDeadBall 2
      expect(game.getDeadBalls()).toEqual 2

    it "should be able to keep track of which deadballs player.one hit", ->
      expect(game.player.one.deadBalls.length).toEqual 0
      game.hitDeadBall 1
      game.hitDeadBall 2
      game.hitDeadBall 3
      game.hitDeadBall 4
      expect(game.player.one.deadBalls.length).toEqual 4
      expect(game.player.one.deadBalls[0]).toEqual 1
      expect(game.player.one.deadBalls[1]).toEqual 2
      expect(game.player.one.deadBalls[2]).toEqual 3
      expect(game.player.one.deadBalls[3]).toEqual 4

    it "should be able to keep track of which deadballs player.two hit", ->
      game.nextPlayerIsUp()
      expect(game.player.two.deadBalls.length).toEqual 0
      game.hitDeadBall 1
      game.hitDeadBall 2
      game.hitDeadBall 3
      game.hitDeadBall 4
      expect(game.player.two.deadBalls.length).toEqual 4
      expect(game.player.two.deadBalls[0]).toEqual 1
      expect(game.player.two.deadBalls[1]).toEqual 2
      expect(game.player.two.deadBalls[2]).toEqual 3
      expect(game.player.two.deadBalls[3]).toEqual 4

    it "should not allow the nineball to be a deadball", ->
      game.hitDeadBall 9
      expect(game.player.one.deadBalls.length).toEqual 0


  it "should be able to change who is currentlyUp", ->
    game.nextPlayerIsUp()
    expect(player.two.currentlyUp).toEqual true
    game.nextPlayerIsUp()
    expect(player.one.currentlyUp).toEqual true

  it "should be able to know if a player is still breaking(balls scored) when they use NextPlayerIsUp while breaking", ->
    expect(game.onBreak).toEqual true
    game.scoreBall 1
    game.nextPlayerIsUp()
    expect(player.two.currentlyUp).toEqual false
    expect(player.one.currentlyUp).toEqual true

  it "should be able to know if a players turn is over(deadball) when they use NextPlayerIsUp while breaking", ->
    expect(game.onBreak).toEqual true
    game.hitDeadBall 1
    game.nextPlayerIsUp()
    expect(player.two.currentlyUp).toEqual true
    expect(player.one.currentlyUp).toEqual false

  it "should be able to know if a players turn is over(no balls scored) when they use NextPlayerIsUp while breaking", ->
    expect(game.onBreak).toEqual true
    game.nextPlayerIsUp()
    expect(player.two.currentlyUp).toEqual true
    expect(player.one.currentlyUp).toEqual false

  it "should be able to add one to currently up player", ->
    expect(game.getCurrentlyUpPlayer().name).toEqual "Isaac Wooten"
    game.nextPlayerIsUp()
    expect(game.getCurrentlyUpPlayer().name).toEqual "James Armstead"

  it "should be able to keep track if player one had 9 on snap", ->
    expect(game.player.one.nineOnSnap).toEqual false

  it "should be able to keep track if player one had break and run", ->
    expect(game.player.one.breakAndRun).toEqual false

  it "should be able to keep track if player two had 9 on snap", ->
    expect(game.player.two.nineOnSnap).toEqual false

  it "should be able to keep track if player one two break and run", ->
    expect(game.player.two.breakAndRun).toEqual false

  it "should know if the 9 ball is pocketed on the break and give the current player a NineOnSnap", ->
    expect(game.player.one.nineOnSnap).toEqual false
    game.scoreBall 9
    expect(game.player.one.nineOnSnap).toEqual true
    expect(player.one.nineOnSnaps).toEqual 1

  it "should know if the 9 ball is not pocketed on the break and not give the current player a NineOnSnap", ->
    game.scoreBall 1
    game.breakIsOver()
    expect(game.player.one.nineOnSnap).toEqual false
    game.scoreBall 9
    expect(game.player.one.nineOnSnap).toEqual false
    expect(player.one.nineOnSnaps).toEqual 0

  it "should know when a player has hit all the balls in and is still breaking and only give them a 9BR", ->
    game.scoreBall 1
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    game.scoreBall 5
    game.scoreBall 6
    game.scoreBall 7
    game.scoreBall 8
    game.scoreBall 9
    expect(game.player.one.nineOnSnap).toEqual false
    expect(game.player.one.breakAndRun).toEqual true

  it "should be able to set player one to have a nine on snap and if not already true add one to that players total nine on snaps.", ->
    expect(game.player.one.nineOnSnap).toEqual false
    game.setNineOnSnapByPlayer(1)
    expect(game.player.one.nineOnSnap).toEqual true
    expect(player.one.nineOnSnaps).toEqual 1
    game.setNineOnSnapByPlayer(1)
    expect(player.one.nineOnSnaps).toEqual 1

  it "should be able to set player two to have a nine on snap and if not already true add one to that players total nine on snaps.", ->
    expect(game.player.two.nineOnSnap).toEqual false
    game.setNineOnSnapByPlayer(2)
    expect(game.player.two.nineOnSnap).toEqual true
    expect(player.two.nineOnSnaps).toEqual 1
    game.setNineOnSnapByPlayer(2)
    expect(player.two.nineOnSnaps).toEqual 1

  it "should be able to set player one to have a break and run and if not already true add one to that players total break and runs.", ->
    expect(game.player.one.breakAndRun).toEqual false
    game.setBreakAndRunByPlayer(1)
    expect(game.player.one.breakAndRun).toEqual true
    expect(player.one.breakAndRuns).toEqual 1
    game.setBreakAndRunByPlayer(1)
    expect(player.one.breakAndRuns).toEqual 1

  it "should be able to set player two to have a break and run and if not already true add one to that players total break and runs.", ->
    expect(game.player.two.breakAndRun).toEqual false
    game.setBreakAndRunByPlayer(2)
    expect(game.player.two.breakAndRun).toEqual true
    expect(player.two.breakAndRuns).toEqual 1
    game.setBreakAndRunByPlayer(2)
    expect(player.two.breakAndRuns).toEqual 1

  it "should know when the player breaks and then continues on to all the balls in without missing one or hitting a deadball", ->
    expect(game.onBreak).toEqual true
    game.scoreBall 1
    game.nextPlayerIsUp()
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    game.scoreBall 5
    game.scoreBall 6
    game.scoreBall 7
    game.scoreBall 8
    game.scoreBall 9
    expect(game.onBreak).toEqual false
    expect(game.breakingPlayerStillShooting).toEqual true
    expect(game.player.one.breakAndRun).toEqual true
    expect(player.one.breakAndRuns).toEqual 1

  it "should be able to keep track of which balls the player one has hit in", ->
    expect(game.player.one.ballsHitIn.length).toEqual 0
    game.scoreBall 1
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    expect(game.player.one.ballsHitIn.length).toEqual 4
    expect(game.player.one.ballsHitIn[0]).toEqual 1
    expect(game.player.one.ballsHitIn[1]).toEqual 2
    expect(game.player.one.ballsHitIn[2]).toEqual 3
    expect(game.player.one.ballsHitIn[3]).toEqual 4

  it "should be able to keep track of which balls the player two has hit in", ->
    game.nextPlayerIsUp()
    expect(game.player.two.ballsHitIn.length).toEqual 0
    game.scoreBall 1
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    expect(game.player.two.ballsHitIn.length).toEqual 4
    expect(game.player.two.ballsHitIn[0]).toEqual 1
    expect(game.player.two.ballsHitIn[1]).toEqual 2
    expect(game.player.two.ballsHitIn[2]).toEqual 3
    expect(game.player.two.ballsHitIn[3]).toEqual 4

  it "should be able to get the winning player's name when player's ranks are the same", ->
    game.scoreBall 1
    expect(game.getWinningPlayerName()).toEqual "Isaac W."
    game.nextPlayerIsUp() #Ending the Break
    game.nextPlayerIsUp() #Missing all balls
    game.scoreBall 2
    game.scoreBall 3
    expect(game.getWinningPlayerName()).toEqual "James A."

  it "should be able to get the winning player's name(lower rank) when player's Ranks are different", ->
    player.one = new $CS.Models.NineBall.Player(
      options =
        name: "Isaac Wooten"
        rank: 1 
        number: "123"
        teamNumber: "123"
    )
    player.two = new $CS.Models.NineBall.Player(
      options =
        name: "James Armstead"
        rank: 7 
        number: "1"
        teamNumber: "1"
    )
    
    player.one.currentlyUp = true
    
    game = new $CS.Models.NineBall.Game(
      options = 
        addToPlayerOne: ->
          player.one
        addToPlayerTwo: ->
          player.two
        callback: matchCallback
    )
    
    game.scoreBall 1
    expect(game.getWinningPlayerName()).toEqual "Isaac W."
    game.nextPlayerIsUp() #Ending the Break
    game.nextPlayerIsUp() #Missing all balls
    game.scoreBall 2
    game.scoreBall 3
    expect(game.getWinningPlayerName()).toEqual "Isaac W."

  it "should be able to get the winning player's name(higher rank) when player's Ranks are different", ->
    player.one = new $CS.Models.NineBall.Player(
      options =
        name: "Isaac Wooten"
        rank: 1 
        number: "123"
        teamNumber: "123"
    )
    player.one.score = 13
    player.two = new $CS.Models.NineBall.Player(
      options =
        name: "James Armstead"
        rank: 7
        number: "1"
        teamNumber: "1"
    )
    
    player.one.currentlyUp = true
    
    game = new $CS.Models.NineBall.Game(
      options = 
        addToPlayerOne: ->
          player.one
        addToPlayerTwo: ->
          player.two
        callback: matchCallback
    )
    
    game.scoreBall 1
    expect(game.getWinningPlayerName()).toEqual "Isaac W."
    game.nextPlayerIsUp() #Ending the Break
    game.nextPlayerIsUp() #Missing all balls
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    game.scoreBall 5
    game.scoreBall 6
    game.scoreBall 7
    game.scoreBall 8
    game.scoreBall 9
    expect(game.getWinningPlayerName()).toEqual "James A."

  it "should return null if game ends in tie", ->
    expect(game.getWinningPlayerName()).toEqual "Tie"

  it "should be able to return a list of all balls that have been hit in", ->
    game.scoreBall 1
    expect(game.getBallsHitIn()).toEqual [1]
    game.nextPlayerIsUp()
    game.scoreBall 2
    game.scoreBall 3
    expect(game.getBallsHitIn()).toEqual [1, 2, 3]
    game.hitDeadBall 4
    expect(game.getBallsHitIn()).toEqual [1, 2, 3, 4]

  it "should be able to return a list of all balls that have been scored", ->
    game.scoreBall 1
    expect(game.getBallsScored()).toEqual [1]
    game.nextPlayerIsUp()
    game.scoreBall 2
    game.scoreBall 3
    expect(game.getBallsScored()).toEqual [1, 2, 3]
    game.hitDeadBall 4
    expect(game.getBallsScored()).toEqual [1, 2, 3]

  it "should be able to hit a safety", ->
    game.hitSafety()
    expect(game.player.one.callback().safeties).toEqual 1
    game.hitSafety()
    expect(game.player.two.callback().safeties).toEqual 1

  it "should end the current players turn when they hit a safety", ->
    game.hitSafety()
    expect(game.player.one.callback().safeties).toEqual 1
    expect(game.getCurrentlyUpPlayer().name).toEqual "James Armstead"

  it "should be able to return the game score with player one's score first (example 2-3)", ->
    game.scoreBall 1
    game.scoreBall 4
    game.nextPlayerIsUp() #Ending the Break
    game.nextPlayerIsUp() #Misses all balls
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 5
    expect(game.getGameScore()).toEqual "2-3"

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

  it "should be able to keep track of the last ball scored and who scored it", ->
    expect(game.player.one.lastBall).toEqual null
    expect(game.player.two.lastBall).toEqual null
    game.scoreBall 1
    expect(game.player.one.lastBall).toEqual 1
    expect(game.player.two.lastBall).toEqual null
    game.scoreBall 3
    expect(game.player.one.lastBall).toEqual 3
    expect(game.player.two.lastBall).toEqual null
    game.nextPlayerIsUp() #Ending the break
    game.nextPlayerIsUp() #All balls are missed
    game.scoreBall 4
    expect(game.player.one.lastBall).toEqual null
    expect(game.player.two.lastBall).toEqual 4

  describe "toJSON/fromJSON", ->
    it "should be able to take a new Game and turn it into a JSON object", ->
      expect(game.toJSON()).toEqual
        player:
          one:
            score: 0
            timeoutsTaken: 0
            nineOnSnap: false
            breakAndRun: false
            ballsHitIn: []
            deadBalls: []
            lastBall: null
          two:
            score: 0
            timeoutsTaken: 0
            nineOnSnap: false
            breakAndRun: false
            ballsHitIn: []
            deadBalls: []
            lastBall: null
        numberOfInnings: 0
        ended: false
        onBreak: true
        breakingPlayerStillShooting: true


    it "should be able to take a filled up Game and turn it into a JSON object", ->
      game.player.one.score = 2
      game.player.two.score = 13
      game.player.one.nineOnSnap = true
      game.player.one.breakAndRun = false
      game.player.two.nineOnSnap = true
      game.player.two.breakAndRun = true
      game.player.one.ballsHitIn = [1, 2]
      game.player.two.ballsHitIn = [3, 4]
      game.player.one.deadBalls = [5, 6]
      game.player.two.deadBalls = []
      game.player.one.lastBall = 1
      game.player.two.lastBall = 3
      game.numberOfInnings = 2
      game.ended = true
      game.onBreak = false
      game.breakingPlayerStillShooting = false
      game.player.one.callback().currentlyUp = true
      game.takeTimeout()
      
      expect(game.toJSON()).toEqual
        player:
          one:
            score: 2
            timeoutsTaken: 1
            nineOnSnap: true
            breakAndRun: false
            ballsHitIn: [1, 2]
            deadBalls: [5, 6]
            lastBall: 1
    
          two:
            score: 13
            timeoutsTaken: 0
            nineOnSnap: true
            breakAndRun: true
            ballsHitIn: [3, 4]
            deadBalls: [5, 6]
            lastBall: 1
    
        ended: true
        numberOfInnings: 2
        onBreak: false
        breakingPlayerStillShooting: false


    it "should be able to take a Game JSON and fill a Game object with it", ->
      game.fromJSON
        player:
          one:
            score: 4
            timeoutsTaken: 1
            nineOnSnap: false
            breakAndRun: true
            ballsHitIn: [2]
            deadBalls: [6]
            lastBall: 2
          two:
            score: 10
            timeoutsTaken: 0
            nineOnSnap: false
            breakAndRun: false
            ballsHitIn: [4]
            deadBalls: []
            lastBall: 4
        numberOfInnings: 3
        ended: false
        onBreak: false
        breakingPlayerStillShooting: false

      expect(game.player.one.score).toEqual 4
      expect(game.player.two.score).toEqual 10
      expect(game.numberOfInnings).toEqual 3
      expect(game.player.one.timeoutsTaken).toEqual 1
      expect(game.player.two.timeoutsTaken).toEqual 0
      expect(game.player.one.nineOnSnap).toEqual false
      expect(game.player.one.breakAndRun).toEqual true
      expect(game.player.two.nineOnSnap).toEqual false
      expect(game.player.two.breakAndRun).toEqual false
      expect(game.ended).toEqual false
      expect(game.player.one.ballsHitIn).toEqual [2]
      expect(game.player.two.ballsHitIn).toEqual [4]
      expect(game.player.one.deadBalls).toEqual [6]
      expect(game.player.two.deadBalls).toEqual []
      expect(game.player.one.lastBall).toEqual 2
      expect(game.player.two.lastBall).toEqual 4
      expect(game.onBreak).toEqual false
      game.addToNumberOfInnings(1)
      expect(game.numberOfInnings).toEqual 4


