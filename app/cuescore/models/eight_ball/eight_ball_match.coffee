class Match extends $CS.Models.EightBall
  defaults:
    player:
      one: {}
      two: {}
    completedGames: []
    ended: false
    originalId: 0
    leagueMatchId: 0
    playerNumberWinning: 0
    playerOneWon: false
    playerTwoWon: false
    arePlayersSwitching: false
    suddenDeath: false
    forfeit: false
    currentGame: null
    
  constructor: (options) ->
    _.extend @, @defaults
    
    playerOneName         = options.playerOneName
    playerTwoName         = options.playerTwoName
    playerOneRank         = options.playerOneRank
    playerTwoRank         = options.playerTwoRank
    playerOneNumber       = options.playerOneNumber
    playerTwoNumber       = options.playerTwoNumber
    playerOneTeamNumber   = options.playerOneTeamNumber
    playerTwoTeamNumber   = options.playerTwoTeamNumber
    
    @player.one = new $CS.Models.EightBall.Player(
      options = 
        name: playerOneName
        rank: playerOneRank
        playerNumber: playerOneNumber
        teamNumber: playerOneTeamNumber
    )
    
    @player.two = new $CS.Models.EightBall.Player(
      options = 
        name: playerTwoName
        rank: playerTwoRank
        playerNumber: playerTwoNumber
        teamNumber: playerTwoTeamNumber
    )
    
    if @player.one.rank? and @player.two.rank?
      @player.one.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(playerOneRank, playerTwoRank)
      @player.two.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(playerTwoRank, playerOneRank)
      
    @currentGame = @getNewGame()
    
  # Getters
  
  getNewGame: ->
    newGame = new $CS.Models.EightBall.Game(
      options = 
        addToPlayerOne: =>
          @player.one
        addToPlayerTwo: =>
          @player.two
        callback: =>
          if @getRemainingGamesNeededToWinByPlayer(1) is 0
            @playerOneWon = true
            @ended = true
          else if @getRemainingGamesNeededToWinByPlayer(2) is 0
            @playerTwoWon = true
            @ended = true
    )
    newGame
    
  getTotalInnings: ->
    totalInnings = @currentGame.numberOfInnings
    if @completedGames.length > 0
      i = 0
      while i <= (@completedGames.length - 1)
        totalInnings += @completedGames[i].numberOfInnings
        i++
    totalInnings
    
  getTotalSafeties: ->
    @player.one.getSafeties() + " to " + @player.two.getSafeties()
    
  getCurrentGameNumber: ->
    (@completedGames.length + 1)
  
  getMatchPointsByTeamNumber: (teamNumber) ->
    if @player.one.teamNumber is teamNumber
      return @getMatchPointsByPlayer(1)
    else return @getMatchPointsByPlayer(2) if @player.two.teamNumber is teamNumber
    0
    
  getWinningPlayer: ->
    if (@getGamesWonByPlayer(1) / @player.one.gamesNeededToWin) > (@getGamesWonByPlayer(2) / @player.two.gamesNeededToWin)
      return @player.one
    else
      return @player.two
    
  getRemainingGamesNeededToWinByPlayer: (playerNum) ->
    if playerNum == 1
      return (@player.one.gamesNeededToWin - @getGamesWonByPlayer(1))
    else if playerNum == 2
      return (@player.two.gamesNeededToWin - @getGamesWonByPlayer(2))
      
  getGamesWonByPlayer: (playerNum) ->
    i = 0
    if playerNum == 1
      gamesWon = (if (@currentGame.playerOneWon is true) then 1 else 0)
      while i <= (@completedGames.length - 1)
        gamesWon = gamesWon + 1  if @completedGames[i].playerOneWon is true
        i++
    else if playerNum == 2
      gamesWon = (if (@currentGame.playerTwoWon is true) then 1 else 0)
      while i <= (@completedGames.length - 1)
        gamesWon = gamesWon + 1  if @completedGames[i].playerTwoWon is true
        i++
    gamesWon
    
  getMatchPointsByPlayer: (playerNum) ->
    if playerNum is 1
      if (@getGamesWonByPlayer(1) / @player.one.gamesNeededToWin) > (@getGamesWonByPlayer(2) / @player.two.gamesNeededToWin)
        return 1 
      else
        return 0
     else if playerNum is 2
      if (@getGamesWonByPlayer(1) / @player.one.gamesNeededToWin) < (@getGamesWonByPlayer(2) / @player.two.gamesNeededToWin)
        return 1 
      else
        return 0
    
  getMatchPoints: ->
    if @getMatchPointsByPlayer(1) is @getMatchPointsByPlayer(2)
      return "TIE"
    else
      return @getMatchPointsByPlayer(1) + "-" + @getMatchPointsByPlayer(2)
    
  # Setters
  
  setSuddenDeathMode: ->
    @suddenDeath = true
    @player.one.gamesNeededToWin = 1
    @player.two.gamesNeededToWin = 1
  
  # Methods
  
  scoreNumberedBall: (ballNumber) ->
    @arePlayersSwitching = false
    @currentGame.scoreBall(ballNumber)
    
    if @isPlayerWinning(1) is true
      @playerNumberWinning = 1
    else
      @playerNumberWinning = 2
      
    @checkForWin()
    
  shotMissed: ->
    @currentGame.nextPlayerIsUp()
    @arePlayersSwitching = true if @currentGame.breakingPlayerStillShooting is false
    
  hitSafety: ->
    @currentGame.hitSafety()
    
  checkForWin: ->
    if @getRemainingGamesNeededToWinByPlayer(1) == 0 or @getRemainingGamesNeededToWinByPlayer(1) == 0
      @ended = true

  startNewGame: ->
    if @currentGame.ended is true
      @completedGames.push @currentGame
      @currentGame = @getNewGame()

  resetPlayerRankStats: ->
    @player.one.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(@player.one.rank, @player.two.rank)
    @player.two.gamesNeededToWin = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(@player.two.rank, @player.one.rank)
    @player.one.resetPlayerRankStats()
    @player.two.resetPlayerRankStats()

  isPlayerWinning: (playerNum) ->
    if playerNum == 1
      if (@getGamesWonByPlayer(1) / @player.one.gamesNeededToWin) > (@getGamesWonByPlayer(2) / @player.two.gamesNeededToWin)
        return true
      else
        return false
    else if playerNum == 2
      if (@getGamesWonByPlayer(1) / @player.one.gamesNeededToWin) < (@getGamesWonByPlayer(2) / @player.two.gamesNeededToWin)
        return true
      else
        return false
      
  # JSON Data
  
  toJSON: ->
    player:           
      one:                @player.one.toJSON()
      two:                @player.two.toJSON()
    playerOneWon:         @getGamesWonByPlayer(1)
    playerTwoWon:         @getGamesWonByPlayer(2)
    currentGame:          @currentGame.toJSON()
    completedGames:       @completedGamesToJSON()
    suddenDeath:          @suddenDeath
    forfeit:              @forfeit
    ended:                @ended
    originalId:           @originalId
    leagueMatchId:        @leagueMatchId

  completedGamesToJSON: ->
    arrayToReturn = []
    i = 0

    while i <= @completedGames.length - 1
      arrayToReturn[i] = @completedGames[i].toJSON()
      i++
    arrayToReturn

  fromJSON: (json) ->
    @player.one       = @playerFromJSON(json.player.one)
    @player.two       = @playerFromJSON(json.player.two)
    @resetPlayerRankStats()
    @completedGames   = @completedGamesFromJSON(json.completedGames)
    @suddenDeath      = json.suddenDeath
    @forfeit          = json.forfeit
    @ended            = json.ended
    @originalId       = json.originalId
    @leagueMatchId    = json.leagueMatchId
    
    currentGame = @getNewGame()
    currentGame.fromJSON (new ->
      json.currentGame
    )
    @currentGame = currentGame

  playerFromJSON: (json) ->
    player = new $CS.Models.EightBall.Player(json)
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

