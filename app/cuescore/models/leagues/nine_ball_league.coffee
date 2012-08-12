class NineBall extends $CS.Models.League
  defaults: {}

  initialize: (options = {}) ->
    _.extend @, @defaults

$CS.Models.League.NineBall = NineBall