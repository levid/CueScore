class EightBall extends $CS.Models.Match
  defaults:
    player: [
      one: {}
      two: {}
    ]
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
    
  initialize: (player1, player2, player1Rank, player2Rank, player1Number, player2Number, player1TeamNumber, player2TeamNumber) ->
    player['one'] = new Player('EightBall', player1, player1Rank, player1Number, player1TeamNumber)
    player['two'] = new Player('EightBall', player2, player2Rank, player2Number, player2TeamNumber)
    
    if @player['one'].rank? and @player['two'].rank?
      @player['one'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(player1Rank, player2Rank)
      @player['two'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(player2Rank, player1Rank)
      
    @current_game = @getNewGame()
    
  # Getters
  
  getNewGame: ->
    new $CS.Models.Game.EightBall(->
      @player['one']
    , ->
      @player['two']
    , ->
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
    @player['one'].getSafeties() + " to " + @player['two'].getSafeties()
    
  getCurrentGameNumber: ->
    (@completed_games.length + 1).toString()
  
  getMatchPointsByTeamNumber: (teamNumber) ->
    if @player['one'].team_number is teamNumber
      return @getMatchPointsByPlayer(1)
    else return @getMatchPointsByPlayer(2) if @player['two'].team_number is teamNumber
    0
    
  getWinningPlayer: ->
    return @player['one'] if (@getGamesWonByPlayer(1) / @player['one'].games_needed_to_win) > (@getGamesWonByPlayer(2) / @player['two'].games_needed_to_win)
    @player['two']
    
  getRemainingGamesNeededToWinByPlayer: (playerNum) ->
    if playerNum == 1
      (@player['one'].games_needed_to_win - @getGamesWonByPlayer(1)).toString()
    else if playerNum == 2
      (@player['two'].games_needed_to_win - @getGamesWonByPlayer(2)).toString()
      
  getGamesWonByPlayer: (playerNum) ->
    i = 0
    if playerNum == 1
      gamesWon = (if (@current_game.player['one'].has_won is true) then 1 else 0)
      while i <= (@completed_games.length - 1)
        gamesWon = gamesWon + 1  if @completed_games[i].player['one'].has_won is true
        i++
    else if playerNum == 2
      gamesWon = (if (@current_game.player['two'].has_won is true) then 1 else 0)
      while i <= (@CompletedGames.length - 1)
        gamesWon = gamesWon + 1  if @CompletedGames[i].player['two'].has_won is true
        i++
    gamesWon
    
  getMatchPointsByPlayer: (playerNum) ->
    return 1 if (@getGamesWonByPlayer(1) / @player['one'].games_needed_to_win) > (@getGamesWonByPlayer(2) / @player['two'].games_needed_to_win)
    0
    
  getMatchPoints: ->
    return "TIE"  if @getMatchPointsByPlayer(1) is @getMatchPointsByPlayer(2)
    @getMatchPointsByPlayer(1) + "-" + @getMatchPointsByPlayer(2)
    
  # Setters
  
  setSuddenDeathMode: ->
    @sudden_death = true
    @player['one'].games_needed_to_win = 1
    @player['two'].games_needed_to_win = 1
  
  
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
    @player['one'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(@player['one'].rank, @player['two'].rank)
    @player['two'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(@player['two'].rank, @player['one'].rank)
    @player['one'].resetPlayerRankStats()
    @player['two'].resetPlayerRankStats()

  isPlayerWinning: (playerNum) ->
    if playerNum == 1
      return true  if (@getGamesWonByPlayer(1) / @player['one'].games_needed_to_win) > (@getGamesWonByPlayer(2) / @player['two'].games_needed_to_win)
      false
    else if playerNum == 2
      return true  if (@getGamesWonByPlayer(1) / @player['one'].games_needed_to_win) < (@getGamesWonByPlayer(2) / @player['two'].games_needed_to_win)
      false
      
  # JSON Data
  
  toJSON: ->
    player_one: @player['one'].toJSON()
    player_two: @player['two'].toJSON()
    player_one_games_won: @getGamesWonByPlayer(1)
    player_two_games_won: @getGamesWonByPlayer(2)
    current_game: @current_game.toJSON()
    completed_games: @completedGamesToJSON()
    sudden_death: @sudden_death
    forfeit: @forfeit
    ended: @ended
    original_id: @original_id
    league_match_id: @league_match_id

  completedGamesToJSON: ->
    arrayToReturn = []
    i = 0

    while i <= @completed_games.length - 1
      arrayToReturn[i] = @completed_games[i].toJSON()
      i++
    arrayToReturn

  fromJSON: (json) ->
    @player['one'] = @playerFromJSON(json.player_one)
    @player['two'] = @playerFromJSON(json.player_two)
    @resetPlayerRankStats()
    @completed_games = @completedGamesFromJSON(json.completed_games)
    @sudden_death = json.sudden_death
    @forfeit = json.forfeit
    @ended = json.ended
    @original_id = json.original_id
    @league_match_id = json.league_match_id
    
    currentGame = @getNewGame()
    currentGame.fromJSON (new ->
      json.current_game
    )
    @current_game = currentGame

  playerFromJSON: (json) ->
    player = new EightBallPlayer()
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
    
$CS.Models.Match.EightBall = EightBall

