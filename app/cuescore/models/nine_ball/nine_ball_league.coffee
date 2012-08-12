class League extends $CS.Models.NineBall
  defaults: {}

  constructor: (options = {}) ->
    _.extend @, @defaults

$CS.Models.NineBall.League = League