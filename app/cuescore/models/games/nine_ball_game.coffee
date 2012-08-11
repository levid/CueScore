class NineBall extends $CS.Models.Game
  defaults: {}
  
  initialize: (addToPlayerOne, addToPlayerTwo, callback) ->
    _.extend @, @defaults
    console.log this

$CS.Models.Game.NineBall = NineBall
