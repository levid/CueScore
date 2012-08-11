class League extends Backbone.Model
  defaults:
    name: "Fetus"
    age: 0
    children: []

  initialize: (options = {}) ->
    @name      = options.name
    @age       = options.age
    @children  = options.children
    
    console.log this.attributes
    
    @bind "change:name", ->
      name = @get("name") # 'Stewie Griffin'
      console.log "Changed my name to " + name

  replaceNameAttr: (name) ->
    @set name: name

# player = new Player(
  # name: "Thomas"
  # age: 67
  # children: ["Ryan"]
# )
# 
# player.replaceNameAttr "Stewie Griffin" # This triggers a change and will alert()

$CS.Models.League = League