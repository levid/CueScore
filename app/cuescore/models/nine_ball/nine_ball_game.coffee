class Game extends $CS.Models.NineBall
  defaults: {}
  
  constructor: (addToPlayerOne, addToPlayerTwo, callback) ->
    _.extend @, @defaults
    console.log this

$CS.Models.NineBall.Game = Game
