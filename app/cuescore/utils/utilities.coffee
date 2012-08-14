class Utilities
  defaults: {}

  constructor: (options = {}) ->
    _.extend @, @defaults

  getPlatformWidth: ->
    Ti.Platform.displayCaps.platformWidth
  
  getPlatformHeight: ->
    Ti.Platform.displayCaps.platformHeight - 22

$CS.Utilities = new Utilities
  