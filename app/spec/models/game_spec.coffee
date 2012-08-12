describe "Game", ->
  model = undefined
  
  beforeEach ->
    model = new $CS.Models.Game(
      options =
        name: "Isaac Wooten"
        age: 1
        children: []
    )

  describe "Constructor", ->
    it "should be able to create a new Game", ->
      expect(model).not.toBeUndefined()

    it "should contain default attributes", ->
      expect(model.name).toBeDefined()
      expect(model.age).toBeDefined()
      expect(model.children).toBeDefined()
      
      expect(model.name).toEqual "Isaac Wooten"
      expect(model.age).toEqual 1
      expect(model.children).toEqual []

    it "should store the parameters", ->
      model = new $CS.Models.Game(
        options =
          name: "Isaac Wooten"
          age: 1
          children: []
      )
      
      attributes = model.attributes
      expect(model.name).toEqual "Isaac Wooten"
      expect(model.age).toEqual 1
      expect(model.children).toEqual []

