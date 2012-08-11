class TournamentMatch extends $CS.Models.Match.Type
  defaults: {}

  initialize: () ->
    console.log this

$CS.Models.Match.Type.TournamentMatch = TournamentMatch
