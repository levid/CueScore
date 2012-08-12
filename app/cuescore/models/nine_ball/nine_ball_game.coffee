class Game extends $CS.Models.NineBall
  defaults: {}
  
  constructor: (addToPlayerOne, addToPlayerTwo, callback) ->
    _.extend @, @defaults
    
    @PlayerOneCallback = addToPlayerOne
    @PlayerTwoCallback = addToPlayerTwo
    @PlayerOneCallback().TimeoutsTaken = 0
    @PlayerTwoCallback().TimeoutsTaken = 0
    @MatchEndedCallback = callback
    @PlayerOneScore = 0
    @PlayerTwoScore = 0
    @NumberOfInnings = 0
    @PlayerOneNineOnSnap = false
    @PlayerOneBreakAndRun = false
    @PlayerTwoNineOnSnap = false
    @PlayerTwoBreakAndRun = false
    @Ended = false
    @PlayerOneBallsHitIn = []
    @PlayerTwoBallsHitIn = []
    @PlayerOneDeadBalls = []
    @PlayerTwoDeadBalls = []
    @PlayerOneLastBall = null
    @PlayerTwoLastBall = null
    @OnBreak = true
    @BreakingPlayerStillHitting = true
    @PlayerOneTimeoutsTaken = 0
    @PlayerTwoTimeoutsTaken = 0
    @getCurrentlyUpPlayer = ->
      return @PlayerOneCallback()  if @PlayerOneCallback().CurrentlyUp is true
      @PlayerTwoCallback()

  hitSafety: ->
    @getCurrentlyUpPlayer().addOneToSafeties()
    @nextPlayerIsUp()

  getDeadBalls: ->
    @PlayerOneDeadBalls.length + @PlayerTwoDeadBalls.length

  hitDeadBall: (ballNumber) ->
    if ballNumber isnt 9 and not @getBallsHitIn().exists(ballNumber)
      @DeadBalls += 1
      if @PlayerOneCallback().CurrentlyUp is true
        @PlayerOneDeadBalls.push ballNumber
      else
        @PlayerTwoDeadBalls.push ballNumber
      @checkIfAllBallsAreHitIn()

  checkIfAllBallsAreHitIn: ->
    allBallsHitIn = @getBallsHitIn()
    @Ended = (allBallsHitIn.length is 9)
    if @Ended is false
      if allBallsHitIn.exists(9)
        i = 1
        while i < 9
          unless allBallsHitIn.exists(i) is true
            if @PlayerOneCallback().CurrentlyUp is true
              @PlayerOneDeadBalls.push i
            else
              @PlayerTwoDeadBalls.push i
          i++
        @Ended = true
    if @Ended is true and @getBallsScored().length is 9
      if @PlayerOneCallback().CurrentlyUp is true and @BreakingPlayerStillHitting is true
        @setPlayerOneBreakAndRun()
      else @setPlayerTwoBreakAndRun()  if @PlayerTwoCallback().CurrentlyUp is true and @BreakingPlayerStillHitting is true

  scoreBall: (ballNumber) ->
    unless @getBallsHitIn().exists(ballNumber)
      if @PlayerOneCallback().CurrentlyUp is true
        if ballNumber > 0 and ballNumber < 9
          @PlayerOneScore += 1
          @PlayerOneCallback().addToScore 1
        else
          @PlayerOneScore += 2
          @PlayerOneCallback().addToScore 2
          @setPlayerOneNineOnSnap()  if @OnBreak is true and @getBallsScored().length isnt 8
        @PlayerOneLastBall = ballNumber
        @PlayerTwoLastBall = null
        @PlayerOneBallsHitIn.push ballNumber
      else
        if ballNumber > 0 and ballNumber < 9
          @PlayerTwoScore += 1
          @PlayerTwoCallback().addToScore 1
        else
          @PlayerTwoScore += 2
          @PlayerTwoCallback().addToScore 2
          @setPlayerTwoNineOnSnap()  if @OnBreak is true and @getBallsScored().length isnt 8
        @PlayerTwoLastBall = ballNumber
        @PlayerOneLastBall = null
        @PlayerTwoBallsHitIn.push ballNumber
      @checkIfAllBallsAreHitIn()
      @checkForWinner()

  checkForWinner: ->
    if @PlayerOneCallback().hasWon() is true or @PlayerTwoCallback().hasWon() is true
      @End()
      @MatchEndedCallback()

  addOneToNumberOfInnings: ->
    @NumberOfInnings += 1

  nextPlayerIsUp: ->
    if @OnBreak isnt true or ((@PlayerTwoCallback().CurrentlyUp is true and @PlayerTwoBallsHitIn.length is 0) or (@PlayerOneCallback().CurrentlyUp is true and @PlayerOneBallsHitIn.length is 0))
      if @PlayerOneCallback().CurrentlyUp is true
        @PlayerTwoCallback().CurrentlyUp = true
        @PlayerOneCallback().CurrentlyUp = false
      else if @PlayerTwoCallback().CurrentlyUp is true
        @PlayerTwoCallback().CurrentlyUp = false
        @PlayerOneCallback().CurrentlyUp = true
        @addOneToNumberOfInnings()
      else
        @PlayerOneCallback().CurrentlyUp = true
      @BreakingPlayerStillHitting = false
    @OnBreak = false

  setPlayerOneNineOnSnap: ->
    @PlayerOneCallback().addOneToNineOnSnaps()  unless @PlayerOneNineOnSnap is true
    @PlayerOneNineOnSnap = true

  setPlayerTwoNineOnSnap: ->
    @PlayerTwoCallback().addOneToNineOnSnaps()  unless @PlayerTwoNineOnSnap is true
    @PlayerTwoNineOnSnap = true

  setPlayerOneBreakAndRun: ->
    @PlayerOneCallback().addOneToBreakAndRuns()  unless @PlayerOneBreakAndRun is true
    @PlayerOneBreakAndRun = true

  setPlayerTwoBreakAndRun: ->
    @PlayerTwoCallback().addOneToBreakAndRuns()  unless @PlayerTwoBreakAndRun is true
    @PlayerTwoBreakAndRun = true

  getWinningPlayerName: ->
    if getScoreRatio(@PlayerOneScore, @PlayerOneCallback().BallCount) > getScoreRatio(@PlayerTwoScore, @PlayerTwoCallback().BallCount)
      return @PlayerOneCallback().getFirstNameWithInitials()
    else return @PlayerTwoCallback().getFirstNameWithInitials()  if getScoreRatio(@PlayerOneScore, @PlayerOneCallback().BallCount) < getScoreRatio(@PlayerTwoScore, @PlayerTwoCallback().BallCount)
    "Tie"

  getGameScore: ->
    @PlayerOneScore + "-" + @PlayerTwoScore

  getPlayerOneBallsHitIn: ->
    @PlayerOneBallsHitIn.concat @PlayerOneDeadBalls

  getPlayerTwoBallsHitIn: ->
    @PlayerTwoBallsHitIn.concat @PlayerTwoDeadBalls

  getBallsHitIn: ->
    @PlayerOneBallsHitIn.concat(@PlayerTwoBallsHitIn).concat(@PlayerOneDeadBalls).concat @PlayerTwoDeadBalls

  getBallsScored: ->
    @PlayerOneBallsHitIn.concat @PlayerTwoBallsHitIn

  getCurrentPlayerRemainingTimeouts: ->
    return (@PlayerOneCallback().TimeoutsAllowed - @PlayerOneTimeoutsTaken).toString()  if @PlayerOneCallback().CurrentlyUp is true
    (@PlayerTwoCallback().TimeoutsAllowed - @PlayerTwoTimeoutsTaken).toString()

  takeTimeout: ->
    if @getCurrentPlayerRemainingTimeouts() > 0
      if @PlayerOneCallback().CurrentlyUp is true
        @PlayerOneTimeoutsTaken += 1
      else
        @PlayerTwoTimeoutsTaken += 1

  breakIsOver: ->
    @OnBreak = false

  End: ->
    @Ended = true

  toJSON: ->
    PlayerOneScore: @PlayerOneScore
    PlayerTwoScore: @PlayerTwoScore
    PlayerOneTimeoutsTaken: @PlayerOneTimeoutsTaken
    PlayerTwoTimeoutsTaken: @PlayerTwoTimeoutsTaken
    NumberOfInnings: @NumberOfInnings
    PlayerOneNineOnSnap: @PlayerOneNineOnSnap
    PlayerOneBreakAndRun: @PlayerOneBreakAndRun
    PlayerTwoNineOnSnap: @PlayerTwoNineOnSnap
    PlayerTwoBreakAndRun: @PlayerTwoBreakAndRun
    Ended: @Ended
    PlayerOneBallsHitIn: @PlayerOneBallsHitIn
    PlayerTwoBallsHitIn: @PlayerTwoBallsHitIn
    PlayerOneDeadBalls: @PlayerOneDeadBalls
    PlayerTwoDeadBalls: @PlayerTwoDeadBalls
    PlayerOneLastBall: @PlayerOneLastBall
    PlayerTwoLastBall: @PlayerTwoLastBall
    OnBreak: @OnBreak
    BreakingPlayerStillHitting: @BreakingPlayerStillHitting

  fromJSON: (gameJSON) ->
    @PlayerOneScore = gameJSON.PlayerOneScore
    @PlayerTwoScore = gameJSON.PlayerTwoScore
    @NumberOfInnings = gameJSON.NumberOfInnings
    @PlayerOneTimeoutsTaken = gameJSON.PlayerOneTimeoutsTaken
    @PlayerTwoTimeoutsTaken = gameJSON.PlayerTwoTimeoutsTaken
    @PlayerOneNineOnSnap = gameJSON.PlayerOneNineOnSnap
    @PlayerOneBreakAndRun = gameJSON.PlayerOneBreakAndRun
    @PlayerTwoNineOnSnap = gameJSON.PlayerTwoNineOnSnap
    @PlayerTwoBreakAndRun = gameJSON.PlayerTwoBreakAndRun
    @Ended = gameJSON.Ended
    @PlayerOneBallsHitIn = gameJSON.PlayerOneBallsHitIn
    @PlayerTwoBallsHitIn = gameJSON.PlayerTwoBallsHitIn
    @PlayerOneDeadBalls = gameJSON.PlayerOneDeadBalls
    @PlayerTwoDeadBalls = gameJSON.PlayerTwoDeadBalls
    @PlayerOneLastBall = gameJSON.PlayerOneLastBall
    @PlayerTwoLastBall = gameJSON.PlayerTwoLastBall
    @OnBreak = gameJSON.OnBreak
    @BreakingPlayerStillHitting = gameJSON.BreakingPlayerStillHitting

$CS.Models.NineBall.Game = Game
