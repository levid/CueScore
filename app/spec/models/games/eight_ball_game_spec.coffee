describe "EightBall Game", ->
  game          = undefined
  player        = {}
  player.one    = undefined
  player.two    = undefined
  matchCallback = undefined
  
  beforeEach ->
    matchCallback = jasmine.createSpy()
    
    player.one = new $CS.Models.Player.EightBall(options = { name: "Isaac Wooten", rank: 1, playerNumber: "123", teamNumber: "123"})
    player.two = new $CS.Models.Player.EightBall(options = { name: "James Armstead", rank: 1, playerNumber: "1", teamNumber: "1"})
    
    player.one.timeouts_allowed = 2
    player.two.timeouts_allowed = 2
    player.one.currently_up     = true
    
    game = new $CS.Models.Game.EightBall(
      options = 
        addToPlayerOne: ->
          player.one
        addToPlayerTwo: ->
          player.two
        callback: matchCallback
    )
    
  afterEach ->
    game.number_of_innings = 0
    game.player.one.eight_on_snap = false
    game.player.one.break_and_run = false
    game.player.two.eight_on_snap = false
    game.player.two.break_and_run = false
    game.player.one.ball_type = null
    game.player.two.ball_type = null
    game.player.one.eight_ball = []
    game.player.two.eight_ball = []
    game.player.one.has_won = false
    game.player.two.has_won = false
    game.ended = false
    game.balls_hit_in.stripes = []
    game.balls_hit_in.solids = []
    game.last_ball_hit_in = null
    game.on_break = true
    game.breaking_player_still_shooting = true
    game.player.one.callback().currently_up = true
    game.player.two.callback().currently_up = false
    
    BreakingPlayerStillShooting = true
    EarlyEight = false
    Ended = false
    LastBallHitIn = null
    NumberOfInnings = 0
    OnBreak = true
    PlayerOneBallType = null
    PlayerOneBreakAndRun = false
    PlayerOneEightBall = []
    PlayerOneEightOnSnap = false
    PlayerOneTimeoutsTaken = 0
    PlayerOneWon = false
    PlayerTwoBallType = null
    PlayerTwoBreakAndRun = false
    PlayerTwoEightBall = []
    PlayerTwoEightOnSnap = false
    PlayerTwoTimeoutsTaken = 0
    PlayerTwoWon = false
    ScratchOnEight = false
    SolidBallsHitIn = []
    StripedBallsHitIn = []
   

  describe "Scoring", ->
    it "should be able to take a ball number 1-7 and 9-15 and score it correctly", ->
      game.scoreBall 1
      expect(game.player.one.ball_type).toEqual null
      expect(game.balls_hit_in.stripes).toEqual []
      expect(game.balls_hit_in.solids).toEqual [1]
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


  describe "Innings", ->
    it "should keep track of the number of innings", ->
      expect(game.number_of_innings).toEqual 0

    it "should be able to add 1 to the number of innings", ->
      game.addToNumberOfInnings(1)
      expect(game.number_of_innings).toEqual 1

    it "should be able to add 1 to the innings when player2's turn is over", ->
      
      expect(game.number_of_innings).toEqual 0
      game.nextPlayerIsUp()
      
      expect(game.number_of_innings).toEqual 0
      expect(player.two.currently_up).toEqual true
      
      game.nextPlayerIsUp()
      expect(game.number_of_innings).toEqual 1


  describe "Game Ending", ->
    it "should be able to be ended", ->
      expect(game.ended).toBeFalsy()
      game.end()
      expect(game.ended).toBeTruthy()

    it "should know the match has completed when the 8 his hit in", ->
      expect(game.ended).toEqual false
      game.scoreBall(8)
      expect(game.ended).toEqual true

    it "should be able to set a game as Scratch On 8", ->
      expect(game.scratch_on_eight).toEqual false
      game.hitScratchOnEight()
      expect(game.scratch_on_eight).toEqual true
      expect(game.ended).toEqual true
      expect(game.player.two.has_won).toEqual true
      expect(player.two.currently_up).toEqual true
      

  describe "Player Timeouts", ->
    it "should allow the currentplayer to be able to take a timeout", ->
      game.player.one.timeouts_taken = 0
      game.player.two.timeouts_taken = 0
      
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 2
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 1

    it "should not allow the current player to take more time outs than given", ->
      game.player.one.timeouts_taken = 0
      game.player.two.timeouts_taken = 0
    
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 2
      game.takeTimeout()
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 0
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 0

    it "should be able to return the current player's remaining number of timeouts", ->
      game.player.one.timeouts_taken = 0
      game.player.two.timeouts_taken = 0
      
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 2
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 1
      game.takeTimeout()
      expect(game.getCurrentPlayerRemainingTimeouts()).toEqual 0


  it "should be able to make a player win and add one to games won", ->
    game.setPlayerWon(1)
    expect(game.player.one.has_won).toEqual true
    expect(game.player.two.has_won).toEqual false
    expect(game.player.one.callback().games_won).toEqual 1
    expect(game.player.two.callback().games_won).toEqual 0
    game.setPlayerWon(2)
    expect(game.player.one.has_won).toEqual true
    expect(game.player.two.has_won).toEqual true
    expect(game.player.one.callback().games_won).toEqual 1
    expect(game.player.two.callback().games_won).toEqual 1

  it "should end the game and give currently player up the win if they pocket the 8 ball on break", ->
    expect(game.player.one.has_won).toEqual false
    game.scoreBall(8)
    expect(game.player.one.has_won).toEqual true
    expect(game.player.two.has_won).toEqual false

  it "should be able to end the break if no balls were hit in", ->
    game.nextPlayerIsUp()
    expect(game.on_break).toEqual false
    expect(game.breaking_player_still_shooting).toEqual false

  it "should be able to change who is currently_up", ->
    game.nextPlayerIsUp()
    expect(player.two.currently_up).toEqual true
    game.nextPlayerIsUp()
    expect(player.one.currently_up).toEqual true

  it "should be able to know if a player is still breaking(balls scored) when they use NextPlayerIsUp while breaking", ->
    expect(game.on_break).toEqual true
    game.scoreBall(1)
    game.nextPlayerIsUp()
    expect(player.two.currently_up).toEqual false
    expect(player.one.currently_up).toEqual true

  it "should be able to know if a players turn is over(no balls scored) when they use NextPlayerIsUp while breaking", ->
    expect(game.on_break).toEqual true
    game.nextPlayerIsUp()
    expect(player.two.currently_up).toEqual true
    expect(player.one.currently_up).toEqual false

  it "should be able to keep track if player one had 8 on snap", ->
    expect(game.player.one.eight_on_snap).toEqual false

  it "should be able to keep track if player one had break and run", ->
    expect(game.player.one.break_and_run).toEqual false

  it "should be able to keep track if player two had 8 on snap", ->
    expect(game.player.two.eight_on_snap).toEqual false

  it "should be able to keep track if player one two break and run", ->
    expect(game.player.one.break_and_run).toEqual false

  it "should know if the 8 ball is pocketed on the break and give the current player a EightOnSnap", ->
    expect(game.player.one.eight_on_snap).toEqual false
    game.scoreBall(8)
    expect(game.player.one.eight_on_snap).toEqual true
    expect(player.one.eight_on_snaps).toEqual 1

  it "should know if the 8 ball is not pocketed on the break and not give the current player a EightOnSnap", ->
    game.scoreBall(1)
    game.breakIsOver()
    expect(game.player.one.eight_on_snap).toEqual false
    game.scoreBall(8)
    expect(game.player.one.eight_on_snap).toEqual false
    expect(player.one.eight_on_snaps).toEqual 0

  it "should know when a player has hit all the balls in and is still breaking and only give them a 8BR", ->
    game.scoreBall(1)
    game.scoreBall(2)
    game.scoreBall(3)
    game.scoreBall(4)
    game.scoreBall(5)
    game.scoreBall(6)
    game.scoreBall(7)
    game.scoreBall(8)
    expect(game.player.one.eight_on_snap).toEqual false
    expect(game.balls_hit_in.solids.length).toEqual 7
    expect(game.ended).toEqual true
    expect(game.player.one.callback().break_and_runs).toEqual 1
    expect(game.player.one.break_and_run).toEqual true

  it "should be able to set player one to have a eight on snap and if not already true add one to that players total eight on snaps.", ->
    expect(game.player.one.eight_on_snap).toEqual false
    game.setEightOnSnapByPlayer(1)
    expect(game.player.one.eight_on_snap).toEqual true
    expect(player.one.eight_on_snaps).toEqual 1
    game.setEightOnSnapByPlayer(1)
    expect(player.one.eight_on_snaps).toEqual 1

  it "should be able to set player two to have a eight on snap and if not already true add one to that players total eight on snaps.", ->
    expect(game.player.two.eight_on_snap).toEqual false
    game.setEightOnSnapByPlayer(2)
    expect(game.player.two.eight_on_snap).toEqual true
    expect(player.two.eight_on_snaps).toEqual 1
    game.setEightOnSnapByPlayer(2)
    expect(player.two.eight_on_snaps).toEqual 1

  it "should be able to set player one to have a break and run and if not already true add one to that players total break and runs.", ->
    expect(game.player.one.break_and_run).toEqual false
    game.setBreakAndRunByPlayer(1)
    expect(game.player.one.break_and_run).toEqual true
    expect(player.one.break_and_runs).toEqual 1
    game.setBreakAndRunByPlayer(1)
    expect(player.one.break_and_runs).toEqual 1

  it "should be able to tell if the game is an early eight ball", ->
    game.shotMissed()
    game.scoreBall(8)
    expect(game.early_eight).toEqual true

  it "should be able to set player two to have a break and run and if not already true add one to that players total break and runs.", ->
    expect(game.player.two.break_and_run).toEqual false
    game.setBreakAndRunByPlayer(2)
    expect(game.player.two.break_and_run).toEqual true
    expect(player.two.break_and_runs).toEqual 1
    game.setBreakAndRunByPlayer(2)
    expect(player.two.break_and_runs).toEqual 1

  it "should know when the player breaks and then continues on to all the balls in without missing one", ->
    expect(game.on_break).toEqual true
    game.scoreBall(1)
    game.nextPlayerIsUp()
    game.scoreBall(2)
    game.scoreBall(3)
    game.scoreBall(4)
    game.scoreBall(5)
    game.scoreBall(6)
    game.scoreBall(7)
    game.scoreBall(8)
    expect(game.on_break).toEqual false
    expect(game.breaking_player_still_shooting).toEqual true
    expect(game.player.one.break_and_run).toEqual true
    expect(player.one.break_and_runs).toEqual 1

  it "should able to assign a ball type after the break if only one ball type has been hit in", ->
    game.on_break = false
    game.scoreBall(1)
    game.nextPlayerIsUp()
    expect(game.player.one.ball_type).toEqual 2
    expect(game.player.two.ball_type).toEqual 1

  it "should able to assign a ball type after the break if only one ball type has been hit in", ->
    game.on_break = false
    game.scoreBall(9)
    game.nextPlayerIsUp()
    expect(game.player.one.ball_type).toEqual 1
    expect(game.player.two.ball_type).toEqual 2

  it "should be able to keep track of which solid balls have been hit in", ->
    expect(game.balls_hit_in.solids.length).toEqual 0
    game.scoreBall(1)
    game.scoreBall(2)
    game.scoreBall(3)
    game.scoreBall(4)
    expect(game.balls_hit_in.solids.length).toEqual 4
    expect(game.balls_hit_in.solids[0]).toEqual 1
    expect(game.balls_hit_in.solids[1]).toEqual 2
    expect(game.balls_hit_in.solids[2]).toEqual 3
    expect(game.balls_hit_in.solids[3]).toEqual 4

  it "should be able to keep track of which striped balls have been hit in", ->
    expect(game.balls_hit_in.stripes.length).toEqual 0
    game.scoreBall(9)
    game.scoreBall(10)
    game.scoreBall(11)
    game.scoreBall(12)
    expect(game.balls_hit_in.stripes.length).toEqual 4
    expect(game.balls_hit_in.stripes[0]).toEqual 9
    expect(game.balls_hit_in.stripes[1]).toEqual 10
    expect(game.balls_hit_in.stripes[2]).toEqual 11
    expect(game.balls_hit_in.stripes[3]).toEqual 12

  it "should be able to set player one to striped balls", ->
    expect(game.player.one.ball_type).toEqual null
    game.setBallTypeByPlayer(1, 'stripes')
    expect(game.player.one.ball_type).toEqual game.stripes
    expect(game.player.two.ball_type).toEqual game.solids

  it "should be able to set player one to solid balls", ->
    expect(game.player.one.ball_type).toEqual null
    game.setBallTypeByPlayer(1, 'solids')
    expect(game.player.one.ball_type).toEqual game.solids
    expect(game.player.two.ball_type).toEqual game.stripes

  it "should be able to set player two to striped balls", ->
    expect(game.player.one.ball_type).toEqual null
    game.setBallTypeByPlayer(2, 'stripes')
    expect(game.player.two.ball_type).toEqual game.stripes
    expect(game.player.one.ball_type).toEqual game.solids

  it "should be able to set player two to solid balls", ->
    expect(game.player.two.ball_type).toEqual null
    game.setBallTypeByPlayer(2, 'solids')
    expect(game.player.two.ball_type).toEqual game.solids
    expect(game.player.one.ball_type).toEqual game.stripes

  it "should be able to find out if there is a winner if a player hits a BR and set that player to won", ->
    game.scoreBall 1
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    expect(game.player.one.has_won).toEqual false
    game.scoreBall 5
    game.scoreBall 6
    game.scoreBall 7
    game.scoreBall 8
    expect(game.getBallsHitInByPlayer(1).indexOf(8) >= 0).toEqual true
    expect(game.player.one.has_won).toEqual true

  it "should be able to find out if there is a winner if player two wins and set that player to won", ->
    game.scoreBall 1
    game.breakIsOver()
    game.nextPlayerIsUp()
    game.checkForWinner()
    expect(game.player.one.has_won).toEqual false
    game.scoreBall 9
    game.scoreBall 10
    game.scoreBall 11
    game.scoreBall 12
    game.scoreBall 13
    game.scoreBall 14
    game.scoreBall 15
    game.scoreBall 8
    expect(game.player.two.has_won).toEqual true

  it "should be able to find out if there is a winner after ball type has been selected and set that player to won", ->
    game.scoreBall 1
    game.scoreBall 10
    game.breakIsOver()
    game.nextPlayerIsUp()
    game.checkForWinner()
    expect(game.player.one.has_won).toEqual false
    game.scoreBall 9
    game.setBallTypeByPlayer(2, 'solids')
    game.scoreBall 11
    game.scoreBall 12
    game.scoreBall 13
    game.scoreBall 14
    game.scoreBall 15
    game.scoreBall 8
    expect(game.player.one.has_won).toEqual true

  it "should return winning players name", ->
    game.scoreBall 1
    game.scoreBall 2
    game.scoreBall 3
    game.scoreBall 4
    game.scoreBall 5
    game.scoreBall 6
    game.scoreBall 7
    game.scoreBall 8
    expect(game.getWinningPlayerName()).toEqual "Isaac W."

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

  it "should end the current players turn when they hit a safety", ->
    game.hitSafety()
    expect(game.player.one.callback().safeties).toEqual 1
    expect(game.getCurrentlyUpPlayer().name).toEqual "James Armstead"

  it "should be able to return the game score with player one's score first (example 2-3)", ->
    game.scoreBall 1
    game.scoreBall 4
    game.nextPlayerIsUp() #Ending the Break
    game.nextPlayerIsUp() #Misses all balls
    game.scoreBall 10
    game.scoreBall 11
    game.scoreBall 12
    expect(game.getGameScore()).toEqual "2-3"

  it "should be able to have a state of breaking", ->
    expect(game.on_break).toEqual true

  it "should be able to have change the breaking state to false", ->
    expect(game.on_break).toEqual true
    game.breakIsOver()
    expect(game.on_break).toEqual false

  it "should know if the breaking player is still up", ->
    expect(game.breaking_player_still_shooting).toEqual true
    game.scoreBall 2
    game.nextPlayerIsUp() #Ends Breaking
    game.scoreBall 3
    game.scoreBall 5
    expect(game.breaking_player_still_shooting).toEqual true
    game.nextPlayerIsUp()
    expect(game.breaking_player_still_shooting).toEqual false

  it "should be able to keep track of the last ball scored", ->
    expect(game.last_ball_hit_in).toEqual null
    game.scoreBall 1
    expect(game.last_ball_hit_in).toEqual 1
    game.scoreBall 3
    expect(game.last_ball_hit_in).toEqual 3
    game.nextPlayerIsUp() #Ending the break
    game.nextPlayerIsUp() #All balls are missed
    game.scoreBall 4
    expect(game.last_ball_hit_in).toEqual 4

  it "should end the game if a player hits the 8 ball in when it is not their last ball or on break", ->
    game.scoreBall 1
    game.nextPlayerIsUp()
    game.scoreBall 12
    game.nextPlayerIsUp()
    game.scoreBall 8
    expect(game.player.two.eight_ball).toEqual [8]
    expect(game.ended).toEqual true
    expect(game.player.one.has_won).toEqual true

  describe "toJSON/fromJSON", ->
    
    it "should be able to take a new Game and turn it into a JSON object", ->
      expect(game.toJSON()).toEqual
        BreakingPlayerStillShooting: true
        EarlyEight: false
        Ended: false
        LastBallHitIn: null
        NumberOfInnings: 0
        OnBreak: true
        PlayerOneBallType: null
        PlayerOneBreakAndRun: false
        PlayerOneEightBall: []
        PlayerOneEightOnSnap: false
        PlayerOneTimeoutsTaken: 2
        PlayerOneWon: false
        PlayerTwoBallType: null
        PlayerTwoBreakAndRun: false
        PlayerTwoEightBall: []
        PlayerTwoEightOnSnap: false
        PlayerTwoTimeoutsTaken: 0
        PlayerTwoWon: false
        ScratchOnEight: false
        SolidBallsHitIn: []
        StripedBallsHitIn: []

    it "should be able to take a filled up Game and turn it into a JSON object", ->
      game.number_of_innings = 2
      game.player.one.eight_on_snap = true
      game.player.one.break_and_run = false
      game.player.two.eight_on_snap = true
      game.player.two.break_and_run = true
      game.player.one.ball_type = 1
      game.player.two.ball_type = 2
      game.player.one.eight_ball = []
      game.player.two.eight_ball = [8]
      game.player.one.has_won = true
      game.player.two.has_won = false
      game.ended = true
      game.balls_hit_in.stripes = [1, 2]
      game.balls_hit_in.solids = [9, 10]
      game.last_ball_hit_in = 1
      game.on_break = false
      game.breaking_player_still_shooting = false
      game.player.one.callback().currently_up = true
      game.takeTimeout()
      
      expect(game.toJSON()).toEqual
        BreakingPlayerStillShooting: false
        EarlyEight: false
        Ended: true
        LastBallHitIn: 1
        NumberOfInnings: 2
        OnBreak: false
        PlayerOneBallType: 1
        PlayerOneBreakAndRun: false
        PlayerOneEightBall: []
        PlayerOneEightOnSnap: true
        PlayerOneTimeoutsTaken: 2
        PlayerOneWon: true
        PlayerTwoBallType: 2
        PlayerTwoBreakAndRun: true
        PlayerTwoEightBall: [ 8 ]
        PlayerTwoEightOnSnap: true
        PlayerTwoTimeoutsTaken: 0
        PlayerTwoWon: false
        ScratchOnEight: false
        SolidBallsHitIn: [ 9, 10 ]
        StripedBallsHitIn: [ 1, 2 ]


    it "should be able to take a Game JSON and fill a Game object with it", ->
      game.fromJSON
        BreakingPlayerStillShooting: false
        EarlyEight: false
        Ended: true
        LastBallHitIn: [2]
        NumberOfInnings: 2
        OnBreak: false
        PlayerOneBallType: 1
        PlayerOneBreakAndRun: false
        PlayerOneEightBall: []
        PlayerOneEightOnSnap: true
        PlayerOneTimeoutsTaken: 1
        PlayerOneWon: true
        PlayerTwoBallType: 2
        PlayerTwoBreakAndRun: true
        PlayerTwoEightBall: [ 8 ]
        PlayerTwoEightOnSnap: true
        PlayerTwoTimeoutsTaken: 0
        PlayerTwoWon: false
        ScratchOnEight: false
        SolidBallsHitIn: [ 10 ]
        StripedBallsHitIn: [ 2 ]
    
      expect(game.number_of_innings).toEqual 2
      expect(game.player.one.timeouts_taken).toEqual 1
      expect(game.player.two.timeouts_taken).toEqual 0
      expect(game.player.one.eight_on_snap).toEqual true
      expect(game.player.one.break_and_run).toEqual false
      expect(game.player.two.eight_on_snap).toEqual true
      expect(game.player.two.break_and_run).toEqual true
      expect(game.player.one.ball_type).toEqual 1
      expect(game.player.two.ball_type).toEqual 2
      expect(game.player.one.eight_ball).toEqual []
      expect(game.player.two.eight_ball).toEqual [8]
      expect(game.player.one.has_won).toEqual true
      expect(game.player.two.has_won).toEqual false
      expect(game.ended).toEqual true
      expect(game.balls_hit_in.stripes).toEqual [2]
      expect(game.balls_hit_in.solids).toEqual [10]
      expect(game.last_ball_hit_in).toEqual [2]
      expect(game.on_break).toEqual false
      game.addToNumberOfInnings(1)
      expect(game.number_of_innings).toEqual 3


