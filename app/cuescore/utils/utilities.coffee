class Utilities
  defaults: {}

  constructor: (options = {}) ->
    _.extend @, @defaults
    
    Array::exists = (search) ->
    i = 0
  
    while i < @length
      return true  if this[i] is search
      i++
    false

  getScoreRatio = (playerScore, playerBallCount) ->
    playerScore / playerBallCount
    
  getPlatformWidth: ->
    Ti.Platform.displayCaps.platformWidth
  
  getPlatformHeight: ->
    Ti.Platform.displayCaps.platformHeight - 22

$CS.Utilities = new Utilities
  