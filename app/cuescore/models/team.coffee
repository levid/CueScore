class Team extends Backbone.Model
  defaults: {}

  initialize: ->
    _.extend @, @defaults

$CS.Models.Team = Team