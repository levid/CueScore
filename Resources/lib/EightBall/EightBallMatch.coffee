EightBallMatch = (player1, player2, player1Rank, player2Rank, player1Number, player2Number, player1TeamNumber, player2TeamNumber) ->
  @PlayerOne = new EightBallPlayer(player1, player1Rank, player1Number, player1TeamNumber)
  @PlayerTwo = new EightBallPlayer(player2, player2Rank, player2Number, player2TeamNumber)
  if @PlayerOne.Rank? and @PlayerTwo.Rank?
    @PlayerOne.GamesNeededToWin = new EightBallRanks().getGamesNeedToWin(player1Rank, player2Rank)
    @PlayerTwo.GamesNeededToWin = new EightBallRanks().getGamesNeedToWin(player2Rank, player1Rank)
  @CompletedGames = []
  @Ended = false
  @OriginalId = 0
  @LeagueMatchId = 0
  @PlayerNumberWinning = 0
  @PlayerOneWon = false
  @PlayerTwoWon = false
  @ArePlayersSwitching = false
  @SuddenDeath = false
  @Forfeit = false
  me = this #need this for callback
  @getNewGame = ->
    new EightBallGame(->
      me.PlayerOne
    , ->
      me.PlayerTwo
    , ->
      if me.getPlayerOneRemainingGamesNeededToWin() is 0
        me.PlayerOneWon = true
        me.Ended = true
      else if me.getPlayerTwoRemainingGamesNeededToWin() is 0
        me.PlayerTwoWon = true
        me.Ended = true
    )

  @CurrentGame = @getNewGame()
  @scoreNumberedBall = (ballNumber) ->
    @ArePlayersSwitching = false
    @CurrentGame.scoreBall ballNumber
    if @isPlayerOneWinning() is true
      @PlayerNumberWinning = 1
    else
      @PlayerNumberWinning = 2
    @checkForWin()

  @shotMissed = ->
    @CurrentGame.nextPlayerIsUp()
    @ArePlayersSwitching = true  if @CurrentGame.BreakingPlayerStillHitting is false

  @hitSafety = ->
    @CurrentGame.hitSafety()

  @checkForWin = ->

  @startNewGame = ->
    if @CurrentGame.Ended is true
      @CompletedGames.push @CurrentGame
      @CurrentGame = @getNewGame()

  @setSuddenDeathMode = ->
    @SuddenDeath = true
    @PlayerOne.GamesNeededToWin = 1
    @PlayerTwo.GamesNeededToWin = 1

  @resetPlayerRankStats = ->
    @PlayerOne.GamesNeededToWin = new EightBallRanks().getGamesNeedToWin(@PlayerOne.Rank, @PlayerTwo.Rank)
    @PlayerTwo.GamesNeededToWin = new EightBallRanks().getGamesNeedToWin(@PlayerTwo.Rank, @PlayerOne.Rank)
    @PlayerOne.resetPlayerRankStats()
    @PlayerTwo.resetPlayerRankStats()

  @getMatchPointsByTeamNumber = (teamNumber) ->
    if @PlayerOne.TeamNumber is teamNumber
      return @getPlayerOneMatchPoints()
    else return @getPlayerTwoMatchPoints()  if @PlayerTwo.TeamNumber is teamNumber
    0

  @getWinningPlayer = ->
    return @PlayerOne  if (@getPlayerOneGamesWon() / @PlayerOne.GamesNeededToWin) > (@getPlayerTwoGamesWon() / @PlayerTwo.GamesNeededToWin)
    @PlayerTwo

  @getPlayerOneRemainingGamesNeededToWin = ->
    (@PlayerOne.GamesNeededToWin - @getPlayerOneGamesWon()).toString()

  @getPlayerOneGamesWon = ->
    gamesWon = (if (@CurrentGame.PlayerOneWon is true) then 1 else 0)
    i = 0
    while i <= (@CompletedGames.length - 1)
      gamesWon = gamesWon + 1  if @CompletedGames[i].PlayerOneWon is true
      i++
    gamesWon

  @getPlayerTwoRemainingGamesNeededToWin = ->
    (@PlayerTwo.GamesNeededToWin - @getPlayerTwoGamesWon()).toString()

  @getPlayerTwoGamesWon = ->
    gamesWon = (if (@CurrentGame.PlayerTwoWon is true) then 1 else 0)
    i = 0
    while i <= (@CompletedGames.length - 1)
      gamesWon = gamesWon + 1  if @CompletedGames[i].PlayerTwoWon is true
      i++
    gamesWon

  @getPlayerOneMatchPoints = ->
    return 1  if (@getPlayerOneGamesWon() / @PlayerOne.GamesNeededToWin) > (@getPlayerTwoGamesWon() / @PlayerTwo.GamesNeededToWin)
    0

  @getPlayerTwoMatchPoints = ->
    return 1  if (@getPlayerOneGamesWon() / @PlayerOne.GamesNeededToWin) < (@getPlayerTwoGamesWon() / @PlayerTwo.GamesNeededToWin)
    0

  @getMatchPoints = ->
    return "TIE"  if @getPlayerOneMatchPoints() is @getPlayerTwoMatchPoints()
    @getPlayerOneMatchPoints() + "-" + @getPlayerTwoMatchPoints()

  @isPlayerOneWinning = ->
    return true  if (@getPlayerOneGamesWon() / @PlayerOne.GamesNeededToWin) > (@getPlayerTwoGamesWon() / @PlayerTwo.GamesNeededToWin)
    false

  @isPlayerTwoWinning = ->
    return true  if (@getPlayerOneGamesWon() / @PlayerOne.GamesNeededToWin) < (@getPlayerTwoGamesWon() / @PlayerTwo.GamesNeededToWin)
    false

  @getTotalInnings = ->
    totalInnings = @CurrentGame.NumberOfInnings
    if @CompletedGames.length > 0
      i = 0
      while i <= (@CompletedGames.length - 1)
        totalInnings += @CompletedGames[i].NumberOfInnings
        i++
    totalInnings.toString()

  @getTotalSafeties = ->
    @PlayerOne.getSafeties() + " to " + @PlayerTwo.getSafeties()

  @getCurrentGameNumber = ->
    (@CompletedGames.length + 1).toString()

  @toJSON = ->
    PlayerOne: @PlayerOne.toJSON()
    PlayerTwo: @PlayerTwo.toJSON()
    PlayerOneGamesWon: @getPlayerOneGamesWon()
    PlayerTwoGamesWon: @getPlayerTwoGamesWon()
    CurrentGame: @CurrentGame.toJSON()
    CompletedGames: @completedGamesToJSON()
    SuddenDeath: @SuddenDeath
    Forfeit: @Forfeit
    Ended: @Ended
    OriginalId: @OriginalId
    LeagueMatchId: @LeagueMatchId

  @completedGamesToJSON = ->
    arrayToReturn = []
    i = 0

    while i <= @CompletedGames.length - 1
      arrayToReturn[i] = @CompletedGames[i].toJSON()
      i++
    arrayToReturn

  @fromJSON = (json) ->
    @PlayerOne = @playerFromJSON(json.PlayerOne)
    @PlayerTwo = @playerFromJSON(json.PlayerTwo)
    @resetPlayerRankStats()
    @CompletedGames = @completedGamesFromJSON(json.CompletedGames)
    @SuddenDeath = json.SuddenDeath
    @Forfeit = json.Forfeit
    @Ended = json.Ended
    @OriginalId = json.OriginalId
    @LeagueMatchId = json.LeagueMatchId
    currentGame = @getNewGame()
    currentGame.fromJSON (new ->
      json.CurrentGame
    )
    @CurrentGame = currentGame

  @playerFromJSON = (json) ->
    player = new EightBallPlayer()
    player.fromJSON (new ->
      json
    )
    player

  @completedGamesFromJSON = (json) ->
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