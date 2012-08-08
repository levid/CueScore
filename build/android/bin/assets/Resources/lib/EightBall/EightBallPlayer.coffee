EightBallPlayer = (name, rank, number, teamNumber) ->
  @Name = name
  @Rank = rank
  @Number = number
  @TeamNumber = teamNumber
  @GamesWon = 0
  @Safeties = 0
  @CurrentlyUp = false
  @EightOnSnaps = 0
  @BreakAndRuns = 0
  @TimeoutsAllowed = new EightBallRanks().getTimeouts(rank)
  @GamesNeededToWin = 0
  @IsCaptain = false
  @getGamesNeededToWin = ->
    @GamesNeededToWin.toString()

  @resetPlayerRankStats = ->
    @TimeoutsAllowed = new EightBallRanks().getTimeouts(@Rank)

  @addOneToGamesWon = ->
    @GamesWon += 1

  @addOneToSafeties = ->
    @Safeties += 1

  @hasWon = ->
    @Score >= @BallCount

  @addOneToEightOnSnaps = ->
    @EightOnSnaps += 1

  @addOneToBreakAndRuns = ->
    @BreakAndRuns += 1

  @getRemainingBallCount = ->
    (@BallCount - @Score).toString()

  @getFirstNameWithInitials = ->
    spaceIndex = @Name.indexOf(" ")
    return @Name  if spaceIndex is -1
    nameToReturn = @Name.substr(0, spaceIndex)
    nameToReturn + " " + @Name[spaceIndex + 1] + "."

  @getSafeties = ->
    @Safeties.toString()

  @getGamesWon = ->
    @GamesWon.toString()

  @getRatioScore = ->
    @Score / @BallCount

  @getEightOnSnaps = ->
    @EightOnSnaps.toString()

  @getBreakAndRuns = ->
    @BreakAndRuns.toString()

  @toJSON = ->
    Name: @Name
    Rank: @Rank
    GamesNeededToWin: @GamesNeededToWin
    Number: @Number
    TeamNumber: @TeamNumber
    GamesWon: @GamesWon
    Safeties: @Safeties
    EightOnSnaps: @EightOnSnaps
    BreakAndRuns: @BreakAndRuns
    CurrentlyUp: @CurrentlyUp

  @fromJSON = (playerJSON) ->
    @Name = playerJSON.Name
    @Rank = playerJSON.Rank
    @Number = playerJSON.Number
    @TeamNumber = playerJSON.TeamNumber
    @GamesWon = playerJSON.GamesWon
    @Safeties = playerJSON.Safeties
    @EightOnSnaps = playerJSON.EightOnSnaps
    @BreakAndRuns = playerJSON.BreakAndRuns
    @CurrentlyUp = playerJSON.CurrentlyUp
    @resetPlayerRankStats()