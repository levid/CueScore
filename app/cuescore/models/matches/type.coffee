class Type extends $CS.Models.Match
  defaults: {}

  initialize: () ->
    _.extend @, @defaults
    console.log this
  
$CS.Models.Match.Type = Type
