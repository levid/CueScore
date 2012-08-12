class Masters extends $CS.Models.League
  defaults: {}

  initialize: (options = {}) ->
    _.extend @, @defaults

$CS.Models.League.Masters = Masters