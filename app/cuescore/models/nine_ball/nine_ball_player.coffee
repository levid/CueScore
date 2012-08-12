class Player extends $CS.Models.NineBall
  defaults: {}
  
  constructor: (name, rank, number, teamNumber) ->
    _.extend @, @defaults
    console.log this

$CS.Models.NineBall.Player = Player
