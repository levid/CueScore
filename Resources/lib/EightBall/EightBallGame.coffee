EightBallGame = (addToPlayerOne, addToPlayerTwo, callback) ->
  @STRIPS = 1
  @SOLIDS = 2
  @PlayerOneCallback = addToPlayerOne
  @PlayerTwoCallback = addToPlayerTwo
  @PlayerOneCallback().TimeoutsTaken = 0
  @PlayerTwoCallback().TimeoutsTaken = 0
  @MatchEndedCallback = callback
  @NumberOfInnings = 0
  @PlayerOneEightOnSnap = false
  @PlayerOneBreakAndRun = false
  @PlayerTwoEightOnSnap = false
  @PlayerTwoBreakAndRun = false
  @Ended = false
  @StripedBallsHitIn = []
  @SolidBallsHitIn = []
  @PlayerOneEightBall = []
  @PlayerTwoEightBall = []
  @LastBallHitIn = null
  @OnBreak = true
  @BreakingPlayerStillHitting = true
  @PlayerOneTimeoutsTaken = 0
  @PlayerTwoTimeoutsTaken = 0
  @PlayerOneBallType = null
  @PlayerTwoBallType = null
  @PlayerOneWon = false
  @PlayerTwoWon = false
  @ScratchOnEight = false
  @EarlyEight = false
  @getCurrentlyUpPlayer = ->
    return @PlayerOneCallback()  if @PlayerOneCallback().CurrentlyUp is true
    @PlayerTwoCallback()

  @getWinningPlayerName = ->
    if @PlayerOneWon is true
      return @PlayerOneCallback().getFirstNameWithInitials()
    else return @PlayerTwoCallback().getFirstNameWithInitials()  if @PlayerTwoWon is true
    ""

  @hitSafety = ->
    @getCurrentlyUpPlayer().addOneToSafeties()
    @nextPlayerIsUp()

  @setPlayerOneWon = ->
    @PlayerOneWon = true
    @PlayerOneCallback().GamesWon += 1

  @setPlayerTwoWon = ->
    @PlayerTwoWon = true
    @PlayerTwoCallback().GamesWon += 1

  @checkForWinner = ->
    @Ended = true  if @getBallsHitIn().exists(8)
    if @Ended is true
      if @BreakingPlayerStillHitting is true and (@SolidBallsHitIn.length is 7 or @StripedBallsHitIn.length is 7)
        if @PlayerOneCallback().CurrentlyUp is true
          @setPlayerOneBreakAndRun()
          if @SolidBallsHitIn.length is 7
            @PlayerOneBallType = @SOLIDS
            @PlayerTwoBallType = @STRIPS
          else
            @PlayerOneBallType = @STRIPS
            @PlayerTwoBallType = @SOLIDS
        else if @PlayerTwoCallback().CurrentlyUp is true
          @setPlayerTwoBreakAndRun()
          if @SolidBallsHitIn.length is 7
            @PlayerTwoBallType = @SOLIDS
            @PlayerOneBallType = @STRIPS
          else
            @PlayerOneBallType = @SOLIDS
            @PlayerTwoBallType = @STRIPS
      if @PlayerOneEightBall.exists(8) and @OnBreak is false
        unless @getPlayerOneBallsHitIn().length is 8
          @setPlayerTwoWon()
        else
          @setPlayerOneWon()
      else if @PlayerTwoEightBall.exists(8) and @OnBreak is false
        unless @getPlayerOneBallsHitIn().length is 8
          @setPlayerOneWon()
        else
          @setPlayerTwoWon()
      else
        if @PlayerOneCallback().CurrentlyUp is true
          @setPlayerOneWon()
        else @setPlayerTwoWon()  if @PlayerTwoCallback().CurrentlyUp is true
      @MatchEndedCallback()

  @scoreBall = (ballNumber) ->
    unless @getBallsHitIn().exists(ballNumber)
      @LastBallHitIn = ballNumber
      if ballNumber > 0 and ballNumber < 8
        @SolidBallsHitIn.push ballNumber
      else if ballNumber > 8 and ballNumber < 16
        @StripedBallsHitIn.push ballNumber
      else
        if @PlayerOneCallback().CurrentlyUp is true
          @PlayerOneEightBall.push ballNumber
        else @PlayerTwoEightBall.push ballNumber  if @PlayerTwoCallback().CurrentlyUp is true
        if @OnBreak is true
          if @SolidBallsHitIn.length isnt 7 and @StripedBallsHitIn.length isnt 7
            if @PlayerOneCallback().CurrentlyUp is true
              @setPlayerOneEightOnSnap()
            else @setPlayerTwoEightOnSnap()  if @PlayerTwoCallback().CurrentlyUp is true
        else
          if @SolidBallsHitIn.length isnt 7 and @StripedBallsHitIn.length isnt 7
            @EarlyEight = true
            if @PlayerOneCallback().CurrentlyUp is true
              @PlayerOneCallback().CurrentlyUp = false
              @PlayerTwoCallback().CurrentlyUp = true
            else if @PlayerTwoCallback().CurrentlyUp is true
              @PlayerOneCallback().CurrentlyUp = true
              @PlayerTwoCallback().CurrentlyUp = false
      @checkForWinner()

  @hitScratchOnEight = ->
    @ScratchOnEight = true
    @Ended = true
    if @PlayerOneCallback().CurrentlyUp is true
      @PlayerTwoWon = true
      @PlayerOneCallback().CurrentlyUp = false
      @PlayerTwoCallback().CurrentlyUp = true
    else
      @PlayerOneWon = true
      @PlayerTwoCallback().CurrentlyUp = false
      @PlayerOneCallback().CurrentlyUp = true
    @MatchEndedCallback()

  @addOneToNumberOfInnings = ->
    @NumberOfInnings += 1

  @nextPlayerIsUp = ->
    if @OnBreak isnt true or ((@PlayerTwoCallback().CurrentlyUp is true or @PlayerOneCallback().CurrentlyUp is true) and @getBallsHitIn().length is 0)
      if @PlayerOneCallback().CurrentlyUp is true
        @PlayerTwoCallback().CurrentlyUp = true
        @PlayerOneCallback().CurrentlyUp = false
        unless @PlayerOneBallType?
          if @SolidBallsHitIn.length > 0 and @StripedBallsHitIn.length is 0
            @PlayerOneBallType = @SOLIDS
            @PlayerTwoBallType = @STRIPS
          else if @SolidBallsHitIn.length is 0 and @StripedBallsHitIn.length > 0
            @PlayerOneBallType = @STRIPS
            @PlayerTwoBallType = @SOLIDS
      else if @PlayerTwoCallback().CurrentlyUp is true
        @PlayerTwoCallback().CurrentlyUp = false
        @PlayerOneCallback().CurrentlyUp = true
        @addOneToNumberOfInnings()
        unless @PlayerTwoBallType?
          if @SolidBallsHitIn.length is 0 and @StripedBallsHitIn.length > 0
            @PlayerOneBallType = @SOLIDS
            @PlayerTwoBallType = @STRIPS
          else if @SolidBallsHitIn.length > 0 and @StripedBallsHitIn.length is 0
            @PlayerOneBallType = @STRIPS
            @PlayerTwoBallType = @SOLIDS
      else
        @PlayerOneCallback().CurrentlyUp = true
      @BreakingPlayerStillHitting = false
    @OnBreak = false

  @setPlayerOneEightOnSnap = ->
    @PlayerOneCallback().addOneToEightOnSnaps()  unless @PlayerOneEightOnSnap is true
    @PlayerOneEightOnSnap = true

  @setPlayerTwoEightOnSnap = ->
    @PlayerTwoCallback().addOneToEightOnSnaps()  unless @PlayerTwoEightOnSnap is true
    @PlayerTwoEightOnSnap = true

  @setPlayerOneBreakAndRun = ->
    @PlayerOneCallback().addOneToBreakAndRuns()  unless @PlayerOneBreakAndRun is true
    @PlayerOneBreakAndRun = true

  @setPlayerTwoBreakAndRun = ->
    @PlayerTwoCallback().addOneToBreakAndRuns()  unless @PlayerTwoBreakAndRun is true
    @PlayerTwoBreakAndRun = true

  @setPlayerOneBallTypeToStriped = ->
    @PlayerOneBallType = @STRIPS
    @PlayerTwoBallType = @SOLIDS
    @checkForWinner()

  @setPlayerOneBallTypeToSolid = ->
    @PlayerOneBallType = @SOLIDS
    @PlayerTwoBallType = @STRIPS
    @checkForWinner()

  @setPlayerTwoBallTypeToStriped = ->
    @PlayerTwoBallType = @STRIPS
    @PlayerOneBallType = @SOLIDS
    @checkForWinner()

  @setPlayerTwoBallTypeToSolid = ->
    @PlayerTwoBallType = @SOLIDS
    @PlayerOneBallType = @STRIPS
    @checkForWinner()

  @getPlayerOneBallsHitIn = ->
    if @PlayerOneBallType is @STRIPS
      return @StripedBallsHitIn.concat(@PlayerOneEightBall)
    else return @SolidBallsHitIn.concat(@PlayerOneEightBall)  if @PlayerOneBallType is @SOLIDS
    []

  @getPlayerTwoBallsHitIn = ->
    if @PlayerTwoBallType is @STRIPS
      return @StripedBallsHitIn.concat(@PlayerTwoEightBall)
    else return @SolidBallsHitIn.concat(@PlayerTwoEightBall)  if @PlayerTwoBallType is @SOLIDS
    []

  @getGameScore = ->
    @getPlayerOneBallsHitIn().length + "-" + @getPlayerTwoBallsHitIn().length

  @getBallsHitIn = ->
    @SolidBallsHitIn.concat @StripedBallsHitIn.concat(@PlayerTwoEightBall.concat(@PlayerOneEightBall))

  @getCurrentPlayerRemainingTimeouts = ->
    return (@PlayerOneCallback().TimeoutsAllowed - @PlayerOneTimeoutsTaken).toString()  if @PlayerOneCallback().CurrentlyUp is true
    (@PlayerTwoCallback().TimeoutsAllowed - @PlayerTwoTimeoutsTaken).toString()

  @takeTimeout = ->
    if @getCurrentPlayerRemainingTimeouts() > 0
      if @PlayerOneCallback().CurrentlyUp is true
        @PlayerOneTimeoutsTaken += 1
      else
        @PlayerTwoTimeoutsTaken += 1

  @breakIsOver = ->
    @OnBreak = false

  @End = ->
    @Ended = true

  @toJSON = ->
    PlayerOneTimeoutsTaken: @PlayerOneTimeoutsTaken
    PlayerTwoTimeoutsTaken: @PlayerTwoTimeoutsTaken
    NumberOfInnings: @NumberOfInnings
    PlayerOneEightOnSnap: @PlayerOneEightOnSnap
    PlayerOneBreakAndRun: @PlayerOneBreakAndRun
    PlayerTwoEightOnSnap: @PlayerTwoEightOnSnap
    PlayerTwoBreakAndRun: @PlayerTwoBreakAndRun
    PlayerOneBallType: @PlayerOneBallType
    PlayerTwoBallType: @PlayerTwoBallType
    PlayerOneEightBall: @PlayerOneEightBall
    PlayerTwoEightBall: @PlayerTwoEightBall
    PlayerOneWon: @PlayerOneWon
    PlayerTwoWon: @PlayerTwoWon
    EarlyEight: @EarlyEight
    ScratchOnEight: @ScratchOnEight
    Ended: @Ended
    StripedBallsHitIn: @StripedBallsHitIn
    SolidBallsHitIn: @SolidBallsHitIn
    LastBallHitIn: @LastBallHitIn
    OnBreak: @OnBreak
    BreakingPlayerStillHitting: @BreakingPlayerStillHitting

  @fromJSON = (gameJSON) ->
    @NumberOfInnings = gameJSON.NumberOfInnings
    @PlayerOneTimeoutsTaken = gameJSON.PlayerOneTimeoutsTaken
    @PlayerTwoTimeoutsTaken = gameJSON.PlayerTwoTimeoutsTaken
    @PlayerOneEightOnSnap = gameJSON.PlayerOneEightOnSnap
    @PlayerOneBreakAndRun = gameJSON.PlayerOneBreakAndRun
    @PlayerTwoEightOnSnap = gameJSON.PlayerTwoEightOnSnap
    @PlayerTwoBreakAndRun = gameJSON.PlayerTwoBreakAndRun
    @PlayerOneBallType = gameJSON.PlayerOneBallType
    @PlayerTwoBallType = gameJSON.PlayerTwoBallType
    @PlayerOneEightBall = gameJSON.PlayerOneEightBall
    @PlayerTwoEightBall = gameJSON.PlayerTwoEightBall
    @PlayerOneWon = gameJSON.PlayerOneWon
    @PlayerTwoWon = gameJSON.PlayerTwoWon
    @Ended = gameJSON.Ended
    @SolidBallsHitIn = gameJSON.SolidBallsHitIn
    @StripedBallsHitIn = gameJSON.StripedBallsHitIn
    @LastBallHitIn = gameJSON.LastBallHitIn
    @OnBreak = gameJSON.OnBreak
    @BreakingPlayerStillHitting = gameJSON.BreakingPlayerStillHitting
    