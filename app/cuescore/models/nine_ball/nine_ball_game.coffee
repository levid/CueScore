Array::exists = (search) ->
  i = 0

  while i < @length
    return true  if this[i] is search
    i++
  false

class Game extends $CS.Models.NineBall
  defaults: 
    player:
      one:
        score: 0
        nineOnSnap: false
        breakAndRun: false
        ballsHitIn: []
        deadBalls: []
        lastBall: null
        timeoutsTaken: 0
        callback: ->
      two:
        score: 0
        nineOnSnap: false
        breakAndRun: false
        ballsHitIn: []
        deadBalls: []
        lastBall: null
        timeoutsTaken: 0
        callback: ->
    numberOfInnings: 0
    ended: false
    onBreak: true
    breakingPlayerStillShooting: true
    matchEndedCallback: ->
  
  constructor: (options) ->
    _.extend @, @defaults
    
    @player.one.callback  = options.addToPlayerOne
    @player.two.callback  = options.addToPlayerTwo
    @matchEndedCallback   = options.callback
    
    @player.one.callback().timeoutsTaken = 0
    @player.two.callback().timeoutsTaken = 0
    
  # Getters
    
  getCurrentlyUpPlayer: ->
    if @player.one.callback().currentlyUp is true
      return @player.one.callback()
    else
      return @player.two.callback()

  getDeadBalls: ->
    @player.one.deadBalls.length + @player.two.deadBalls.length

  getScoreRatio: (playerScore, playerBallCount) ->
    playerScore / playerBallCount
    
  getWinningPlayerName: ->
    if @getScoreRatio(@player.one.score, @player.one.callback().ballCount) > @getScoreRatio(@player.two.score, @player.two.callback().ballCount)
      return @player.one.callback().getFirstNameWithInitials()
    else if @getScoreRatio(@player.one.score, @player.one.callback().ballCount) < @getScoreRatio(@player.two.score, @player.two.callback().ballCount)
      return @player.two.callback().getFirstNameWithInitials()  
    else
      return "Tie"

  getGameScore: ->
    @player.one.score + "-" + @player.two.score

  getBallsHitInByPlayer: (playerNum) ->
    if playerNum is 1
      @player.one.ballsHitIn.concat @player.one.deadBalls
    else if playerNum is 2
      @player.two.ballsHitIn.concat @player.two.deadBalls

  getBallsHitIn: ->
    @player.one.ballsHitIn.concat(@player.two.ballsHitIn).concat(@player.one.deadBalls).concat @player.two.deadBalls

  getBallsScored: ->
    @player.one.ballsHitIn.concat @player.two.ballsHitIn

  getCurrentPlayerRemainingTimeouts: ->
    if @player.one.callback().currentlyUp is true
      return (@player.one.callback().timeoutsAllowed - @player.one.timeoutsTaken).toString()
    else
      return (@player.two.callback().timeoutsAllowed - @player.two.timeoutsTaken).toString()

  # Setters

  setNineOnSnapByPlayer: (playerNum) ->
    if playerNum is 1
      @player.one.callback().addToNineOnSnaps(1)  unless @player.one.nineOnSnap is true
      @player.one.nineOnSnap = true
    else if playerNum is 2
      @player.two.callback().addToNineOnSnaps(1)  unless @player.two.nineOnSnap is true
      @player.two.nineOnSnap = true

  setBreakAndRunByPlayer: (playerNum) ->
    if playerNum is 1
      @player.one.callback().addToBreakAndRuns(1)  unless @player.one.breakAndRun is true
      @player.one.breakAndRun = true
    else if playerNum is 2
      @player.two.callback().addToBreakAndRuns(1)  unless @player.two.breakAndRun is true
      @player.two.breakAndRun = true

  # Methods
  
  hitSafety: ->
    @getCurrentlyUpPlayer().addToSafeties(1)
    @nextPlayerIsUp()
    
  hitDeadBall: (ballNumber) ->
    if ballNumber isnt 9 and not @getBallsHitIn().exists(ballNumber)
      @deadBalls += 1
      if @player.one.callback().currentlyUp is true
        @player.one.deadBalls.push ballNumber
      else
        @player.two.deadBalls.push ballNumber

      @checkIfAllBallsAreHitIn()

  takeTimeout: ->
    if @getCurrentPlayerRemainingTimeouts() > 0
      if @player.one.callback().currentlyUp is true
        @player.one.timeoutsTaken += 1
      else
        @player.two.timeoutsTaken += 1
        
  checkIfAllBallsAreHitIn: ->
    allBallsHitIn = @getBallsHitIn()
    @ended = (allBallsHitIn.length is 9)
    if @ended is false
      if allBallsHitIn.exists(9)
        i = 1
        while i < 9
          unless allBallsHitIn.exists(i) is true
            if @player.one.callback().currentlyUp is true
              @player.one.deadBalls.push i
            else
              @player.two.deadBalls.push i
          i++
        @ended = true
    if @ended is true and @getBallsScored().length is 9
      if @player.one.callback().currentlyUp is true and @breakingPlayerStillShooting is true
        @setBreakAndRunByPlayer(1)
      else if @player.two.callback().currentlyUp is true and @breakingPlayerStillShooting is true
        @setBreakAndRunByPlayer(2) 

  scoreBall: (ballNumber) ->
    unless @getBallsHitIn().indexOf(ballNumber) >= 0 and !@getBallsHitIn().exists(9)
      if @player.one.callback().currentlyUp is true
        if ballNumber > 0 and ballNumber < 9
          @player.one.score += 1
          @player.one.callback().addToScore 1
        else
          @player.one.score += 2
          @player.one.callback().addToScore 2
          @setNineOnSnapByPlayer(1) if @onBreak is true and @getBallsScored().length isnt 8
          
        @player.one.lastBall = ballNumber
        @player.two.lastBall = null
        @player.one.ballsHitIn.push ballNumber
      else
        if ballNumber > 0 and ballNumber < 9
          @player.two.score += 1
          @player.two.callback().addToScore 1
        else
          @player.two.score += 2
          @player.two.callback().addToScore 2
          @setNineOnSnapByPlayer(2) if @onBreak is true and @getBallsScored().length isnt 8
          
        @player.two.lastBall = ballNumber
        @player.one.lastBall = null
        @player.two.ballsHitIn.push ballNumber
        
      @checkIfAllBallsAreHitIn()
      @checkForWinner()

  checkForWinner: ->
    if @player.one.callback().hasWon() is true or @player.two.callback().hasWon() is true
      @end()
      @matchEndedCallback()

  addToNumberOfInnings: (num) ->
    @numberOfInnings += num

  nextPlayerIsUp: ->
    if @onBreak isnt true or ((@player.two.callback().currentlyUp is true and @player.two.ballsHitIn.length is 0) or (@player.one.callback().currentlyUp is true and @player.one.ballsHitIn.length is 0))
      if @player.one.callback().currentlyUp is true
        @player.two.callback().currentlyUp = true
        @player.one.callback().currentlyUp = false
      else if @player.two.callback().currentlyUp is true
        @player.two.callback().currentlyUp = false
        @player.one.callback().currentlyUp = true
        @addToNumberOfInnings(1)
      else
        @player.one.callback().currentlyUp = true
        
      @breakingPlayerStillShooting = false
      
    @onBreak = false

  breakIsOver: ->
    @onBreak = false

  end: ->
    @ended = true

  toJSON: ->
    playerOneScore:               @player.one.score
    playerOneTimeoutsTaken:       @player.one.timeoutsTaken
    playerOneNineOnSnap:          @player.one.nineOnSnap
    playerOneBreakAndRun:         @player.one.breakAndRun
    playerOneBallsHitIn:          @player.one.ballsHitIn
    playerOneDeadBalls:           @player.one.deadBalls
    playerOneLastBall:            @player.one.lastBall
    playerTwoScore:               @player.two.score
    playerTwoTimeoutsTaken:       @player.two.timeoutsTaken
    playerTwoNineOnSnap:          @player.two.nineOnSnap
    playerTwoBreakAndRun:         @player.two.breakAndRun
    playerTwoBallsHitIn:          @player.two.ballsHitIn
    playerTwoDeadBalls:           @player.one.deadBalls
    playerTwoLastBall:            @player.one.lastBall
    ended:                        @ended
    numberOfInnings:              @numberOfInnings
    onBreak:                      @onBreak
    breakingPlayerStillShooting:  @breakingPlayerStillShooting

  fromJSON: (gameJSON) ->
    @player.one.score             = gameJSON.playerOneScore
    @player.two.score             = gameJSON.playerTwoScore
    
    @player.one.timeoutsTaken     = gameJSON.playerOneTimeoutsTaken
    @player.two.timeoutsTaken     = gameJSON.playerTwoTimeoutsTaken
    @player.one.nineOnSnap        = gameJSON.playerOneNineOnSnap
    @player.one.breakAndRun       = gameJSON.playerOneBreakAndRun
    @player.two.nineOnSnap        = gameJSON.playerTwoNineOnSnap
    @player.two.breakAndRun       = gameJSON.playerTwoBreakAndRun
    
    @player.one.ballsHitIn        = gameJSON.playerOneBallsHitIn
    @player.two.ballsHitIn        = gameJSON.playerTwoballsHitIn
    @player.one.deadBalls         = gameJSON.playerOneDeadBalls
    @player.two.deadBalls         = gameJSON.playerTwodeadBalls
    @player.one.lastBall          = gameJSON.playerOneLastBall
    @player.two.lastBall          = gameJSON.playerTwolastBall
    @numberOfInnings              = gameJSON.numberOfInnings
    @ended                        = gameJSON.ended
    @onBreak                      = gameJSON.onBreak
    @breakingPlayerStillShooting  = gameJSON.breakingPlayerStillShooting

$CS.Models.NineBall.Game = Game
