describe "Game", ->
  game = undefined
  attributes = undefined
  
  beforeEach ->
    game = new $CS.Models.Game()
    attributes = game.attributes

  describe "Constructor", ->
    it "should be able to create a new Game", ->
      game.initialize()
      expect(game).not.toBeUndefined()

    it "should contain default attributes", ->
      expect(attributes.name).toBeDefined()
      expect(attributes.age).toBeDefined()
      expect(attributes.children).toBeDefined()
      expect(attributes.name).toEqual "Fetus"
      expect(attributes.age).toEqual 0
      expect(attributes.children).toEqual []

    it "should store the parameters", ->
      game = new $CS.Models.Game(
        options =
          name: "Isaac Wooten"
          age: 1
          children: []
      )
      
      attributes = game.attributes
      expect(attributes.name).toEqual "Isaac Wooten"
      expect(attributes.age).toEqual 1
      expect(attributes.children).toEqual []


