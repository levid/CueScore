class NineBall extends $CS.Models.Player
  defaults: {}
  
  initialize: (name, rank, number, teamNumber) ->
    _.extend @, @defaults
    console.log this

$CS.Models.Player.NineBall = NineBall
