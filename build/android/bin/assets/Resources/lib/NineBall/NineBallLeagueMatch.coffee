NineBallLeagueMatch = (HomeTeamNumber, AwayTeamNumber, HomeTeamName, AwayTeamName, StartTime, TableType) ->
  @GameType = "NineBall"
  @MatchOne = null
  @MatchTwo = null
  @MatchThree = null
  @MatchFour = null
  @MatchFive = null
  @TeamNumber = ""
  @HomeTeamNumber = HomeTeamNumber
  @AwayTeamNumber = AwayTeamNumber
  @HomeTeamName = HomeTeamName
  @AwayTeamName = AwayTeamName
  @HomeTeamSigned = false
  @AwayTeamSigned = false
  @StartTime = StartTime
  @EndTime = ""
  @TableType = TableType
  @SmallJSON = false
  @LeagueMatchId = 0
  me = this
  DataService.saveLeagueMatch this, (id) ->
    me.LeagueMatchId = id

  @getHomeTeamMatchPoints = ->
    totalScore = 0
    totalScore = @MatchOne.getMatchPointsByTeamNumber(@HomeTeamNumber)
    totalScore += @MatchTwo.getMatchPointsByTeamNumber(@HomeTeamNumber)
    totalScore += @MatchThree.getMatchPointsByTeamNumber(@HomeTeamNumber)
    totalScore += @MatchFour.getMatchPointsByTeamNumber(@HomeTeamNumber)
    totalScore += @MatchFive.getMatchPointsByTeamNumber(@HomeTeamNumber)
    totalScore

  @getAwayTeamMatchPoints = ->
    totalScore = @MatchOne.getMatchPointsByTeamNumber(@AwayTeamNumber)
    totalScore += @MatchTwo.getMatchPointsByTeamNumber(@AwayTeamNumber)
    totalScore += @MatchThree.getMatchPointsByTeamNumber(@AwayTeamNumber)
    totalScore += @MatchFour.getMatchPointsByTeamNumber(@AwayTeamNumber)
    totalScore += @MatchFive.getMatchPointsByTeamNumber(@AwayTeamNumber)
    totalScore

  @isHomeTeamWinning = ->
    return true  if @getHomeTeamMatchPoints() > @getAwayTeamMatchPoints()
    false

  @isAwayTeamWinning = ->
    return true  if @getHomeTeamMatchPoints() < @getAwayTeamMatchPoints()
    false

  @getWinningTeamNumber = ->
    return @AwayTeamNumber  if @getHomeTeamMatchPoints() < @getAwayTeamMatchPoints()
    @HomeTeamNumber

  @setMatchOne = (match) ->
    @MatchOne = match
    @MatchOne.LeagueMatchId = @LeagueMatchId
    if not @MatchOne.OriginalId? or @MatchOne.OriginalId is 0
      DataService.saveMatch @MatchOne, (id) ->
        me.MatchOne.OriginalId = id

  @setMatchTwo = (match) ->
    @MatchTwo = match
    @MatchTwo.LeagueMatchId = @LeagueMatchId
    if not @MatchTwo.OriginalId? or @MatchTwo.OriginalId is 0
      DataService.saveMatch @MatchTwo, (id) ->
        me.MatchTwo.OriginalId = id

  @setMatchThree = (match) ->
    @MatchThree = match
    @MatchThree.LeagueMatchId = @LeagueMatchId
    if not @MatchThree.OriginalId? or @MatchThree.OriginalId is 0
      DataService.saveMatch @MatchThree, (id) ->
        me.MatchThree.OriginalId = id

  @setMatchFour = (match) ->
    @MatchFour = match
    @MatchFour.LeagueMatchId = @LeagueMatchId
    if not @MatchFour.OriginalId? or @MatchFour.OriginalId is 0
      DataService.saveMatch @MatchFour, (id) ->
        me.MatchFour.OriginalId = id

  @setMatchFive = (match) ->
    @MatchFive = match
    @MatchFive.LeagueMatchId = @LeagueMatchId
    if not @MatchFive.OriginalId? or @MatchFive.OriginalId is 0
      DataService.saveMatch @MatchFive, (id) ->
        me.MatchFive.OriginalId = id

  @toJSON = ->
    return @toSmallJSON()  if @SmallJSON is true
    MatchOne: @MatchOne.toJSON()
    MatchTwo: @MatchTwo.toJSON()
    MatchThree: @MatchThree.toJSON()
    MatchFour: @MatchFour.toJSON()
    MatchFive: @MatchFive.toJSON()
    TeamNumber: @TeamNumber
    HomeTeamNumber: @HomeTeamNumber
    AwayTeamNumber: @AwayTeamNumber
    StartTime: @StartTime
    EndTime: @EndTime
    TableType: @TableType
    LeagueMatchId: @LeagueMatchId

  @toSmallJSON = ->
    TeamNumber: @TeamNumber
    HomeTeamNumber: @HomeTeamNumber
    AwayTeamNumber: @AwayTeamNumber
    StartTime: @StartTime
    EndTime: @EndTime
    TableType: @TableType
    LeagueMatchId: @LeagueMatchId

  @fromJSON = (jsonLeagueMatch) ->
    matchOne = new NineBallMatch()
    matchOne.fromJSON jsonLeagueMatch.MatchOne
    matchTwo = new NineBallMatch()
    matchTwo.fromJSON jsonLeagueMatch.MatchTwo
    matchThree = new NineBallMatch()
    matchThree.fromJSON jsonLeagueMatch.MatchThree
    matchFour = new NineBallMatch()
    matchFour.fromJSON jsonLeagueMatch.MatchFour
    matchFive = new NineBallMatch()
    matchFive.fromJSON jsonLeagueMatch.MatchFive
    @MatchOne = matchOne
    @MatchTwo = matchTwo
    @MatchThree = matchThree
    @MatchFour = matchFour
    @MatchFive = matchFive
    @TeamNumber = jsonLeagueMatch.TeamNumber
    @HomeTeamNumber = jsonLeagueMatch.HomeTeamNumber
    @AwayTeamNumber = jsonLeagueMatch.AwayTeamNumber
    @StartTime = jsonLeagueMatch.StartTime
    @EndTime = jsonLeagueMatch.EndTime
    @TableType = jsonLeagueMatch.TableType
    @LeagueMatchId = jsonLeagueMatch.LeagueMatchId

  @fromSmallJSON = (jsonLeagueMatch) ->
    @TeamNumber = jsonLeagueMatch.TeamNumber
    @HomeTeamNumber = jsonLeagueMatch.HomeTeamNumber
    @AwayTeamNumber = jsonLeagueMatch.AwayTeamNumber
    @StartTime = jsonLeagueMatch.StartTime
    @EndTime = jsonLeagueMatch.EndTime
    @TableType = jsonLeagueMatch.TableType
    @LeagueMatchId = jsonLeagueMatch.LeagueMatchId

  @Ended = ->
    @MatchOne.Ended and @MatchTwo.Ended and @MatchThree.Ended and @MatchFour.Ended and @MatchFive.Ended