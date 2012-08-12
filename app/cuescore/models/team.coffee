class Team extends Backbone.Model
  defaults: {}

  constructor: ->
    _.extend @, @defaults

$CS.Models.Team = Team