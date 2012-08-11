describe "League", ->
  model = undefined
  attributes = undefined
  
  beforeEach ->
    model = new $CS.Models.League()
    attributes = model.attributes

  describe "Constructor", ->
    it "should be able to create a new League", ->
      model.initialize()
      expect(model).not.toBeUndefined()

    it "should contain default attributes", ->
      expect(attributes.name).toBeDefined()
      expect(attributes.age).toBeDefined()
      expect(attributes.children).toBeDefined()
      expect(attributes.name).toEqual "Fetus"
      expect(attributes.age).toEqual 0
      expect(attributes.children).toEqual []

    it "should store the parameters", ->
      model = new $CS.Models.League(
        options =
          name: "Isaac Wooten"
          age: 1
          children: []
      )
      
      attributes = model.attributes
      expect(attributes.name).toEqual "Isaac Wooten"
      expect(attributes.age).toEqual 1
      expect(attributes.children).toEqual []

