NineBallPlayer = (name, rank, number, teamNumber) ->
  @Name = name
  @Rank = rank
  @Number = number
  @TeamNumber = teamNumber
  @BallCount = new NineBallRanks().getBallCount(rank).toString()
  @Score = 0
  @Safeties = 0
  @CurrentlyUp = false
  @NineOnSnaps = 0
  @BreakAndRuns = 0
  @TimeoutsTaken = 0
  @TimeoutsAllowed = new NineBallRanks().getTimeouts(rank)
  @IsCaptain = false
  @resetPlayerRankStats = ->
    @BallCount = new NineBallRanks().getBallCount(@Rank).toString()
    @TimeoutsAllowed = new NineBallRanks().getTimeouts(@Rank)

  @addToScore = (addToScore) ->
    @Score += addToScore

  @addOneToSafeties = ->
    @Safeties += 1

  @hasWon = ->
    @Score >= @BallCount

  @addOneToNineOnSnaps = ->
    @NineOnSnaps += 1

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

  @getScore = ->
    @Score.toString()

  @getRatioScore = ->
    @Score / @BallCount

  @getNineOnSnaps = ->
    @NineOnSnaps.toString()

  @getBreakAndRuns = ->
    @BreakAndRuns.toString()

  @toJSON = ->
    Name: @Name
    Rank: @Rank
    BallCount: @BallCount
    Number: @Number
    TeamNumber: @TeamNumber
    Score: @Score
    Safeties: @Safeties
    NineOnSnaps: @NineOnSnaps
    BreakAndRuns: @BreakAndRuns
    CurrentlyUp: @CurrentlyUp

  @fromJSON = (playerJSON) ->
    @Name = playerJSON.Name
    @Rank = playerJSON.Rank
    @BallCount = playerJSON.BallCount
    @Number = playerJSON.Number
    @TeamNumber = playerJSON.TeamNumber
    @Score = playerJSON.Score
    @Safeties = playerJSON.Safeties
    @NineOnSnaps = playerJSON.NineOnSnaps
    @BreakAndRuns = playerJSON.BreakAndRuns
    @CurrentlyUp = playerJSON.CurrentlyUp
    @resetPlayerRankStats()