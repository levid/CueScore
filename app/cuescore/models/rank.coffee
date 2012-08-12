class Rank extends Backbone.Model
  defaults: {}

  constructor: ->
    _.extend @, @defaults
    
$CS.Models.Rank = Rank