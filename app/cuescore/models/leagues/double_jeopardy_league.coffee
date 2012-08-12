class DoubleJeopardy extends $CS.Models.League
  defaults: {}

  initialize: (options = {}) ->
    _.extend @, @defaults

$CS.Models.League.DoubleJeopardy = DoubleJeopardy