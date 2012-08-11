class EightBall extends $CS.Models.Player
  defaults:
    name: null
    rank: null
    number: null
    team_number: null
    games_won: 0
    safeties: 0
    currently_up: false
    eight_on_snaps: 0
    break_and_runs: 0
    timeouts_allowed: null
    games_needed_to_win: 0
    is_captain: false

  initialize: (name, rank, number, teamNumber) ->
    @name             = name?
    @rank             = rank?
    @number           = number?
    @team_number      = teamNumber?
    @timeouts_allowed = $CS.Models.Rank.EightBall().getTimeouts(rank?)
    
  # Getters
  
  getGamesNeededToWin: ->
    @games_needed_to_win.toString()
    
  getRemainingBallCount: ->
    (@ball_count - @score).toString()

  getFirstNameWithInitials: ->
    spaceIndex = @name.indexOf(" ")
    return @name if spaceIndex is -1
    nameToReturn = @name.substr(0, spaceIndex)
    nameToReturn + " " + @name[spaceIndex + 1] + "."

  getSafeties: ->
    @safeties.toString()

  getGamesWon: ->
    @games_won.toString()

  getRatioScore: ->
    @score / @ball_count

  getEightOnSnaps: ->
    @eight_on_snaps.toString()

  getBreakAndRuns: ->
    @break_and_runs.toString()
    
  # Setters

  resetPlayerRankStats: ->
    @timeouts_allowed = $CS.Models.Rank.EightBall().getTimeouts(@rank)

  addOneToGamesWon: ->
    @games_won += 1

  addOneToSafeties: ->
    @safeties += 1

  hasWon: ->
    @score >= @ball_count

  addOneToEightOnSnaps: ->
    @eight_on_snaps += 1

  addOneToBreakAndRuns: ->
    @break_and_runs += 1
    
  # JSON Data

  toJSON: ->
    name:                 @name
    rank:                 @rank
    games_needed_to_win:  @games_needed_to_win
    number:               @number
    team_number:          @team_number
    games_won:            @games_won
    safeties:             @safeties
    eight_on_snaps:       @eight_on_snaps
    break_and_runs:       @break_and_runs
    currently_up:         @currently_up

  fromJSON: (playerJSON) ->
    @name                 = playerJSON.name
    @tank                 = playerJSON.rank
    @number               = playerJSON.number
    @team_number          = playerJSON.team_number
    @games_won            = playerJSON.games_won
    @safeties             = playerJSON.safeties
    @eight_on_snaps       = playerJSON.eight_on_snaps
    @break_and_runs       = playerJSON.break_and_runs
    @currently_up         = playerJSON.currently_up
    @resetPlayerRankStats()

$CS.Models.Player.EightBall = EightBall
