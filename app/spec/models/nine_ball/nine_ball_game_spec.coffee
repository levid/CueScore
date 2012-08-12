describe "Nine Ball Game", ->
  game = undefined
  playerOne = undefined
  playerTwo = undefined
  matchCallback = undefined
  
  beforeEach ->
    matchCallback = jasmine.createSpy()
    playerOne = new NineBallPlayer("Isaac Wooten", 1, "123", "123")
    playerTwo = new NineBallPlayer("James Armstead", 1, "1", "1")
    playerOne.CurrentlyUp = true
    game = new NineBallGame(->
      playerOne
    , ->
      playerTwo
    , matchCallback)

  describe "Scoring", ->
    it "should be able to keep track of 2 Players scores", ->
      expect(game.PlayerOneScore).toNotEqual null
      expect(game.PlayerTwoScore).toNotEqual null

    it "should be able to take a ball number 1-8 and score it correctly", ->
      game.scoreBall 1
      expect(game.PlayerOneScore).toEqual 1
      playerOne.CurrentlyUp = false
      playerTwo.CurrentlyUp = true
      game.scoreBall 2
      expect(game.PlayerTwoScore).toEqual 1

    it "should be able to take ball number 9 and score it correctly", ->
      game.scoreBall 9
      expect(game.PlayerOneScore).toEqual 2

    it "should add 1 to currently up player's total score, when it adds 1 to game score", ->
      game.scoreBall 1
      expect(playerOne.Score).toEqual 1
      playerOne.CurrentlyUp = false
      playerTwo.CurrentlyUp = true
      game.scoreBall 2
      expect(playerTwo.Score).toEqual 1

    it "should only allow each ball to be scored/deadball one time", ->
      expect(playerOne.Score).toEqual 0
      game.scoreBall 1
      expect(playerOne.Score).toEqual 1
      game.scoreBall 1
      expect(playerOne.Score).toEqual 1
      game.hitDeadBall 1
      expect(game.PlayerOneDeadBalls.length).toEqual 0


  describe "Innings", ->
    it "should keep track of the number of innings", ->
      expect(game.NumberOfInnings).toEqual 0

    it "should be able to add 1 to the number of innings", ->
      game.addOneToNumberOfInnings()
      expect(game.NumberOfInnings).toEqual 1

    it "should be able to add 1 to the innings when player2's turn is over", ->
      expect(game.NumberOfInnings).toEqual 0
      game.nextPlayerIsUp()
      expect(game.NumberOfInnings).toEqual 0
      expect(playerTwo.CurrentlyUp).toEqual true
      game.nextPlayerIsUp()
      expect(game.NumberOfInnings).toEqual 1


  describe "Game Ending", ->
    it "should be able to be ended", ->
      expect(game.Ended).toBeFalsy()
      game.End()
      expect(game.Ended).toBeTruthy()

    it "should know when the match is completed with 1 point and end the game", ->
      playerOne = new NineBallPlayer("Isaac Wooten", 1, "123", "123")
      playerOne.Score = 13
      playerTwo = new NineBallPlayer("James Armstead", 1, "1", "1")
      playerOne.CurrentlyUp = true
      game = new NineBallGame(->
        playerOne
      , ->
        playerTwo
      , ->
      )
      expect(game.Ended).toEqual false
      game.scoreBall 1
      expect(game.Ended).toEqual true

    it "should know when the match is completed with 2 points and end the game", ->
      i = 1
      while i <= 13
        game.scoreBall 1
        i++
      expect(game.Ended).toEqual false
      game.scoreBall 9
      expect(game.Ended).toEqual true

    it "should execute matchEndedCallBack if match is completed", ->
      playerOne = new NineBallPlayer("Isaac Wooten", 1, "123", "123")
      playerOne.Score = 13
      playerTwo = new NineBallPlayer("James Armstead", 1, "1", "1")
      playerOne.CurrentlyUp = true
      game = new NineBallGame(->
        playerOne
      , ->
        playerTwo
      , matchCallback)
      game.scoreBall 1
      expect(matchCallback).wasCalled()

    it "should set all balls left on the table to deadballs and end the game if the Nine ball is hit in before the table is cleared", ->
      game.scoreBall 9
      expect(game.PlayerOneBallsHitIn[0]).toEqual 9
      expect(game.PlayerOneDeadBalls[0]).toEqual 1
      expect(game.PlayerOneDeadBalls[1]).toEqual 2
      expect(game.PlayerOneDeadBalls[2]).toEqual 3
      expect(game.PlayerOneDeadBalls[3]).toEqual 4
      expect(game.PlayerOneDeadBalls[4]).toEqual 5
      expect(game.PlayerOneDeadBalls[5]).toEqual 6
      expect(game.PlayerOneDeadBalls[6]).toEqual 7
      expect(game.PlayerOneDeadBalls[7]).toEqual 8
      expect(game.Ended).toEqual true


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

    it "should be able to keep track of which deadballs PlayerOne hit", ->
      expect(game.PlayerOneDeadBalls.length).toEqual 0
      game.hitDeadBall 1
      game.hitDeadBall 2
      game.hitDeadBall 3
      game.hitDeadBall 4
      expect(game.PlayerOneDeadBalls.length).toEqual 4
      expect(game.PlayerOneDeadBalls[0]).toEqual 1
      expect(game.PlayerOneDeadBalls[1]).toEqual 2
      expect(game.PlayerOneDeadBalls[2]).toEqual 3
      expect(game.PlayerOneDeadBalls[3]).toEqual 4

    it "should be able to keep track of which deadballs PlayerTwo hit", ->
      game.nextPlayerIsUp()
      expect(game.PlayerTwoDeadBalls.length).toEqual 0
      game.hitDeadBall 1
      game.hitDeadBall 2
      game.hitDeadBall 3
      game.hitDeadBall 4
      expect(game.PlayerTwoDeadBalls.length).toEqual 4
      expect(game.PlayerTwoDeadBalls[0]).toEqual 1
      expect(game.PlayerTwoDeadBalls[1]).toEqual 2
      expect(game.PlayerTwoDeadBalls[2]).toEqual 3
      expect(game.PlayerTwoDeadBalls[3]).toEqual 4

    it "should not allow the nineball to be a deadball", ->
      game.hitDeadBall 9
      expect(game.PlayerOneDeadBalls.length).toEqual 0


  it "should be able to change who is currentlyup", ->
    game.nextPlayerIsUp()
    expect(playerTwo.CurrentlyUp).toEqual true
    game.nextPlayerIsUp()
    expect(playerOne.CurrentlyUp).toEqual true

  it "should be able to know if a player is still breaking(balls scored) when they use NextPlayerIsUp while breaking", ->
    expect(game.OnBreak).toEqual true
    game.scoreBall 1
    game.nextPlayerIsUp()
    expect(playerTwo.CurrentlyUp).toEqual false
    expect(playerOne.CurrentlyUp).toEqual true

  it "should be able to know if a players turn is over(deadball) when they use NextPlayerIsUp while breaking", ->
    expect(game.OnBreak).toEqual true
    game.hitDeadBall 1
    game.nextPlayerIsUp()
    expect(playerTwo.CurrentlyUp).toEqual true
    expect(playerOne.CurrentlyUp).toEqual false

  it "should be able to know if a players turn is over(no balls scored) when they use NextPlayerIsUp while breaking", ->
    expect(game.OnBreak).toEqual true
    game.nextPlayerIsUp()
    expect(playerTwo.CurrentlyUp).toEqual true
    expect(playerOne.CurrentlyUp).toEqual false

  it "should be able to add one to currently up player", ->
    expect(game.getCurrentlyUpPlayer().Name).toEqual "Isaac Wooten"
    game.nextPlayerIsUp()
    expect(game.getCurrentlyUpPlayer().Name).toEqual "James Armstead"

  it "should be able to keep track if player one had 9 on snap", ->
    expect(game.PlayerOneNineOnSnap).toEqual false

  it "should be able to keep track if player one had break and run", ->
    expect(game.PlayerOneBreakAndRun).toEqual false

  it "should be able to keep track if player two had 9 on snap", ->
    expect(game.PlayerTwoNineOnSnap).toEqual false

  it "should be able to keep track if player one two break and run", ->
    expect(game.PlayerTwoBreakAndRun).toEqual false

  it "should know if the 9 ball is pocketed on the break and give the current player a NineOnSnap", ->
    expect(game.PlayerOneNineOnSnap).toEqual false
    game.scoreBall 9
    expect(game.PlayerOneNineOnSnap).toEqual true
    expect(playerOne.NineOnSnaps).toEqual 1

  it "should know if the 9 ball is not pocketed on the break and not give the current player a NineOnSnap", ->
    game.scoreBall 1
    game.breakIsOver()
    expect(game.PlayerOneNineOnSnap).toEqual false
    game.scoreBall 9
    expect(game.PlayerOneNineOnSnap).toEqual false
    expect(playerOne.NineOnSnaps).toEqual 0

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
    expect(game.PlayerOneNineOnSnap).toEqual false
    expect(game.PlayerOneBreakAndRun).toEqual true

  it "should be able to set player one to have a nine on snap and if not already true add one to that players total nine on snaps.", ->
    expect(game.PlayerOneNineOnSnap).toEqual false
    game.setPlayerOneNineOnSnap()
    expect(game.PlayerOneNineOnSnap).toEqual true
    expect(playerOne.NineOnSnaps).toEqual 1
    game.setPlayerOneNineOnSnap()
    expect(playerOne.NineOnSnaps).toEqual 1

  it "should be able to set player two to have a nine on snap and if not already true add one to that players total nine on snaps.", ->
    expect(game.PlayerTwoNineOnSnap).toEqual false
    game.setPlayerTwoNineOnSnap()
    expect(game.PlayerTwoNineOnSnap).toEqual true
    expect(playerTwo.NineOnSnaps).toEqual 1
    game.setPlayerTwoNineOnSnap()
    expect(playerTwo.NineOnSnaps).toEqual 1

  it "should be able to set player one to have a break and run and if not already true add one to that players total break and runs.", ->
    expect(game.PlayerOneBreakAndRun).toEqual false
    game.setPlayerOneBreakAndRun()
    expect(game.PlayerOneBreakAndRun).toEqual true
    expect(playerOne.BreakAndRuns).toEqual 1
    game.setPlayerOneBreakAndRun()
    expect(playerOne.BreakAndRuns).toEqual 1

  it "should be able to set player two to have a break and run and if not already true add one to that players total break and runs.", ->
    expect(game.PlayerTwoBreakAndRun).toEqual false
    game.setPlayerTwoBreakAndRun()
    expect(game.PlayerTwoBreakAndRun).toEqual true
    expect(playerTwo.BreakAndRuns).toEqual 1
    game.setPlayerTwoBreakAndRun()
    expect(playerTwo.BreakAndRuns).toEqual 1

  it "should know when the player breaks and then continues on to all the balls in without missing one or hitting a deadball", ->
    expect(game.OnBreak).toEqual true
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
    expect(game.OnBreak).toEqual false
    expect(game.BreakingPlayerStillHitting).toEqual true
    expect(game.PlayerOneBreakAndRun).toEqual true
    expect(playerOne.BreakAndRuns).toEqual 1

  it "should be able to keep track of which balls the player one has hit in", ->
    expect(game.PlayerOneBallsHitIn.length).toEqual 0
    game.scoreBall 1
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    expect(game.PlayerOneBallsHitIn.length).toEqual 4
    expect(game.PlayerOneBallsHitIn[0]).toEqual 1
    expect(game.PlayerOneBallsHitIn[1]).toEqual 2
    expect(game.PlayerOneBallsHitIn[2]).toEqual 3
    expect(game.PlayerOneBallsHitIn[3]).toEqual 4

  it "should be able to keep track of which balls the player two has hit in", ->
    game.nextPlayerIsUp()
    expect(game.PlayerTwoBallsHitIn.length).toEqual 0
    game.scoreBall 1
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    expect(game.PlayerTwoBallsHitIn.length).toEqual 4
    expect(game.PlayerTwoBallsHitIn[0]).toEqual 1
    expect(game.PlayerTwoBallsHitIn[1]).toEqual 2
    expect(game.PlayerTwoBallsHitIn[2]).toEqual 3
    expect(game.PlayerTwoBallsHitIn[3]).toEqual 4

  it "should be able to get the winning player's name when player's ranks are the same", ->
    game.scoreBall 1
    expect(game.getWinningPlayerName()).toEqual "Isaac W."
    game.nextPlayerIsUp() #Ending the Break
    game.nextPlayerIsUp() #Missing all balls
    game.scoreBall 2
    game.scoreBall 3
    expect(game.getWinningPlayerName()).toEqual "James A."

  it "should be able to get the winning player's name(lower rank) when player's Ranks are different", ->
    playerOne = new NineBallPlayer("Isaac Wooten", 1, "123", "123")
    playerTwo = new NineBallPlayer("James Armstead", 7, "1", "1")
    playerOne.CurrentlyUp = true
    game = new NineBallGame(->
      playerOne
    , ->
      playerTwo
    , matchCallback)
    game.scoreBall 1
    expect(game.getWinningPlayerName()).toEqual "Isaac W."
    game.nextPlayerIsUp() #Ending the Break
    game.nextPlayerIsUp() #Missing all balls
    game.scoreBall 2
    game.scoreBall 3
    expect(game.getWinningPlayerName()).toEqual "Isaac W."

  it "should be able to get the winning player's name(higher rank) when player's Ranks are different", ->
    playerOne = new NineBallPlayer("Isaac Wooten", 1, "123", "123")
    playerTwo = new NineBallPlayer("James Armstead", 7, "1", "1")
    playerOne.CurrentlyUp = true
    game = new NineBallGame(->
      playerOne
    , ->
      playerTwo
    , matchCallback)
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
    expect(game.PlayerOneCallback().Safeties).toEqual 1
    game.hitSafety()
    expect(game.PlayerTwoCallback().Safeties).toEqual 1

  it "should end the current players turn when they hit a safety", ->
    game.hitSafety()
    expect(game.PlayerOneCallback().Safeties).toEqual 1
    expect(game.getCurrentlyUpPlayer().Name).toEqual "James Armstead"

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
    expect(game.OnBreak).toEqual true

  it "should be able to have change the breaking state to false", ->
    expect(game.OnBreak).toEqual true
    game.breakIsOver()
    expect(game.OnBreak).toEqual false

  it "should know if the breaking player is still up", ->
    expect(game.BreakingPlayerStillHitting).toEqual true
    game.scoreBall 2
    game.nextPlayerIsUp() #Ends Breaking
    game.scoreBall 3
    game.scoreBall 5
    expect(game.BreakingPlayerStillHitting).toEqual true
    game.nextPlayerIsUp()
    expect(game.BreakingPlayerStillHitting).toEqual false

  it "should be able to keep track of the last ball scored and who scored it", ->
    expect(game.PlayerOneLastBall).toEqual null
    expect(game.PlayerTwoLastBall).toEqual null
    game.scoreBall 1
    expect(game.PlayerOneLastBall).toEqual 1
    expect(game.PlayerTwoLastBall).toEqual null
    game.scoreBall 3
    expect(game.PlayerOneLastBall).toEqual 3
    expect(game.PlayerTwoLastBall).toEqual null
    game.nextPlayerIsUp() #Ending the break
    game.nextPlayerIsUp() #All balls are missed
    game.scoreBall 4
    expect(game.PlayerOneLastBall).toEqual null
    expect(game.PlayerTwoLastBall).toEqual 4

  describe "toJSON/fromJSON", ->
    it "should be able to take a new Game and turn it into a JSON object", ->
      expect(game.toJSON()).toEqual
        PlayerOneScore: 0
        PlayerTwoScore: 0
        PlayerOneTimeoutsTaken: 0
        PlayerTwoTimeoutsTaken: 0
        NumberOfInnings: 0
        PlayerOneNineOnSnap: false
        PlayerOneBreakAndRun: false
        PlayerTwoNineOnSnap: false
        PlayerTwoBreakAndRun: false
        Ended: false
        PlayerOneBallsHitIn: []
        PlayerTwoBallsHitIn: []
        PlayerOneDeadBalls: []
        PlayerTwoDeadBalls: []
        PlayerOneLastBall: null
        PlayerTwoLastBall: null
        OnBreak: true
        BreakingPlayerStillHitting: true


    it "should be able to take a filled up Game and turn it into a JSON object", ->
      game.PlayerOneScore = 2
      game.PlayerTwoScore = 13
      game.NumberOfInnings = 2
      game.PlayerOneNineOnSnap = true
      game.PlayerOneBreakAndRun = false
      game.PlayerTwoNineOnSnap = true
      game.PlayerTwoBreakAndRun = true
      game.Ended = true
      game.PlayerOneBallsHitIn = [1, 2]
      game.PlayerTwoBallsHitIn = [3, 4]
      game.PlayerOneDeadBalls = [5, 6]
      game.PlayerTwoDeadBalls = []
      game.PlayerOneLastBall = 1
      game.PlayerTwoLastBall = 3
      game.OnBreak = false
      game.BreakingPlayerStillHitting = false
      game.PlayerOneCallback().CurrentlyUp = true
      game.takeTimeout()
      expect(game.toJSON()).toEqual
        PlayerOneScore: 2
        PlayerTwoScore: 13
        PlayerOneTimeoutsTaken: 1
        PlayerTwoTimeoutsTaken: 0
        NumberOfInnings: 2
        PlayerOneNineOnSnap: true
        PlayerOneBreakAndRun: false
        PlayerTwoNineOnSnap: true
        PlayerTwoBreakAndRun: true
        Ended: true
        PlayerOneBallsHitIn: [1, 2]
        PlayerTwoBallsHitIn: [3, 4]
        PlayerOneDeadBalls: [5, 6]
        PlayerTwoDeadBalls: []
        PlayerOneLastBall: 1
        PlayerTwoLastBall: 3
        OnBreak: false
        BreakingPlayerStillHitting: false


    it "should be able to take a Game JSON and fill a Game object with it", ->
      game.fromJSON
        PlayerOneScore: 4
        PlayerTwoScore: 10
        PlayerOneTimeoutsTaken: 1
        PlayerTwoTimeoutsTaken: 0
        NumberOfInnings: 3
        PlayerOneNineOnSnap: false
        PlayerOneBreakAndRun: true
        PlayerTwoNineOnSnap: false
        PlayerTwoBreakAndRun: false
        Ended: false
        PlayerOneBallsHitIn: [2]
        PlayerTwoBallsHitIn: [4]
        PlayerOneDeadBalls: [6]
        PlayerTwoDeadBalls: []
        PlayerOneLastBall: 2
        PlayerTwoLastBall: 4
        OnBreak: false
        BreakingPlayerStillHitting: false

      expect(game.PlayerOneScore).toEqual 4
      expect(game.PlayerTwoScore).toEqual 10
      expect(game.NumberOfInnings).toEqual 3
      expect(game.PlayerOneTimeoutsTaken).toEqual 1
      expect(game.PlayerTwoTimeoutsTaken).toEqual 0
      expect(game.PlayerOneNineOnSnap).toEqual false
      expect(game.PlayerOneBreakAndRun).toEqual true
      expect(game.PlayerTwoNineOnSnap).toEqual false
      expect(game.PlayerTwoBreakAndRun).toEqual false
      expect(game.Ended).toEqual false
      expect(game.PlayerOneBallsHitIn).toEqual [2]
      expect(game.PlayerTwoBallsHitIn).toEqual [4]
      expect(game.PlayerOneDeadBalls).toEqual [6]
      expect(game.PlayerTwoDeadBalls).toEqual []
      expect(game.PlayerOneLastBall).toEqual 2
      expect(game.PlayerTwoLastBall).toEqual 4
      expect(game.OnBreak).toEqual false
      game.addOneToNumberOfInnings()
      expect(game.NumberOfInnings).toEqual 4


