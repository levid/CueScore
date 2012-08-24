class Player extends $CS.Models.NineBall
  defaults:
    name: null
    rank: null
    number: null
    teamNumber: null
    ballCount: null
    score: 0
    safeties: 0
    currentlyUp: false
    nineOnSnaps: 0
    breakAndRuns: 0
    timeoutsTaken: 0
    timeoutsAllowed: 0
    isCaptain: false
  
  constructor: (options) ->
    _.extend @, @defaults
      
    @name             = options.name        ?= null
    @rank             = options.rank        ?= null
    @number           = options.number      ?= null
    @teamNumber       = options.teamNumber  ?= null
    
    @ballCount        = new $CS.Models.NineBall.Ranks().getBallCount(@rank).toString()
    @timeoutsAllowed  = new $CS.Models.NineBall.Ranks().getTimeouts(@rank)
    
  resetPlayerRankStats: ->
    @ballCount        = new $CS.Models.NineBall.Ranks().getBallCount(@rank).toString()
    @timeoutsAllowed  = new $CS.Models.NineBall.Ranks().getTimeouts(@rank)

  addToScore: (addToScore) ->
    @score += addToScore

  addToSafeties: (num) ->
    @safeties += num

  hasWon: ->
    @score >= @ballCount

  addToNineOnSnaps: (num) ->
    @nineOnSnaps += num

  addToBreakAndRuns: (num) ->
    @breakAndRuns += num

  getRemainingBallCount: ->
    (@ballCount - @score).toString()

  getFirstNameWithInitials: ->
    spaceIndex = @name.indexOf(" ")
    return @name if spaceIndex is -1
    nameToReturn = @name.substr(0, spaceIndex)
    nameToReturn + " " + @name[spaceIndex + 1] + "."

  getSafeties: ->
    @safeties.toString()

  getScore: ->
    @score.toString()

  getRatioScore: ->
    @score / @ballCount

  getNineOnSnaps: ->
    @nineOnSnaps.toString()

  getBreakAndRuns: ->
    @breakAndRuns.toString()

  toJSON: ->
    name:         @name
    rank:         @rank
    ballCount:    @ballCount
    number:       @number
    teamNumber:   @teamNumber
    score:        @score
    safeties:     @safeties
    nineOnSnaps:  @nineOnSnaps
    breakAndRuns: @breakAndRuns
    currentlyUp:  @currentlyUp

  fromJSON: (playerJSON) ->
    @name         = playerJSON.name
    @rank         = playerJSON.rank
    @ballCount    = playerJSON.ballCount
    @number       = playerJSON.number
    @teamNumber   = playerJSON.teamNumber
    @score        = playerJSON.score
    @safeties     = playerJSON.safeties
    @nineOnSnaps  = playerJSON.nineOnSnaps
    @breakAndRuns = playerJSON.breakAndRuns
    @currentlyUp  = playerJSON.currentlyUp
    @resetPlayerRankStats()

$CS.Models.NineBall.Player = Player
