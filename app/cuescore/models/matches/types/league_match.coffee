class LeagueMatch extends $CS.Models.Match.Type
  defaults:
    game_type: null
    match: [
      one: null
      two: null
      three: null
      four: null
      five: null
    ]
    team_number: ""
    home_team:
      number: null
      name: null
      signed: false
    away_team:
      number: null
      name: null
      signed: false
    start_time: null
    end_time: ""
    table_type: null
    small_json: false
    league_match_id: 0

  initialize: (GameType, HomeTeamNumber, AwayTeamNumber, HomeTeamName, AwayTeamName, StartTime, TableType) ->
    @game_type        = "EightBall"
    @home_team.number = HomeTeamNumber?
    @home_team.name   = HomeTeamName?
    @away_team.number = AwayTeamNumber?
    @away_team.name   = AwayTeamName?
    @start_time       = StartTime?
    @table_type       = TableType?
    
    DataService.saveLeagueMatch @, (id) ->
      @league_match_id = id

  # Getters

  getHomeTeamScore: ->
    totalScore = 0
    totalScore = @match['one'].getMatchPointsByTeamNumber(@home_team.number)
    totalScore += @match['two'].getMatchPointsByTeamNumber(@home_team.number)
    totalScore += @match['three'].getMatchPointsByTeamNumber(@home_team.number)
    totalScore += @match['four'].getMatchPointsByTeamNumber(@home_team.number)
    totalScore += @match['five'].getMatchPointsByTeamNumber(@home_team.number)
    totalScore

  getAwayTeamScore: ->
    totalScore = @match['one'].getMatchPointsByTeamNumber(@away_team.number)
    totalScore += @match['two'].getMatchPointsByTeamNumber(@away_team.number)
    totalScore += @match['three'].getMatchPointsByTeamNumber(@away_team.number)
    totalScore += @match['four'].getMatchPointsByTeamNumber(@away_team.number)
    totalScore += @match['five'].getMatchPointsByTeamNumber(@away_team.number)
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
      
    @match[matchNumString] = match
    @match[matchNumString].league_match_id = @league_match_id
    if not @match[matchNumString].original_id? or @match[matchNumString].original_id is 0
      DataService.saveMatch @match[matchNumString], (id) ->
        @match[matchNumString].original_id = id

  getMatchPointsByTeam: (team) ->
    if team == "home"
      homeScore = 0
      names = ['one', 'two', 'three', 'four', 'five']
    
      for name in names then do (name) =>
        if @match[name].player_one.team_number = @home_team.number
          homeScore += @match[name].getMatchPointsByPlayer(1)
        else
          homeScore += @match[name].getMatchPointsByPlayer(2)
      homeScore
      
    else if team == "away"
      awayScore = 0
      names = ['one', 'two', 'three', 'four', 'five']
    
      for name in names then do (name) =>
        if @match[name].player_one.team_number is @away_team.number
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
    return @away_team.number if @getMatchPointsByTeam('home') < @getMatchPointsByTeam('away')
    @home_team.number

  toJSON: ->
    return @toSmallJSON() if @small_json is true
    
    match_one:          @match['one'].toJSON()
    match_two:          @match['two'].toJSON()
    match_three:        @match['three'].toJSON()
    match_four:         @match['four'].toJSON()
    match_five:         @match['five'].toJSON()
    team_number:        @team_number
    home_team_number:   @home_team.number
    away_team_number:   @away_team.number
    start_time:         @start_time
    end_time:           @end_time
    table_type:         @table_type
    league_match_id:    @league_match_id

  fromJSON: (jsonLeagueMatch) ->
    matchOne = new $CS.Models.Match.Type.LeagueMatch('EightBall')
    matchTwo = new $CS.Models.Match.Type.LeagueMatch('EightBall')
    matchThree = new $CS.Models.Match.Type.LeagueMatch('EightBall')
    matchFour = new $CS.Models.Match.Type.LeagueMatch('EightBall')
    matchFive = new $CS.Models.Match.Type.LeagueMatch('EightBall')
    
    matchOne.fromJSON jsonLeagueMatch.match_one
    matchTwo.fromJSON jsonLeagueMatch.match_two
    matchThree.fromJSON jsonLeagueMatch.match_three
    matchFour.fromJSON jsonLeagueMatch.match_four
    matchFive.fromJSON jsonLeagueMatch.match_five
    
    @match['one']     = matchOne
    @match['two']     = matchTwo
    @match['three']   = matchThree
    @match['four']    = matchFour
    @match['five']    = matchFive
    
    @team_number      = jsonLeagueMatch.TeamNumber
    @home_team.number = jsonLeagueMatch.HomeTeamNumber
    @away_team.number = jsonLeagueMatch.AwayTeamNumber
    @start_time       = jsonLeagueMatch.StartTime
    @end_time         = jsonLeagueMatch.EndTime
    @table_type       = jsonLeagueMatch.TableType
    @league_match_id  = jsonLeagueMatch.LeagueMatchId
    
  toSmallJSON: ->
    team_number:      @team_number
    home_team_number: @home_team.number
    away_team_number: @away_team.number
    start_time:       @start_time
    end_time:         @end_time
    table_type:       @table_type
    league_match_id:  @league_match_id

  fromSmallJSON: (jsonLeagueMatch) ->
    @team_number      = jsonLeagueMatch.team_number
    @home_team.number = jsonLeagueMatch.home_team_number
    @away_team.number = jsonLeagueMatch.away_team_number
    @start_time       = jsonLeagueMatch.start_time
    @end_time         = jsonLeagueMatch.end_time
    @table_type       = jsonLeagueMatch.table_type
    @league_match_id  = jsonLeagueMatch.league_match_id

  ended: ->
    @match['one'].ended and @match['two'].ended and @match['three'].ended and @match['four'].ended and @match['five'].ended
  
$CS.Models.Match.Type.LeagueMatch = LeagueMatch
