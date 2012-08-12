class PracticeMatch extends $CS.Models.EightBall
  defaults: {}

  constructor: () ->
    _.extend @, @defaults
    console.log this

$CS.Models.EightBall.PracticeMatch = PracticeMatch
