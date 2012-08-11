describe("Game", function() {
  var game;

  beforeEach(function() {
	game = new $CS.Models.Game;
  });

  it("should be able to create a new Game", function() {
    game.initialize();
    expect(game).not.toBeUndefined();
  });
  
  it("should contain attributes", function() {
  	var attributes = game.attributes;
  	expect(attributes.name).toBeDefined();
  	expect(attributes.age).toBeDefined();
  	expect(attributes.children).toBeDefined();
  	
  	expect(attributes.name).toEqual("Fetus");
  	expect(attributes.age).toEqual(0);
  	expect(attributes.children).toEqual([]);
  });
});