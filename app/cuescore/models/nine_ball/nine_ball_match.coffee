class Match extends $CS.Models.NineBall
  defaults:
    player:
      one: {}
      two: {}
    completedGames: []
    ended: false
    originalId: 0
    leagueMatchId: 0
    playerNumberWinning: 0
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
    
    @player.one = new $CS.Models.NineBall.Player(
      options =
        name: playerOneName
        rank: playerOneRank
        number: playerOneNumber
        teamNumber: playerOneTeamNumber
    )
        
    @player.two = new $CS.Models.NineBall.Player(
      options =
        name: playerTwoName
        rank: playerTwoRank
        number: playerTwoNumber
        teamNumber: playerTwoTeamNumber
    )
    
    @currentGame = @getNewGame()
  
  # Getters
  
  getNewGame: ->
    newGame = new $CS.Models.NineBall.Game(
      options = 
        addToPlayerOne: =>
          @player.one
        addToPlayerTwo: =>
          @player.two
        callback: =>
          @ended = true
    )
    newGame
    
  getPlayerScore: (playerNum) ->
    if playerNum == 1
      return @player.one.score
    else if playerNum == 2
      return @player.two.score

  getLosingPlayer: ->
    (if (@isPlayerWinning(1) is true) then @player.two else @player.one)

  getWinningPlayer: ->
    (if (@isPlayerWinning(1) is true) then @player.one else @player.two)

  getLosingPlayersMatchPoints: ->
    losingScore = new $CS.Models.NineBall.Ranks().getLosingPlayersMatchPoints(@getLosingPlayer().rank, @getLosingPlayer().score)
    losingScore

  getWinningPlayersMatchPoints: ->
    winningScore = new $CS.Models.NineBall.Ranks().getWinningPlayersMatchPoints(@getLosingPlayer().rank, @getLosingPlayer().score)
    winningScore

  getMatchPointsByPlayer: (playerNum) ->
    if playerNum == 1
      if @isPlayerWinning(1) is true and @isPlayerWinning(2) is false
        return new $CS.Models.NineBall.Ranks().getWinningPlayersMatchPoints(@getLosingPlayer().rank, @getLosingPlayer().score)  
      else
        return new $CS.Models.NineBall.Ranks().getLosingPlayersMatchPoints(@getLosingPlayer().rank, @getLosingPlayer().score)
    else if playerNum == 2
      if @isPlayerWinning(1) is false and @isPlayerWinning(2) is true
        return new $CS.Models.NineBall.Ranks().getWinningPlayersMatchPoints(@getLosingPlayer().rank, @getLosingPlayer().score)
      else
        return new $CS.Models.NineBall.Ranks().getLosingPlayersMatchPoints(@getLosingPlayer().rank, @getLosingPlayer().score)

  getMatchPoints: ->
    if @isPlayerWinning(1) is true
      return new $CS.Models.NineBall.Ranks().getWinningPlayersMatchPoints(@player.two.rank, @player.two.score) + "-" + new $CS.Models.NineBall.Ranks().getLosingPlayersMatchPoints(@player.two.rank, @player.two.score)
    else if @isPlayerWinning(2) is true
      return new $CS.Models.NineBall.Ranks().getLosingPlayersMatchPoints(@player.one.rank, @player.one.score) + "-" + new $CS.Models.NineBall.Ranks().getWinningPlayersMatchPoints(@player.one.rank, @player.one.score)
    else
      return "Tied"
    
  getMatchPointsByTeamNumber: (teamNumber) ->
    if @player.one.teamNumber is teamNumber
      return @getMatchPointsByPlayer(1)
    else if @player.two.teamNumber is teamNumber
      return @getMatchPointsByPlayer(2)
    else
      return 0

  getTotalInnings: ->
    totalInnings = @currentGame.numberOfInnings
    if @completedGames.length > 0
      i = 0
      while i <= (@completedGames.length - 1)
        totalInnings += @completedGames[i].numberOfInnings
        i++
    totalInnings.toString()

  getTotalDeadBalls: ->
    totalDeadBalls = @currentGame.getDeadBalls()
    if @completedGames.length > 0
      i = 0
      while i <= (@completedGames.length - 1)
        totalDeadBalls += @completedGames[i].getDeadBalls()
        i++
    totalDeadBalls.toString()

  getTotalSafeties: ->
    @player.one.getSafeties() + " to " + @player.two.getSafeties()

  getCurrentGameNumber: ->
    (@completedGames.length + 1).toString()
    
  # Setters
  
  setSuddenDeathMode: ->
    @suddenDeath = true
    @player.one.gamesNeededToWin = 1
    @player.two.gamesNeededToWin = 1
  
  # Methods
  
  scoreNumberedBall: (ballNumber) ->
    @currentGame.scoreBall ballNumber
    if @isPlayerWinning(1) is true
      @playerNumberWinning = 1
    else
      @playerNumberWinning = 2
      
    @checkForWin()

  shotMissed: ->
    @currentGame.nextPlayerIsUp()

  hitDeadBall: (ballNumber) ->
    @currentGame.hitDeadBall ballNumber
    @checkForWin()

  hitSafety: ->
    @currentGame.hitSafety()

  checkForWin: ->

  startNewGame: ->
    if @currentGame.ended is true
      @completedGames.push @currentGame
      @currentGame = @getNewGame()

  isPlayerWinning: (playerNum) ->
    if playerNum == 1
      if (@player.one.getRatioScore() > @player.two.getRatioScore()) or (@player.one.getRatioScore() is @player.two.getRatioScore() and @playerNumberWinning is 1)
        return true
      else
        return false
    else if playerNum == 2
      if (@player.one.getRatioScore() < @player.two.getRatioScore()) or (@player.one.getRatioScore() is @player.two.getRatioScore() and @playerNumberWinning is 2)
        return true
      else
        return false


  toJSON: ->
    player:
      one:                      @player.one.toJSON()
      two:                      @player.two.toJSON()
    playerOneMatchPointsEarned: @getMatchPointsByPlayer(1)
    playerTwoMatchPointsEarned: @getMatchPointsByPlayer(2)
    currentGame:                @currentGame.toJSON()
    completedGames:             @completedGamesToJSON()
    suddenDeath:                @suddenDeath
    forfeit:                    @forfeit
    ended:                      @ended
    originalId:                 @originalId
    leagueMatchId:              @leagueMatchId

  completedGamesToJSON: ->
    arrayToReturn = []
    i = 0

    while i <= @completedGames.length - 1
      arrayToReturn[i] = @completedGames[i].toJSON()
      i++
    arrayToReturn

  fromJSON: (json) ->
    @playerOneMatchPointsEarned = json.playerOneMatchPointsEarned
    @playerTwoMatchPointsEarned = json.playerTwoMatchPointsEarned
    @player.one                 = @playerFromJSON(json.player.one)
    @player.two                 = @playerFromJSON(json.player.two)
    @completedGames             = @completedGamesFromJSON(json.completedGames)
    @suddenDeath                = json.suddenDeath
    @forfeit                    = json.forfeit
    @ended                      = json.ended
    @originalId                 = json.originalId
    @leagueMatchId              = json.leagueMatchId
    
    currentGame = @getNewGame()
    currentGame.fromJSON (new ->
      json.currentGame
    )
    @currentGame = currentGame

  playerFromJSON: (json) ->
    player = new $CS.Models.NineBall.Player(json)
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
      arrayToReturn.push completedGame
      i++
    arrayToReturn

$CS.Models.NineBall.Match = Match