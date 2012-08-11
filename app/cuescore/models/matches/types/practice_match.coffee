class PracticeMatch extends $CS.Models.Match.Type
  defaults: {}

  initialize: () ->
    _.extend @, @defaults
    console.log this

$CS.Models.Match.Type.PracticeMatch = PracticeMatch
