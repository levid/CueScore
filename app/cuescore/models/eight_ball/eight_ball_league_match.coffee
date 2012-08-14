class LeagueMatch extends $CS.Models.EightBall
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
    if not @match[matchNumString].original_id? or @match[matchNumString].original_id is 0
      @DataService.saveMatch @match[matchNumString], (id) ->
        @match[matchNumString].original_id = id

  getMatchPointsByTeam: (team) ->
    if team == "home"
      homeScore = 0
      names = ['one', 'two', 'three', 'four', 'five']
    
      for name in names then do (name) =>
        name = name.toString()
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
    
  isHomeTeamWinning: ->
    return true if @getMatchPointsByTeam('home') > @getMatchPointsByTeam('away')
    false

  isAwayTeamWinning: ->
    return true if @getMatchPointsByTeam('home') < @getMatchPointsByTeam('away')
    false

  getWinningTeamNumber: ->
    return @awayTeamNumber if @getMatchPointsByTeam('home') < @getMatchPointsByTeam('away')
    @homeTeamNumber

  toJSON: ->
    return @toSmallJSON() if @smallJson is true
    
    matchOne:          @match.one.toJSON()
    matchTwo:          @match.two.toJSON()
    matchThree:        @match.three.toJSON()
    matchFour:         @match.four.toJSON()
    matchFive:         @match.five.toJSON()
    teamNumber:        @teamNumber
    homeTeamNumber:    @homeTeamNumber
    awayTeamNumber:    @awayTeamNumber
    startTime:         @startTime
    endTime:           @endTime
    tableType:         @tableType
    leagueMatchId:     @leagueMatchId

  fromJSON: (jsonLeagueMatch) ->
    matchOne    = new $CS.Models.EightBall.LeagueMatch()
    matchTwo    = new $CS.Models.EightBall.LeagueMatch()
    matchThree  = new $CS.Models.EightBall.LeagueMatch()
    matchFour   = new $CS.Models.EightBall.LeagueMatch()
    matchFive   = new $CS.Models.EightBall.LeagueMatch()
    
    matchOne.fromJSON jsonLeagueMatch.matchOne
    matchTwo.fromJSON jsonLeagueMatch.matchTwo
    matchThree.fromJSON jsonLeagueMatch.matchThree
    matchFour.fromJSON jsonLeagueMatch.matchFour
    matchFive.fromJSON jsonLeagueMatch.matchFive
    
    @match.one        = matchOne
    @match.two        = matchTwo
    @match.three      = matchThree
    @match.four       = matchFour
    @match.five       = matchFive
    
    @teamNumber       = jsonLeagueMatch.TeamNumber
    @homeTeamNumber   = jsonLeagueMatch.HomeTeamNumber
    @awayTeamNumber   = jsonLeagueMatch.AwayTeamNumber
    @startTime        = jsonLeagueMatch.StartTime
    @endTime          = jsonLeagueMatch.EndTime
    @tableType        = jsonLeagueMatch.TableType
    @leagueMatchId    = jsonLeagueMatch.LeagueMatchId
    
  toSmallJSON: ->
    teamNumber:       @teamNumber
    homeTeamNumber:   @homeTeamNumber
    awayTeamNumber:   @awayTeamNumber
    startTime:        @startTime
    endTime:          @endTime
    tableType:        @tableType
    leagueMatchId:    @leagueMatchId

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
  
$CS.Models.EightBall.LeagueMatch = LeagueMatch
