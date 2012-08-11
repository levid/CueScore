class EightBall extends Game
  defaults:
    stripes: 1
    solids: 2
    innings: 0
    match_ended_callback: {}
    number_of_innings: 0
    ended: false
    balls_hit_in:
      stripes: []
      solids: []
    last_ball_hit_in: null
    on_break: true
    breaking_player_still_shooting: true
    scratch_on_eight: false
    early_eight: false
    player: [
      one:
        eight_ball: null
        eight_on_snap: false
        break_and_run: false
        timeouts_taken: 0
        timeouts_allowed: null
        callback: addToPlayerOne?
        ball_type: null
        has_won: false
        currently_up: false
        score: []
      two:
        eight_ball: null
        eight_on_snap: false
        break_and_run: false
        timeouts_taken: 0
        timeouts_allowed: null
        callback: addToPlayerOne?
        ball_type: null
        has_won: false
        currently_up: false
        score: []
    ]

  initialize: (addToPlayerOne, addToPlayerTwo, callback) ->
    @match_ended_callback = callback?

  # Getters
  
  getCurrentlyUpPlayer: ->
    return @player['one'].callback() if @player['one'].callback().isCurrentlyUp is true
    @player['two'].callback()
  
  getWinningPlayerName: ->
    if @player['one'].has_won is true
      return @player['one'].callback().getFirstNameWithInitials()
    else return @player['two'].callback().getFirstNameWithInitials() if @player['two'].has_won is true
    
  getBallsHitInByPlayer: (playerNum) ->
    if playerNum == 1
      if @player['one'].ball_type is @stripes
        return @balls_hit_in.stripes.concat(@player['one'].eight_ball)
      else return @balls_hit_in.solids.concat(@player['one'].eight_ball) if @player['one'].ball_type is @solids
      []
    if playerNum == 2
      if @player['two'].ball_type is @stripes
        return @balls_hit_in.stripes.concat(@player['two'].eight_ball)
      else return @balls_hit_in.solids.concat(@player['two'].eight_ball) if @player['two'].ball_type is @solids
      []

  getGameScore: ->
    @getBallsHitInByPlayer(1).length + "-" + @getBallsHitInByPlayer(2).length

  getBallsHitIn: ->
    @balls_hit_in.solids.concat @balls_hit_in.stripes.concat(@player['two'].eight_ball.concat(@player['one'].eight_ball))

  getCurrentPlayerRemainingTimeouts = ->
    return (@player['one'].callback().timeouts_allowed - @player['one'].timeouts_taken).toString()  if @player['one'].callback().currently_up is true
    (@player['two'].callback().timeouts_allowed - @player['two'].timeouts_taken).toString()
    
  # Setters
  
  setPlayerWon: (playerNum) ->
    if playerNum == 1
      @player['one'].has_won = true
      @player['one'].callback().games_won += 1
    else if playerNum == 2
      @player['two'].has_won = true
      @player['two'].callback().games_won += 1
      
  setEightOnSnapByPlayer: (playerNum) ->
    if playerNum == 1
      @player['one'].callback().addToEightOnSnaps(1) unless @player['one'].eight_on_snap is true
      @player['one'].eight_on_snap = true
    else if playerNum == 2
      @player['two'].callback().addToEightOnSnaps(1) unless @player['two'].eight_on_snap is true
      @player['two'].eight_on_snap = true

  setBreakAndRunByPlayer: (playerNum) ->
    if playerNum == 1
      @player['one'].callback().addOneToBreakAndRuns() unless @player['one'].break_and_run is true
      @player['one'].break_and_run = true
    else if playerNum == 2
      @player['two'].callback().addOneToBreakAndRuns() unless @player['two'].break_and_run is true
      @player['two'].break_and_run = true

  setBallTypeByPlayer: (playerNum, type) ->
    if playerNum == 1 && type == "stripes"
      @player['one'].ball_type = @stripes
      @player['two'].ball_type = @solids
      @checkForWinner()
    else if playerNum == 2 && type == "stripes"
      @player['two'].ball_type = @stripes
      @player['one'].ball_type = @solids
      @checkForWinner()
    else if playerNum == 1 && type == "solids"
      @player['one'].ball_type = @solids
      @player['two'].ball_type = @stripes
      @checkForWinner()
    else if playerNum == 2 && type == "solids"
      @player['two'].ball_type = @solids
      @player['one'].ball_type = @stripes
      @checkForWinner()
      
  # Methods
  
  replaceNameAttr: (name) ->
    @set name: name
    
  hitSafety: ->
    @getCurrentlyUpPlayer().addOneToSafeties()
    @nextPlayerIsUp()

  hitScratchOnEight: ->
    @scratch_on_eight = true
    @ended = true
    
    if @player['one'].callback().currently_up is true
      @player['two'].has_won = true
      @player['one'].callback().currently_up = false
      @player['two'].callback().currently_up = true
    else
      @player['one'].has_won = true
      @player['two'].callback().currently_up = false
      @player['one'].callback().currently_up = true
      
    @match_ended_callback()

  addToNumberOfInnings: (num) ->
    @number_of_innings += num
    
  takeTimeout: ->
    if @getCurrentPlayerRemainingTimeouts() > 0
      if @player['one'].callback().currently_up is true
        @player['one'].timeouts_taken += 1
      else
        @player['two'].timeouts_taken += 1

  breakIsOver: ->
    @on_break = false

  game_end: ->
    @ended = true
    
  checkForWinner: ->
    @ended = true if @getBallsHitIn().exists(8)
    if @ended is true
      if @breakingPlayerStillHitting is true and (@solidBallsHitIn.length is 7 or @stripedBallsHitIn.length is 7)
        if @player['one'].callback().currently_up is true
          @setBreakAndRunByPlayer(1)
          
          if @balls_hit_in.solids.length is 7
            @player['one'].ball_type = @solids
            @player['two'].ball_type = @stripes
          else
            @player['one'].ball_type = @stripes
            @player['two'].ball_type = @solids
            
        else if @player['two'].callback().currently_up is true
          @setBreakAndRunByPlayer(2)
          
          if @balls_hit_in.solids.length is 7
            @player['two'].ball_type = @solids
            @player['one'].ball_type = @stripes
          else
            @player['one'].ball_type = @solids
            @player['two'].ball_type = @stripes
            
      if @player['one'].eightBall.exists(8) and @on_break is false
        unless @getBallsHitInByPlayer(1).length is 8
          @setPlayerWon(2)
        else
          @setPlayerWon(1)
          
      else if @player['two'].eightBall.exists(8) and @on_break is false
        unless @getBallsHitInByPlayer(1).length is 8
          @setPlayerWon(1)
        else
          @setPlayerWon(2)
          
      else
        if @player['one'].callback().currently_up is true
          @setPlayerWon(1)
        else @setPlayerWon(2) if @player['two'].callback().currently_up is true
        
      @match_ended_callback()
      
  scoreBall: (ballNumber) ->
    unless @getBallsHitIn().exists(ballNumber)
      @last_ball_hit_in = ballNumber
      
      if ballNumber > 0 and ballNumber < 8
        @balls_hit_in.solids.push ballNumber
      else if ballNumber > 8 and ballNumber < 16
        @balls_hit_in.stripes.push ballNumber
      else
        if @player['one'].callback().currently_up is true
          @player['one'].eight_ball.push ballNumber
        else @player['two'].eight_ball.push ballNumber if @player['two'].callback().currently_up is true
        
        if @on_break is true
          if @balls_hit_in.solids.length isnt 7 and @balls_hit_in.stripes.length isnt 7
            if @player['one'].callback().currently_up is true
              @setEightOnSnapByPlayer(1)
            else @setEightOnSnapByPlayer(2)  if @player['two'].callback().currently_up is true
        else
          if @balls_hit_in.solids.length isnt 7 and @balls_hit_in.stripes.length isnt 7
            @early_eight = true
            
            if @player['one'].callback().currently_up is true
              @player['one'].callback().currently_up = false
              @player['two'].callback().currently_up = true
            else if @player['two'].callback().currently_up is true
              @player['one'].callback().currently_up = true
              @player['two'].callback().currently_up = false
              
      @checkForWinner()

  nextPlayerIsUp: ->
    if @on_break isnt true or ((@player['two'].callback().currently_up is true or @player['one'].callback().currently_up is true) and @getBallsHitIn().length is 0)
      if @player['one'].callback().currently_up is true
        @player['two'].callback().currently_up = true
        @player['one'].callback().currently_up = false
        
        unless @player['one'].ball_type?
          if @balls_hit_in.solids.length > 0 and @balls_hit_in.stripes.length is 0
            @player['one'].ball_type = @solids
            @player['two'].ball_type = @stripes
          else if @balls_hit_in.solids.length is 0 and @balls_hit_in.stripes.length > 0
            @player['one'].ball_type = @stripes
            @player['two'].ball_type = @solids
            
      else if @PlayerTwoCallback().CurrentlyUp is true
        @player['two'].callback().currently_up = false
        @player['one'].callback().currently_up = true
        @addToNumberOfInnings(1)
        
        unless @player['two'].ball_type?
          if @balls_hit_in.solids.length is 0 and @balls_hit_in.stripes.length > 0
            @player['one'].ball_type = @solids
            @player['two'].ball_type = @stripes
          else if @balls_hit_in.solids.length > 0 and @balls_hit_in.stripes.length is 0
            @player['one'].ball_type = @stripes
            @player['two'].ball_type = @solids
      else
        @player['one'].callback().currently_up = true
        
      @breaking_player_still_shooting = false
      
    @on_break = false
    
  # JSON Data

  toJSON: ->
    PlayerOneTimeoutsTaken:         @player['one'].timeouts_taken
    PlayerTwoTimeoutsTaken:         @player['two'].timeouts_taken
    PlayerOneEightOnSnap:           @player['one'].eight_on_snap
    PlayerOneBreakAndRun:           @player['one'].break_and_run
    PlayerTwoEightOnSnap:           @player['two'].eight_on_snap
    PlayerTwoBreakAndRun:           @player['two'].break_and_run
    PlayerOneBallType:              @player['one'].ball_type
    PlayerTwoBallType:              @player['two'].ball_type
    PlayerOneEightBall:             @player['one'].eight_ball
    PlayerTwoEightBall:             @player['two'].eight_ball
    PlayerOneWon:                   @player['one'].has_won
    PlayerTwoWon:                   @player['two'].has_won
    NumberOfInnings:                @number_of_innings
    EarlyEight:                     @early_eight
    ScratchOnEight:                 @scratch_on_eight
    BreakingPlayerStillShooting:    @breaking_player_still_shooting
    StripedBallsHitIn:              @balls_hit_in.stripes
    SolidBallsHitIn:                @balls_hit_in.solids
    LastBallHitIn:                  @last_ball_hit_in
    OnBreak:                        @on_break
    Ended:                          @ended
    
  fromJSON: (gameJSON) ->
    @player['one'].timeouts_taken   = gameJSON.PlayerOneTimeoutsTaken
    @player['two'].timeouts_taken   = gameJSON.PlayerTwoTimeoutsTaken
    @player['one'].eight_on_snap    = gameJSON.PlayerOneEightOnSnap
    @player['one'].break_and_run    = gameJSON.PlayerOneBreakAndRun
    @player['two'].eight_on_snap    = gameJSON.PlayerTwoEightOnSnap
    @player['two'].break_and_run    = gameJSON.PlayerTwoBreakAndRun
    @player['one'].ball_type        = gameJSON.PlayerOneBallType
    @player['two'].ball_type        = gameJSON.PlayerTwoBallType
    @player['one'].eight_ball       = gameJSON.PlayerOneEightBall
    @player['two'].eight_ball       = gameJSON.PlayerTwoEightBall
    @player['one'].has_won          = gameJSON.PlayerOneWon
    @player['two'].has_won          = gameJSON.PlayerTwoWon
    @number_of_innints              = gameJSON.NumberOfInnings
    @breaking_player_still_shooting = gameJSON.BreakingPlayerStillHitting
    @balls_hit_in.solids            = gameJSON.SolidBallsHitIn
    @balls_hit_in.stripes           = gameJSON.StripedBallsHitIn
    @last_ball_hit_in               = gameJSON.LastBallHitIn
    @on_break                       = gameJSON.OnBreak
    @ended                          = gameJSON.Ended
  
$CS.Models.Game.EightBall = EightBall
