class Game extends $CS.Models.EightBall
  defaults:
    stripes: 1
    solids: 2
    innings: 0
    numberOfInnings: 0
    ended: false
    ballsHitIn:
      stripes: []
      solids: []
    lastBallHitIn: null
    onBreak: true
    breakingPlayerStillShooting: true
    scratchOnEight: false
    earlyEight: false
    playerOneWon: false
    playerTwoWon: false
    matchEndedCallback: ->
    player:
      one:
        eightBall: []
        eightOnSnap: false
        breakAndRun: false
        timeoutsTaken: 0
        ballType: null
        callback: ->
      two:
        eightBall: []
        eightOnSnap: false
        breakAndRun: false
        timeoutsTaken: 0
        ballType: null
        callback: ->

  constructor: (options) ->
    _.extend @, @defaults
    
    @player.one.callback  = options.addToPlayerOne
    @player.two.callback  = options.addToPlayerTwo
    @matchEndedCallback = options.callback
    
    @player.one.timeoutsTaken = 0;
    @player.two.timeoutsTaken = 0;

  # Getters
  
  getCurrentlyUpPlayer: ->
    if @player.one.callback().currentlyUp is true
      return @player.one.callback()
    else
      return @player.two.callback()
    
  getCurrentlyUpTeamNumber: ->
    if @player.one.callback().currentlyUp is true
      return @player.one.callback().teamNumber
    else
      return @player.two.callback().teamNumber
    
  getWinningPlayer: ->
    if @playerOneWon is true
      return @player.one
    else if @playerTwoWon is true
      return @player.two
  
  getWinningPlayerName: ->
    @getWinningPlayer().callback().getFirstNameWithInitials()
    
  getBallsHitInByPlayer: (playerNum) ->
    if playerNum == 1
      if @player.one.ballType is @stripes
        return @ballsHitIn.stripes.concat(@player.one.eightBall)
      else 
        return @ballsHitIn.solids.concat(@player.one.eightBall) if @player.one.ballType is @solids
        return []
    if playerNum == 2
      if @player.two.ballType is @stripes
        return @ballsHitIn.stripes.concat(@player.two.eightBall)
      else 
        return @ballsHitIn.solids.concat(@player.two.eightBall) if @player.two.ballType is @solids
        return []

  getGameScore: ->
    @getBallsHitInByPlayer(1).length + "-" + @getBallsHitInByPlayer(2).length

  getBallsHitIn: ->
    @ballsHitIn.solids.concat(@ballsHitIn.stripes.concat(@player.two.eightBall.concat(@player.one.eightBall)))
    
  getCurrentPlayerRemainingTimeouts: ->
    if @player.one.callback().currentlyUp is true
      return (@player.one.callback().timeouts_allowed - @player.one.timeoutsTaken)
    else
      return (@player.two.callback().timeouts_allowed - @player.two.timeoutsTaken)
      
  getScoreRatio = (playerScore, playerBallCount) ->
    playerScore / playerBallCount
    
  # Setters
  
  setPlayerWon: (playerNum) ->
    if playerNum == 1
      @playerOneWon = true
      @player.one.callback().gamesWon += 1
    else if playerNum == 2
      @playerTwoWon = true
      @player.two.callback().gamesWon += 1
      
  setEightOnSnapByPlayer: (playerNum) ->
    if playerNum == 1
      @player.one.callback().addToEightOnSnaps(1) unless @player.one.eightOnSnap is true
      @player.one.eightOnSnap = true
    else if playerNum == 2
      @player.two.callback().addToEightOnSnaps(1) unless @player.two.eightOnSnap is true
      @player.two.eightOnSnap = true

  setBreakAndRunByPlayer: (playerNum) ->
    if playerNum == 1
      @player.one.callback().addToBreakAndRuns(1) unless @player.one.breakAndRun is true
      @player.one.breakAndRun = true
    else if playerNum == 2
      @player.two.callback().addToBreakAndRuns(1) unless @player.two.breakAndRun is true
      @player.two.breakAndRun = true

  setBallTypeByPlayer: (playerNum, type) ->
    if playerNum is 1 and type is "stripes"
      @player.one.ballType = @stripes
      @player.two.ballType = @solids
      @checkForWinner()
    else if playerNum is 2 and type is "stripes"
      @player.two.ballType = @stripes
      @player.one.ballType = @solids
      @checkForWinner()
    else if playerNum is 1 && type is "solids"
      @player.one.ballType = @solids
      @player.two.ballType = @stripes
      @checkForWinner()
    else if playerNum is 2 && type is "solids"
      @player.two.ballType = @solids
      @player.one.ballType = @stripes
      @checkForWinner()
      
  # Methods

  hitSafety: ->
    @getCurrentlyUpPlayer().addToSafeties(1)
    @nextPlayerIsUp()

  hitScratchOnEight: ->
    @scratchOnEight = true
    @ended = true
    
    if @player.one.callback().currentlyUp is true
      @playerTwoWon = true
      @player.one.callback().currentlyUp = false
      @player.two.callback().currentlyUp = true
    else
      @playerOneWon = true
      @player.two.callback().currentlyUp = false
      @player.one.callback().currentlyUp = true
      
    @matchEndedCallback()
  
  shotMissed: ->
    @nextPlayerIsUp()

  addToNumberOfInnings: (num) ->
    @numberOfInnings += num
    
  takeTimeout: ->
    if @getCurrentPlayerRemainingTimeouts() > 0
      if @player.one.callback().currentlyUp is true
        @player.one.timeoutsTaken += 1
      else
        @player.two.timeoutsTaken += 1

  breakIsOver: ->
    @onBreak = false

  end: ->
    @ended = true
    
  scoreBall: (ballNumber) ->
    unless @getBallsHitIn().indexOf(ballNumber) > 0
      @lastBallHitIn = ballNumber
      
      if ballNumber > 0 and ballNumber < 8
        @ballsHitIn.solids.push ballNumber
      else if ballNumber > 8 and ballNumber < 16
        @ballsHitIn.stripes.push ballNumber
      else
        if @player.one.callback().currentlyUp is true
          @player.one.eightBall.push ballNumber
        else 
          @player.two.eightBall.push ballNumber if @player.two.callback().currentlyUp is true
        
        if @onBreak is true
          if @ballsHitIn.solids.length isnt 7 and @ballsHitIn.stripes.length isnt 7
            if @player.one.callback().currentlyUp is true
              @setEightOnSnapByPlayer(1)
            else @setEightOnSnapByPlayer(2)  if @player.two.callback().currentlyUp is true
        else
          if @ballsHitIn.solids.length isnt 7 and @ballsHitIn.stripes.length isnt 7
            @earlyEight = true
            
            if @player.one.callback().currentlyUp is true
              @player.one.callback().currentlyUp = false
              @player.two.callback().currentlyUp = true
            else if @player.two.callback().currentlyUp is true
              @player.one.callback().currentlyUp = true
              @player.two.callback().currentlyUp = false

      @checkForWinner()
      
  checkForWinner: ->
    @ended = true if @getBallsHitIn().indexOf(8) >= 0
    if @ended is true
     
      # Break and run
      if @breakingPlayerStillShooting is true and (@ballsHitIn.solids.length is 7 or @ballsHitIn.stripes.length is 7)
        
        # Player 1 broke and ran out
        if @player.one.callback().currentlyUp is true
          @setBreakAndRunByPlayer(1)
          
          @player.one.ballType = @solids
          @player.two.ballType = @stripes
        
        # Player 2 broke and ran out
        else if @player.two.callback().currentlyUp is true
          @setBreakAndRunByPlayer(2)
          
          @player.two.ballType = @solids
          @player.one.ballType = @stripes
            
      # Player 1 made the 8 ball (not on break)
      if @player.one.eightBall.indexOf(8) >= 0 and @onBreak is false
        
        # Neither player made 8 balls so it is a loss by player 1
        if @getBallsHitInByPlayer(1).length != 8 and @getBallsHitInByPlayer(2).length != 8
          @setPlayerWon(2)
        # Player 1 made all 8 balls so they win the game
        else if @getBallsHitInByPlayer(1).length == 8
          @setPlayerWon(1)
          
      # Player 2 made the 8 ball (not on break)
      else if @player.two.eightBall.indexOf(8) >= 0 and @onBreak is false
      
        # Neither player made 8 balls so it is a loss by player 2
        if @getBallsHitInByPlayer(1).length != 8 and @getBallsHitInByPlayer(2).length != 8
          @setPlayerWon(1) 
        # Player 2 made all 8 balls so they win the game
        else if @getBallsHitInByPlayer(2).length == 8
          @setPlayerWon(2)
          
      # The 8 ball was made on the break
      else
        # Player 1 made the 8 on the break
        if @player.one.callback().currentlyUp is true
          @setPlayerWon(1)
        # Player 2 made the 8 on the break
        else if @player.two.callback().currentlyUp is true
          @setPlayerWon(2) 

      @matchEndedCallback()

  nextPlayerIsUp: ->
    if @onBreak isnt true or ((@player.two.callback().currentlyUp is true or @player.one.callback().currentlyUp is true) and @getBallsHitIn().length is 0)
      if @player.one.callback().currentlyUp is true
        @player.two.callback().currentlyUp = true
        @player.one.callback().currentlyUp = false
        
        unless @player.one.ballType?
          if @ballsHitIn.solids.length > 0 and @ballsHitIn.stripes.length is 0
            @player.one.ballType = @solids
            @player.two.ballType = @stripes
          else if @ballsHitIn.solids.length is 0 and @ballsHitIn.stripes.length > 0
            @player.one.ballType = @stripes
            @player.two.ballType = @solids
            
      else if @player.two.callback().currentlyUp is true
        
        @player.two.callback().currentlyUp = false
        @player.one.callback().currentlyUp = true
        @addToNumberOfInnings(1)
        
        unless @player.two.ballType?
          
          if @ballsHitIn.solids.length is 0 and @ballsHitIn.stripes.length > 0
            @player.one.ballType = @solids
            @player.two.ballType = @stripes
          else if @ballsHitIn.solids.length > 0 and @ballsHitIn.stripes.length is 0
            @player.one.ballType = @stripes
            @player.two.ballType = @solids
      else
        @player.one.callback().currentlyUp = true
        
      @breakingPlayerStillShooting = false
      
    @onBreak = false
    
  # JSON Data

  toJSON: ->
    playerOneTimeoutsTaken:         @player.one.timeoutsTaken
    playerTwoTimeoutsTaken:         @player.two.timeoutsTaken
    playerOneEightOnSnap:           @player.one.eightOnSnap
    playerOneBreakAndRun:           @player.one.breakAndRun
    playerTwoEightOnSnap:           @player.two.eightOnSnap
    playerTwoBreakAndRun:           @player.two.breakAndRun
    playerOneBallType:              @player.one.ballType
    playerTwoBallType:              @player.two.ballType
    playerOneEightBall:             @player.one.eightBall
    playerTwoEightBall:             @player.two.eightBall
    playerOneWon:                   @playerOneWon
    playerTwoWon:                   @playerTwoWon
    numberOfInnings:                @numberOfInnings
    earlyEight:                     @earlyEight
    scratchOnEight:                 @scratchOnEight
    breakingPlayerStillShooting:    @breakingPlayerStillShooting
    stripedBallsHitIn:              @ballsHitIn.stripes
    solidBallsHitIn:                @ballsHitIn.solids
    lastBallHitIn:                  @lastBallHitIn
    onBreak:                        @onBreak
    ended:                          @ended
    
  fromJSON: (gameJSON) ->
    @player.one.timeoutsTaken       = gameJSON.playerOneTimeoutsTaken
    @player.two.timeoutsTaken       = gameJSON.playerTwoTimeoutsTaken
    @player.one.eightOnSnap         = gameJSON.playerOneEightOnSnap
    @player.one.breakAndRun         = gameJSON.playerOneBreakAndRun
    @player.two.eightOnSnap         = gameJSON.playerTwoEightOnSnap
    @player.two.breakAndRun         = gameJSON.playerTwoBreakAndRun
    @player.one.ballType            = gameJSON.playerOneBallType
    @player.two.ballType            = gameJSON.playerTwoBallType
    @player.one.eightBall           = gameJSON.playerOneEightBall
    @player.two.eightBall           = gameJSON.playerTwoEightBall
    @playerOneWon                   = gameJSON.playerOneWon
    @playerTwoWon                    = gameJSON.playerTwoWon
    @numberOfInnings                = gameJSON.numberOfInnings
    @breakingPlayerStillShooting    = gameJSON.breakingPlayerStillShooting
    @ballsHitIn.solids              = gameJSON.solidBallsHitIn
    @ballsHitIn.stripes             = gameJSON.stripedBallsHitIn
    @lastBallHitIn                  = gameJSON.lastBallHitIn
    @onBreak                        = gameJSON.onBreak
    @ended                          = gameJSON.ended
  
$CS.Models.EightBall.Game = Game
