class Rank extends Backbone.Model
  defaults: {}

  initialize: ->
    _.extend @, @defaults
$CS.Models.Rank = Rank