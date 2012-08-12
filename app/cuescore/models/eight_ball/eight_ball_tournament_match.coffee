class TournamentMatch extends $CS.Models.EightBall
  defaults: {}

  constructor: () ->
    _.extend @, @defaults
    console.log this

$CS.Models.EightBall.TournamentMatch = TournamentMatch
