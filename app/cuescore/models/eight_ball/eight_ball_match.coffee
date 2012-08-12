class Match extends $CS.Models.EightBall
  defaults:
    player:
      one: {}
      two: {}
    completed_games: []
    ended: false
    original_id: 0
    league_match_id: 0
    player_number_winning: 0
    player_one_won: false
    player_two_won: false
    are_players_switching: false
    sudden_death: false
    forfeit: false
    current_game: null
    
  constructor: (options) ->
    _.extend @, @defaults
    
    player_one_name         = options.playerOneName
    player_two_name         = options.playerTwoName
    player_one_rank         = options.playerOneRank
    player_two_rank         = options.playerTwoRank
    player_one_number       = options.playerOneNumber
    player_two_number       = options.playerTwoNumber
    player_one_team_number  = options.playerOneTeamNumber
    player_two_team_number  = options.playerTwoTeamNumber
    
    @player.one = new $CS.Models.EightBall.Player(
      options = 
        name: player_one_name
        rank: player_one_rank
        playerNumber: player_one_number
        teamNumber: player_one_team_number
    )
    
    @player.two = new $CS.Models.EightBall.Player(
      options = 
        name: player_two_name
        rank: player_two_rank
        playerNumber: player_two_number
        teamNumber: player_two_team_number
    )
    
    if @player.one.rank? and @player.two.rank?
      @player.one.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(player_one_rank, player_two_rank)
      @player.two.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(player_two_rank, player_one_rank)
      
    @current_game = @getNewGame()
    
  # Getters
  
  getNewGame: ->
    new $CS.Models.EightBall.Game(
      options = 
        addToPlayerOne: =>
          @player.one
        addToPlayerTwo: =>
          @player.two
        callback: =>
          if @getRemainingGamesNeededToWinByPlayer(1) is 0
            @player_one_won = true
            @ended = true
          else if @getRemainingGamesNeededToWinByPlayer(2) is 0
            @player_two_won = true
            @ended = true
    )
    
  getTotalInnings: ->
    totalInnings = @current_game.number_of_innings
    if @completed_games.length > 0
      i = 0
      while i <= (@completed_games.length - 1)
        totalInnings += @completed_games[i].number_of_innings
        i++
    totalInnings.toString()
    
  getTotalSafeties: ->
    @player.one.getSafeties() + "to" + @player.two.getSafeties()
    
  getCurrentGameNumber: ->
    (@completed_games.length + 1)
  
  getMatchPointsByTeamNumber: (teamNumber) ->
    if @player.one.team_number is teamNumber
      return @getMatchPointsByPlayer(1)
    else return @getMatchPointsByPlayer(2) if @player.two.team_number is teamNumber
    0
    
  getWinningPlayer: ->
    return @player.one if (@getGamesWonByPlayer(1) / @player.one.games_needed_to_win) > (@getGamesWonByPlayer(2) / @player.two.games_needed_to_win)
    @player.two
    
  getRemainingGamesNeededToWinByPlayer: (playerNum) ->
    if playerNum == 1
      (@player.one.games_needed_to_win - @getGamesWonByPlayer(1))
    else if playerNum == 2
      (@player.two.games_needed_to_win - @getGamesWonByPlayer(2))
      
  getGamesWonByPlayer: (playerNum) ->
    i = 0
    if playerNum == 1
      gamesWon = (if (@current_game.player['one'].has_won is true) then 1 else 0)
      while i <= (@completed_games.length - 1)
        gamesWon = gamesWon + 1  if @completed_games[i].player['one'].has_won is true
        i++
    else if playerNum == 2
      gamesWon = (if (@current_game.player['two'].has_won is true) then 1 else 0)
      while i <= (@completed_games.length - 1)
        gamesWon = gamesWon + 1  if @completed_games[i].player['two'].has_won is true
        i++
    gamesWon
    
  getMatchPointsByPlayer: (playerNum) ->
    return 1 if (@getGamesWonByPlayer(1) / @player.one.games_needed_to_win) > (@getGamesWonByPlayer(2) / @player.two.games_needed_to_win)
    0
    
  getMatchPoints: ->
    if @getMatchPointsByPlayer(1) is @getMatchPointsByPlayer(2)
      return "TIE"
    else
      @getMatchPointsByPlayer(1) + "-" + @getMatchPointsByPlayer(2)
    
  # Setters
  
  setSuddenDeathMode: ->
    @sudden_death = true
    @player.one.games_needed_to_win = 1
    @player.two.games_needed_to_win = 1
  
  
  # Methods
  
  scoreNumberedBall: (ballNumber) ->
    @are_players_switching = false
    @current_game.scoreBall(ballNumber)
    
    if @isPlayerWinning(1) is true
      @player_number_winning = 1
    else
      @player_number_winning = 2
      
    @checkForWin()
    
  shotMissed: ->
    @current_game.nextPlayerIsUp()
    @are_players_switching = true if @current_game.breaking_player_still_shooting is false
    
  hitSafety: ->
    @current_game.hitSafety()
    
  checkForWin: ->
    
  startNewGame: ->
    if @current_game.ended is true
      @completed_games.push @current_game
      @current_game = @getNewGame()

  resetPlayerRankStats: ->
    @player.one.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(@player.one.rank, @player.two.rank)
    @player.two.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(@player.two.rank, @player.one.rank)
    @player.one.resetPlayerRankStats()
    @player.two.resetPlayerRankStats()

  isPlayerWinning: (playerNum) ->
    if playerNum == 1
      return true  if (@getGamesWonByPlayer(1) / @player.one.games_needed_to_win) > (@getGamesWonByPlayer(2) / @player.two.games_needed_to_win)
      false
    else if playerNum == 2
      return true  if (@getGamesWonByPlayer(1) / @player.one.games_needed_to_win) < (@getGamesWonByPlayer(2) / @player.two.games_needed_to_win)
      false
      
  # JSON Data
  
  toJSON: ->
    player_one:           @player.one.toJSON()
    player_two:           @player.two.toJSON()
    player_one_games_won: @getGamesWonByPlayer(1)
    player_two_games_won: @getGamesWonByPlayer(2)
    current_game:         @current_game.toJSON()
    completed_games:      @completedGamesToJSON()
    sudden_death:         @sudden_death
    forfeit:              @forfeit
    ended:                @ended
    original_id:          @original_id
    league_match_id:      @league_match_id

  completedGamesToJSON: ->
    arrayToReturn = []
    i = 0

    while i <= @completed_games.length - 1
      arrayToReturn[i] = @completed_games[i].toJSON()
      i++
    arrayToReturn

  fromJSON: (json) ->
    @player.one       = @playerFromJSON(json.player_one)
    @player.two       = @playerFromJSON(json.player_two)
    @resetPlayerRankStats()
    @completed_games  = @completedGamesFromJSON(json.completed_games)
    @sudden_death     = json.sudden_death
    @forfeit          = json.forfeit
    @ended            = json.ended
    @original_id      = json.original_id
    @league_match_id  = json.league_match_id
    
    currentGame = @getNewGame()
    currentGame.fromJSON (new ->
      json.current_game
    )
    @current_game = currentGame

  playerFromJSON: (json) ->
    player = new $CS.Models.EightBall.Player()
    player.fromJSON (new ->
      json
    )
    player

  completedGamesFromJSON: (json) ->
    arrayToReturn = []
    i = 0

    while i <= json.length - 1
      completedGame = @getNewGame()
      completedGame.fromJSON (new ->
        json[i]
      )
      arrayToReturn.push(completedGame)
      i++
    arrayToReturn
    
$CS.Models.EightBall.Match = Match

