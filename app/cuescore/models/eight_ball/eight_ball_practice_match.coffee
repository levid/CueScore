class PracticeMatch extends $CS.Models.EightBall
  defaults: {}

  constructor: () ->
    _.extend @, @defaults

$CS.Models.EightBall.PracticeMatch = PracticeMatch
