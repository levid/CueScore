class Match extends $CS.Models.NineBall
  defaults: {}

  constructor: (player1, player2, player1Rank, player2Rank, player1Number, player2Number, player1TeamNumber, player2TeamNumber) ->
    _.extend @, @defaults
    
    @PlayerOne = new NineBallPlayer(player1, player1Rank, player1Number, player1TeamNumber)
    @PlayerTwo = new NineBallPlayer(player2, player2Rank, player2Number, player2TeamNumber)
    @CompletedGames = []
    @Ended = false
    @OriginalId = 0
    @LeagueMatchId = 0
    @PlayerNumberWinning = 0
    @SuddenDeath = false
    @Forfeit = false
    me = this #need this for callback
    
    getNewGame = ->
      new NineBallGame(->
        me.PlayerOne
      , ->
        me.PlayerTwo
      , ->
        me.Ended = true
      )
  
    @CurrentGame = @getNewGame()
    
  scoreNumberedBall: (ballNumber) ->
    @CurrentGame.scoreBall ballNumber
    if @isPlayerOneWinning() is true
      @PlayerNumberWinning = 1
    else
      @PlayerNumberWinning = 2
    @checkForWin()

  shotMissed: ->
    @CurrentGame.nextPlayerIsUp()

  hitDeadBall: (ballNumber) ->
    @CurrentGame.hitDeadBall ballNumber
    @checkForWin()

  hitSafety: ->
    @CurrentGame.hitSafety()

  checkForWin: ->

  startNewGame: ->
    if @CurrentGame.Ended is true
      @CompletedGames.push me.CurrentGame
      @CurrentGame = me.getNewGame()

  setSuddenDeathMode: ->
    @SuddenDeath = true
    @PlayerOne.GamesNeededToWin = 1
    @PlayerTwo.GamesNeededToWin = 1

  getPlayerOneScore: ->
    @PlayerOne.Score

  getLosingPlayer: ->
    (if (@isPlayerOneWinning() is true) then @PlayerTwo else @PlayerOne)

  getWinningPlayer: ->
    (if (@isPlayerOneWinning() is true) then @PlayerOne else @PlayerTwo)

  getLosingPlayersMatchPoints: ->
    losingScore = new NineBallRanks().getLosingPlayersMatchPoints(@getLosingPlayer().Rank, @getLosingPlayer().Score)
    losingScore

  getWinningPlayersMatchPoints: ->
    winningScore = new NineBallRanks().getWinningPlayersMatchPoints(@getLosingPlayer().Rank, @getLosingPlayer().Score)
    winningScore

  getPlayerOneMatchPoints: ->
    return new NineBallRanks().getWinningPlayersMatchPoints(@getLosingPlayer().Rank, @getLosingPlayer().Score)  if @isPlayerOneWinning() is true and @isPlayerTwoWinning() is false
    new NineBallRanks().getLosingPlayersMatchPoints @getLosingPlayer().Rank, @getLosingPlayer().Score

  getPlayerTwoMatchPoints: ->
    return new NineBallRanks().getWinningPlayersMatchPoints(@getLosingPlayer().Rank, @getLosingPlayer().Score)  if @isPlayerOneWinning() is false and @isPlayerTwoWinning() is true
    new NineBallRanks().getLosingPlayersMatchPoints @getLosingPlayer().Rank, @getLosingPlayer().Score

  getMatchPoints: ->
    if @isPlayerOneWinning() is true
      return new NineBallRanks().getWinningPlayersMatchPoints(@PlayerTwo.Rank, @PlayerTwo.Score) + "-" + new NineBallRanks().getLosingPlayersMatchPoints(@PlayerTwo.Rank, @PlayerTwo.Score)
    else return new NineBallRanks().getLosingPlayersMatchPoints(@PlayerOne.Rank, @PlayerOne.Score) + "-" + new NineBallRanks().getWinningPlayersMatchPoints(@PlayerOne.Rank, @PlayerOne.Score)  if @isPlayerTwoWinning() is true
    "Tied"

  isPlayerOneWinning: ->
    return true  if (@PlayerOne.getRatioScore() > @PlayerTwo.getRatioScore()) or (@PlayerOne.getRatioScore() is @PlayerTwo.getRatioScore() and @PlayerNumberWinning is 1)
    false

  isPlayerTwoWinning: ->
    return true  if (@PlayerOne.getRatioScore() < @PlayerTwo.getRatioScore()) or (@PlayerOne.getRatioScore() is @PlayerTwo.getRatioScore() and @PlayerNumberWinning is 2)
    false

  getMatchPointsByTeamNumber: (teamNumber) ->
    if @PlayerOne.TeamNumber is teamNumber
      return @getPlayerOneMatchPoints()
    else return @getPlayerTwoMatchPoints()  if @PlayerTwo.TeamNumber is teamNumber
    0

  getTotalInnings: ->
    totalInnings = @CurrentGame.NumberOfInnings
    if @CompletedGames.length > 0
      i = 0
      while i <= (@CompletedGames.length - 1)
        totalInnings += @CompletedGames[i].NumberOfInnings
        i++
    totalInnings.toString()

  getTotalDeadBalls: ->
    totalDeadBalls = @CurrentGame.getDeadBalls()
    if @CompletedGames.length > 0
      i = 0
      while i <= (@CompletedGames.length - 1)
        totalDeadBalls += @CompletedGames[i].getDeadBalls()
        i++
    totalDeadBalls.toString()

  getTotalSafeties: ->
    @PlayerOne.getSafeties() + " to " + @PlayerTwo.getSafeties()

  getCurrentGameNumber: ->
    (@CompletedGames.length + 1).toString()

  toJSON: ->
    PlayerOne: @PlayerOne.toJSON()
    PlayerTwo: @PlayerTwo.toJSON()
    PlayerOneMatchPointsEarned: @getPlayerOneMatchPoints()
    PlayerTwoMatchPointsEarned: @getPlayerTwoMatchPoints()
    CurrentGame: @CurrentGame.toJSON()
    CompletedGames: @completedGamesToJSON()
    SuddenDeath: @SuddenDeath
    Forfeit: @Forfeit
    Ended: @Ended
    OriginalId: @OriginalId
    LeagueMatchId: @LeagueMatchId

  completedGamesToJSON: ->
    arrayToReturn = []
    i = 0

    while i <= @CompletedGames.length - 1
      arrayToReturn[i] = @CompletedGames[i].toJSON()
      i++
    arrayToReturn

  fromJSON: (json) ->
    @PlayerOneMatchPointsEarned = json.PlayerOneMatchPointsEarned
    @PlayerTwoMatchPointsEarned = json.PlayerTwoMatchPointsEarned
    @PlayerOne = @playerFromJSON(json.PlayerOne)
    @PlayerTwo = @playerFromJSON(json.PlayerTwo)
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

  playerFromJSON: (json) ->
    player = new NineBallPlayer()
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