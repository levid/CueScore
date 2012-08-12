class League extends $CS.Models.EightBall
  defaults: {}

  constructor: (options = {}) ->
    _.extend @, @defaults

$CS.Models.EightBall.League = League