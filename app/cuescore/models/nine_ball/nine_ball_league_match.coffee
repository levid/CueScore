class LeagueMatch extends $CS.Models.NineBall
  defaults: 
    match:
      one: null
      two: null
      three: null
      four: null
      five: null
    teamNumber: ""
    homeTeamNumber: null
    homeTeamName: null
    homeTeamSigned: false
    awayTeamNumber: null
    awayTeamName: null
    awayTeamSigned: false
    startTime: null
    endTime: ""
    tableType: null
    smallJson: false
    leagueMatchId: 0

  constructor: (options) ->
    _.extend @, @defaults
    
    @homeTeamNumber   = options.homeTeamNumber ?= null
    @homeTeamName     = options.homeTeamName ?= null
    @awayTeamNumber   = options.awayTeamNumber ?= null
    @awayTeamName     = options.awayTeamName ?= null
    @startTime        = options.startTime ?= null
    @tableType        = options.tableType ?= null
    
    @DataService = new $CS.Utilities.DataService
    @DataService.saveLeagueMatch @, (id) =>
      @leagueMatchId = id
      
  # Getters

  getHomeTeamScore: ->
    totalScore = 0
    totalScore = @match.one.getMatchPointsByTeamNumber(@homeTeamNumber)
    totalScore += @match.two.getMatchPointsByTeamNumber(@homeTeamNumber)
    totalScore += @match.three.getMatchPointsByTeamNumber(@homeTeamNumber)
    totalScore += @match.four.getMatchPointsByTeamNumber(@homeTeamNumber)
    totalScore += @match.five.getMatchPointsByTeamNumber(@homeTeamNumber)
    totalScore

  getAwayTeamScore: ->
    totalScore = @match.one.getMatchPointsByTeamNumber(@awayTeamNumber)
    totalScore += @match.two.getMatchPointsByTeamNumber(@awayTeamNumber)
    totalScore += @match.three.getMatchPointsByTeamNumber(@awayTeamNumber)
    totalScore += @match.four.getMatchPointsByTeamNumber(@awayTeamNumber)
    totalScore += @match.five.getMatchPointsByTeamNumber(@awayTeamNumber)
    totalScore
    
  getWinningTeamNumber: ->
    return @awayTeamNumber  if @getMatchPointsByTeam('home') < @getMatchPointsByTeam('away')
    @homeTeamNumber
    
  # Setters
  
  setMatch: (matchData, matchNum) ->
    matchNumString = null
    
    if matchNum == 1
      matchNumString = "one"
    else if matchNum == 2
      matchNumString = "two"
    else if matchNum == 3
      matchNumString = "three"
    else if matchNum == 4
      matchNumString = "four"
    else if matchNum == 5
      matchNumString = "five"
      
    @match[matchNumString] = matchData
    @match[matchNumString].leagueMatchId = matchNum
    if not @match[matchNumString].originalId? or @match[matchNumString].originalId is 0
      @DataService.saveMatch @match[matchNumString], (id) ->
        @match[matchNumString].originalId = id
        
  getMatchPointsByTeam: (team) ->
    if team == "home"
      homeScore = 0
      names = ['one', 'two', 'three', 'four', 'five']
    
      for name in names then do (name) =>
        name = name
        if @match[name].player.one.teamNumber = @homeTeamNumber
          homeScore += @match[name].getMatchPointsByPlayer(1)
        else
          homeScore += @match[name].getMatchPointsByPlayer(2)
      homeScore
      
    else if team == "away"
      awayScore = 0
      names = ['one', 'two', 'three', 'four', 'five']
    
      for name in names then do (name) =>
        name = name.toString()
        if @match[name].player.one.teamNumber is @awayTeamNumber
          awayScore += @match[name].getMatchPointsByPlayer(1)
        else
          awayScore += @match[name].getMatchPointsByPlayer(2)
      awayScore

  # Methods
  
  isHomeTeamWinning: ->
    if @getMatchPointsByTeam('home') > @getMatchPointsByTeam('away')
      return true
    else
      return false

  isAwayTeamWinning: ->
    if @getMatchPointsByTeam('home') < @getMatchPointsByTeam('away')
      return true
    else
      return false
      
  getWinningTeamNumber: ->
    if @getMatchPointsByTeam('home') < @getMatchPointsByTeam('away')
      return @awayTeamNumber
    else
      return @homeTeamNumber

  toJSON: ->
    return @toSmallJSON() if @SmallJSON is true
    
    match:
      one:            @match.one.toJSON()
      two:            @match.two.toJSON()
      three:          @match.three.toJSON()
      four:           @match.four.toJSON()
      five:           @match.five.toJSON()
    teamNumber:       @teamNumber
    homeTeamNumber:   @homeTeamNumber
    awayTeamNumber:   @awayTeamNumber
    startTime:        @startTime
    endTime:          @endTime
    tableType:        @tableType
    leagueMatchId:    @leagueMatchId

  toSmallJSON: ->
    teamNumber:       @teamNumber
    homeTeamNumber:   @homeTeamNumber
    awayTeamNumber:   @awayTeamNumber
    startTime:        @startTime
    endTime:          @endTime
    tableType:        @tableType
    leagueMatchId:    @leagueMatchId

  fromJSON: (jsonLeagueMatch) ->
    unless jsonLeagueMatch?
      matchOne = new $CS.Models.NineBall.LeagueMatch(
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber
          homeTeamName: jsonLeagueMatch.homeTeamName
          awayTeamName: jsonLeagueMatch.awayTeamName
          startTime: jsonLeagueMatch.startTime
          tableType: jsonLeagueMatch.tableType
      )
      matchTwo = new $CS.Models.NineBall.LeagueMatch(
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber
          homeTeamName: jsonLeagueMatch.homeTeamName
          awayTeamName: jsonLeagueMatch.awayTeamName
          startTime: jsonLeagueMatch.startTime
          tableType: jsonLeagueMatch.tableType
      )
      matchThree = new $CS.Models.NineBall.LeagueMatch(
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber
          homeTeamName: jsonLeagueMatch.homeTeamName
          awayTeamName: jsonLeagueMatch.awayTeamName
          startTime: jsonLeagueMatch.startTime
          tableType: jsonLeagueMatch.tableType
      )
      matchFour = new $CS.Models.NineBall.LeagueMatch(
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber
          homeTeamName: jsonLeagueMatch.homeTeamName
          awayTeamName: jsonLeagueMatch.awayTeamName
          startTime: jsonLeagueMatch.startTime
          tableType: jsonLeagueMatch.tableType
      )
      matchFive = new $CS.Models.NineBall.LeagueMatch(
          homeTeamNumber: jsonLeagueMatch.homeTeamNumber
          awayTeamNumber: jsonLeagueMatch.awayTeamNumber
          homeTeamName: jsonLeagueMatch.homeTeamName
          awayTeamName: jsonLeagueMatch.awayTeamName
          startTime: jsonLeagueMatch.startTime
          tableType: jsonLeagueMatch.tableType
      )
      
      matchOne.fromJSON jsonLeagueMatch.match.one
      matchTwo.fromJSON jsonLeagueMatch.match.two
      matchThree.fromJSON jsonLeagueMatch.match.three
      matchFour.fromJSON jsonLeagueMatch.match.four
      matchFive.fromJSON jsonLeagueMatch.match.five
      
      @match.one      = matchOne
      @match.two      = matchTwo
      @match.three    = matchThree
      @match.four     = matchFour
      @match.five     = matchFive
      
      @teamNumber     = jsonLeagueMatch.teamNumber
      @homeTeamNumber = jsonLeagueMatch.homeTeamNumber
      @awayTeamNumber = jsonLeagueMatch.awayTeamNumber
      @startTime      = jsonLeagueMatch.startTime
      @endTime        = jsonLeagueMatch.endTime
      @tableType      = jsonLeagueMatch.tableType
      @leagueMatchId  = jsonLeagueMatch.leagueMatchId

  fromSmallJSON: (jsonLeagueMatch) ->
    @teamNumber       = jsonLeagueMatch.teamNumber
    @homeTeamNumber   = jsonLeagueMatch.homeTeamNumber
    @awayTeamNumber   = jsonLeagueMatch.awayTeamNumber
    @startTime        = jsonLeagueMatch.startTime
    @endTime          = jsonLeagueMatch.endTime
    @tableType        = jsonLeagueMatch.tableType
    @leagueMatchId    = jsonLeagueMatch.leagueMatchId

  ended: ->
    @match.one.ended and @match.two.ended and @match.three.ended and @match.four.ended and @match.five.ended

$CS.Models.NineBall.LeagueMatch = LeagueMatch