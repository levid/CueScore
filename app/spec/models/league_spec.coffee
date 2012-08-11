describe "League", ->
  league = undefined
  attributes = undefined
  
  beforeEach ->
    league = new $CS.Models.League()
    attributes = league.attributes

  describe "Constructor", ->
    it "should be able to create a new League", ->
      league.initialize()
      expect(league).not.toBeUndefined()

    it "should contain default attributes", ->
      expect(attributes.name).toBeDefined()
      expect(attributes.age).toBeDefined()
      expect(attributes.children).toBeDefined()
      expect(attributes.name).toEqual "Fetus"
      expect(attributes.age).toEqual 0
      expect(attributes.children).toEqual []

    it "should store the parameters", ->
      league = new $CS.Models.League(
        options =
          name: "Isaac Wooten"
          age: 1
          children: []
      )
      
      attributes = league.attributes
      expect(attributes.name).toEqual "Isaac Wooten"
      expect(attributes.age).toEqual 1
      expect(attributes.children).toEqual []

