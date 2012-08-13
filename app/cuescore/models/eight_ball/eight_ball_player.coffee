class Player extends $CS.Models.EightBall
  defaults:
    name: null
    rank: null
    number: null
    teamNumber: null
    gamesWon: 0
    safeties: 0
    currentlyUp: false
    eightOnSnaps: 0
    breakAndRuns: 0
    timeouts_allowed: null
    gamesNeededToWin: 0
    isCaptain: false

  constructor: (options) ->
    _.extend @, @defaults
    
    @name             = options.name ?= null
    @rank             = options.rank ?= null
    @number           = options.playerNumber ?= null
    @teamNumber      = options.teamNumber ?= null
    
    @timeouts_allowed = new $CS.Models.EightBall.Ranks().getTimeouts(@rank)
    
  # Getters
  
  getGamesNeededToWin: ->
    @gamesNeededToWin.toString()

  getFirstNameWithInitials: ->
    spaceIndex = @name.indexOf(" ")
    return @name if spaceIndex is -1
    nameToReturn = @name.substr(0, spaceIndex)
    nameToReturn + " " + @name[spaceIndex + 1] + "."

  getSafeties: ->
    @safeties

  getGamesWon: ->
    @gamesWon.toString()

  getEightOnSnaps: ->
    @eightOnSnaps.toString()

  getBreakAndRuns: ->
    @breakAndRuns.toString()
    
  # Setters

  resetPlayerRankStats: ->
    @timeouts_allowed = new $CS.Models.EightBall.Ranks().getTimeouts(@rank)

  addToGamesWon: (num) ->
    @gamesWon += num

  addToSafeties: (num) ->
    @safeties += num

  addToEightOnSnaps: (num) ->
    @eightOnSnaps += num

  addToBreakAndRuns: (num) ->
    @breakAndRuns += num
    
  # JSON Data

  toJSON: ->
    name:                 @name
    rank:                 @rank
    gamesNeededToWin:     @gamesNeededToWin
    number:               @number
    teamNumber:           @teamNumber
    gamesWon:             @gamesWon
    safeties:             @safeties
    eightOnSnaps:         @eightOnSnaps
    breakAndRuns:         @breakAndRuns
    currentlyUp:          @currentlyUp

  fromJSON: (playerJSON) ->
    @name                 = playerJSON.name
    @rank                 = playerJSON.rank
    @number               = playerJSON.number
    @teamNumber           = playerJSON.teamNumber
    @gamesWon             = playerJSON.gamesWon
    @safeties             = playerJSON.safeties
    @eightOnSnaps         = playerJSON.eightOnSnaps
    @breakAndRuns         = playerJSON.breakAndRuns
    @currentlyUp          = playerJSON.currentlyUp
    @resetPlayerRankStats()

$CS.Models.EightBall.Player = Player
