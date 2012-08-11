class TournamentMatch extends $CS.Models.Match.Type
  defaults: {}

  initialize: () ->
    _.extend @, @defaults
    console.log this

$CS.Models.Match.Type.TournamentMatch = TournamentMatch
