class Game extends $CS.Models.EightBall
  defaults:
    stripes: 1
    solids: 2
    innings: 0
    match_ended_callback: ->
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
    player:
      one:
        eight_ball: []
        eight_on_snap: false
        break_and_run: false
        timeouts_taken: 0
        callback: ->
        ball_type: null
        has_won: false
      two:
        eight_ball: []
        eight_on_snap: false
        break_and_run: false
        timeouts_taken: 0
        callback: ->
        ball_type: null
        has_won: false

  constructor: (options) ->
    _.extend @, @defaults
    
    @player.one.callback  = options.addToPlayerOne
    @player.two.callback  = options.addToPlayerTwo
    @match_ended_callback = options.callback
    
    @player.one.callback().timeouts_taken = 0;
    @player.two.callback().timeouts_taken = 0;

  # Getters
  
  getCurrentlyUpPlayer: ->
    return @player.one.callback() if @player.one.callback().currently_up is true
    @player.two.callback()
    
  getWinningPlayer: ->
    if @player.one.has_won is true
      return @player.one
    else if @player.two.has_won is true
      return @player.two
  
  getWinningPlayerName: ->
    @getWinningPlayer().callback().getFirstNameWithInitials()
    
  getBallsHitInByPlayer: (playerNum) ->
    if playerNum == 1
      if @player.one.ball_type is @stripes
        return @balls_hit_in.stripes.concat(@player.one.eight_ball)
      else 
        return @balls_hit_in.solids.concat(@player.one.eight_ball) if @player.one.ball_type is @solids
        return []
    if playerNum == 2
      if @player.two.ball_type is @stripes
        return @balls_hit_in.stripes.concat(@player.two.eight_ball)
      else 
        return @balls_hit_in.solids.concat(@player.two.eight_ball) if @player.two.ball_type is @solids
        return []

  getGameScore: ->
    @getBallsHitInByPlayer(1).length + "-" + @getBallsHitInByPlayer(2).length

  getBallsHitIn: ->
    @balls_hit_in.solids.concat(@balls_hit_in.stripes.concat(@player.two.eight_ball.concat(@player.one.eight_ball)))

  getCurrentPlayerRemainingTimeouts: ->
    if @player.one.callback().currently_up is true
      return (@player.one.callback().timeouts_allowed - @player.one.timeouts_taken)
    else
      return (@player.two.callback().timeouts_allowed - @player.two.timeouts_taken)
    
  # Setters
  
  setPlayerWon: (playerNum) ->
    if playerNum == 1
      @player.one.has_won = true
      @player.one.callback().games_won += 1
    else if playerNum == 2
      @player.two.has_won = true
      @player.two.callback().games_won += 1
      
  setEightOnSnapByPlayer: (playerNum) ->
    if playerNum == 1
      @player.one.callback().addToEightOnSnaps(1) unless @player.one.eight_on_snap is true
      @player.one.eight_on_snap = true
    else if playerNum == 2
      @player.two.callback().addToEightOnSnaps(1) unless @player.two.eight_on_snap is true
      @player.two.eight_on_snap = true

  setBreakAndRunByPlayer: (playerNum) ->
    if playerNum == 1
      @player.one.callback().addToBreakAndRuns(1) unless @player.one.break_and_run is true
      @player.one.break_and_run = true
    else if playerNum == 2
      @player.two.callback().addToBreakAndRuns(1) unless @player.two.break_and_run is true
      @player.two.break_and_run = true

  setBallTypeByPlayer: (playerNum, type) ->
    if playerNum == 1 && type == "stripes"
      @player.one.ball_type = @stripes
      @player.two.ball_type = @solids
      @checkForWinner()
    else if playerNum == 2 && type == "stripes"
      @player.two.ball_type = @stripes
      @player.one.ball_type = @solids
      @checkForWinner()
    else if playerNum == 1 && type == "solids"
      @player.one.ball_type = @solids
      @player.two.ball_type = @stripes
      @checkForWinner()
    else if playerNum == 2 && type == "solids"
      @player.two.ball_type = @solids
      @player.one.ball_type = @stripes
      @checkForWinner()
      
  # Methods

  hitSafety: ->
    @getCurrentlyUpPlayer().addToSafeties(1)
    @nextPlayerIsUp()

  hitScratchOnEight: ->
    @scratch_on_eight = true
    @ended = true
    
    if @player.one.callback().currently_up is true
      @player.two.has_won = true
      @player.one.callback().currently_up = false
      @player.two.callback().currently_up = true
    else
      @player.one.has_won = true
      @player.two.callback().currently_up = false
      @player.one.callback().currently_up = true
      
    @match_ended_callback()
  
  shotMissed: ->
    @nextPlayerIsUp()

  addToNumberOfInnings: (num) ->
    @number_of_innings += num
    
  takeTimeout: ->
    if @getCurrentPlayerRemainingTimeouts() > 0
      if @player.one.callback().currently_up is true
        @player.one.timeouts_taken += 1
      else
        @player.two.timeouts_taken += 1

  breakIsOver: ->
    @on_break = false

  end: ->
    @ended = true
    
  scoreBall: (ballNumber) ->
    unless @getBallsHitIn().indexOf(ballNumber) >= 0
      @last_ball_hit_in = ballNumber
      
      if ballNumber > 0 and ballNumber < 8
        @balls_hit_in.solids.push ballNumber
      else if ballNumber > 8 and ballNumber < 16
        @balls_hit_in.stripes.push ballNumber
      else
        if @player.one.callback().currently_up is true
          @player.one.eight_ball.push ballNumber
        else 
          @player.two.eight_ball.push ballNumber if @player.two.callback().currently_up is true
        
        if @on_break is true
          if @balls_hit_in.solids.length isnt 7 and @balls_hit_in.stripes.length isnt 7
            if @player.one.callback().currently_up is true
              @setEightOnSnapByPlayer(1)
            else @setEightOnSnapByPlayer(2)  if @player.two.callback().currently_up is true
        else
          if @balls_hit_in.solids.length isnt 7 and @balls_hit_in.stripes.length isnt 7
            @early_eight = true
            
            if @player.one.callback().currently_up is true
              @player.one.callback().currently_up = false
              @player.two.callback().currently_up = true
            else if @player.two.callback().currently_up is true
              @player.one.callback().currently_up = true
              @player.two.callback().currently_up = false

      @checkForWinner()
      
  checkForWinner: ->
    @ended = true if @getBallsHitIn().indexOf(8) >= 0
    if @ended is true
     
      # Break and run
      if @breaking_player_still_shooting is true and (@balls_hit_in.solids.length is 7 or @balls_hit_in.stripes.length is 7)
        
        # Player 1 broke and ran out
        if @player.one.callback().currently_up is true
          @setBreakAndRunByPlayer(1)
          
          @player.one.ball_type = @solids
          @player.two.ball_type = @stripes
        
        # Player 2 broke and ran out
        else if @player.two.callback().currently_up is true
          @setBreakAndRunByPlayer(2)
          
          @player.two.ball_type = @solids
          @player.one.ball_type = @stripes
            
      # Player 1 made the 8 ball (not on break)
      if @player.one.eight_ball.indexOf(8) >= 0 and @on_break is false
        
        # Neither player made 8 balls so it is a loss by player 1
        if @getBallsHitInByPlayer(1).length != 8 and @getBallsHitInByPlayer(2).length != 8
          @setPlayerWon(2)
        # Player 1 made all 8 balls so they win the game
        else if @getBallsHitInByPlayer(1).length == 8
          @setPlayerWon(1)
          
      # Player 2 made the 8 ball (not on break)
      else if @player.two.eight_ball.indexOf(8) >= 0 and @on_break is false
      
        # Neither player made 8 balls so it is a loss by player 2
        if @getBallsHitInByPlayer(1).length != 8 and @getBallsHitInByPlayer(2).length != 8
          @setPlayerWon(1) 
        # Player 2 made all 8 balls so they win the game
        else if @getBallsHitInByPlayer(2).length == 8
          @setPlayerWon(2)
          
      # The 8 ball was made on the break
      else
        # Player 1 made the 8 on the break
        if @player.one.callback().currently_up is true
          @setPlayerWon(1)
        # Player 2 made the 8 on the break
        else if @player.two.callback().currently_up is true
          @setPlayerWon(2) 

      @match_ended_callback()

  nextPlayerIsUp: ->
    if @on_break isnt true or ((@player.two.callback().currently_up is true or @player.one.callback().currently_up is true) and @getBallsHitIn().length is 0)
      if @player.one.callback().currently_up is true
        @player.two.callback().currently_up = true
        @player.one.callback().currently_up = false
        
        unless @player.one.ball_type?
          if @balls_hit_in.solids.length > 0 and @balls_hit_in.stripes.length is 0
            @player.one.ball_type = @solids
            @player.two.ball_type = @stripes
          else if @balls_hit_in.solids.length is 0 and @balls_hit_in.stripes.length > 0
            @player.one.ball_type = @stripes
            @player.two.ball_type = @solids
            
      else if @player.two.callback().currently_up is true
        
        @player.two.callback().currently_up = false
        @player.one.callback().currently_up = true
        @addToNumberOfInnings(1)
        
        unless @player.two.ball_type?
          
          if @balls_hit_in.solids.length is 0 and @balls_hit_in.stripes.length > 0
            @player.one.ball_type = @solids
            @player.two.ball_type = @stripes
          else if @balls_hit_in.solids.length > 0 and @balls_hit_in.stripes.length is 0
            @player.one.ball_type = @stripes
            @player.two.ball_type = @solids
      else
        @player.one.callback().currently_up = true
        
      @breaking_player_still_shooting = false
      
    @on_break = false
    
  # JSON Data

  toJSON: ->
    player_one_timeouts_taken:      @player.one.timeouts_taken
    player_two_timeouts_taken:      @player.two.timeouts_taken
    player_one_eight_on_snap:       @player.one.eight_on_snap
    player_one_break_and_run:       @player.one.break_and_run
    player_two_eight_on_snap:       @player.two.eight_on_snap
    player_two_break_and_run:       @player.two.break_and_run
    player_one_ball_type:           @player.one.ball_type
    player_two_ball_type:           @player.two.ball_type
    player_one_eight_ball:          @player.one.eight_ball
    player_two_eight_ball:          @player.two.eight_ball
    player_one_won:                 @player.one.has_won
    player_two_won:                 @player.two.has_won
    number_of_innings:              @number_of_innings
    early_eight:                    @early_eight
    scratch_on_eight:               @scratch_on_eight
    breaking_player_still_shooting: @breaking_player_still_shooting
    striped_balls_hit_in:           @balls_hit_in.stripes
    solid_balls_hit_in:             @balls_hit_in.solids
    last_ball_hit_in:               @last_ball_hit_in
    on_break:                       @on_break
    ended:                          @ended
    
  fromJSON: (gameJSON) ->
    @player.one.timeouts_taken      = gameJSON.player_one_timeouts_taken
    @player.two.timeouts_taken      = gameJSON.player_two_timeouts_taken
    @player.one.eight_on_snap       = gameJSON.player_one_eight_on_snap
    @player.one.break_and_run       = gameJSON.player_one_break_and_run
    @player.two.eight_on_snap       = gameJSON.player_two_eight_on_snap
    @player.two.break_and_run       = gameJSON.player_two_break_and_run
    @player.one.ball_type           = gameJSON.player_one_ball_type
    @player.two.ball_type           = gameJSON.player_two_ball_type
    @player.one.eight_ball          = gameJSON.player_one_eight_ball
    @player.two.eight_ball          = gameJSON.player_two_eight_ball
    @player.one.has_won             = gameJSON.player_one_won
    @player.two.has_won             = gameJSON.player_two_won
    @number_of_innings              = gameJSON.number_of_innings
    @breaking_player_still_shooting = gameJSON.breaking_player_still_shooting
    @balls_hit_in.solids            = gameJSON.solid_balls_hit_in
    @balls_hit_in.stripes           = gameJSON.striped_balls_hit_in
    @last_ball_hit_in               = gameJSON.last_ball_hit_in
    @on_break                       = gameJSON.on_break
    @ended                          = gameJSON.ended
  
$CS.Models.EightBall.Game = Game
