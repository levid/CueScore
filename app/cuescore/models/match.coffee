class Match extends Backbone.Model
  defaults: {}

  initialize: ->
    _.extend @, @defaults

$CS.Models.Match = Match