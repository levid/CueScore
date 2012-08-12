describe "Eight Ball Match", ->
  match = undefined
  
  beforeEach ->
    match = new $CS.Models.EightBall.Match(
      options = 
        playerOneName: "Player1"
        playerTwoName: "Player2"
        playerOneRank: 2
        playerTwoRank: 7
        playerOneNumber: "12345"
        playerTwoNumber: "987654"
        playerOneTeamNumber: "123"
        playerTwoTeamNumber: "456"
    )
    match.player.one.currently_up = true

  describe "Constructor", ->
    it "should have 2 players", ->
      expect(match.player.one.name).toEqual "Player1"
      expect(match.player.one.rank).toEqual 2
      expect(match.player.one.number).toEqual "12345"
      expect(match.player.one.team_number).toEqual "123"
      expect(match.player.one.games_needed_to_win).toEqual 2
      expect(match.player.two.name).toEqual "Player2"
      expect(match.player.two.rank).toEqual 7
      expect(match.player.two.number).toEqual "987654"
      expect(match.player.two.team_number).toEqual "456"
      expect(match.player.two.games_needed_to_win).toEqual 7

    it "should set Player 1 to break first", ->
      expect(match.player.one.currently_up).toEqual true

    it "should create the first Game and set it to current_game", ->
      expect(match.current_game).toNotEqual null


  describe "Scoring", ->
    it "should accept a number for the ball that was hit in", ->
      match.scoreNumberedBall 1

    it "should add 1 to the respective ball type array when a ball is scored", ->
      match.scoreNumberedBall 1
      expect(match.current_game.balls_hit_in.solids).toEqual [1]
      match.scoreNumberedBall 12
      expect(match.current_game.balls_hit_in.stripes).toEqual [12]


  describe "Match/Game Ending", ->
    it "should know when the match is completed", ->
      expect(match.getRemainingGamesNeededToWinByPlayer(1)).toEqual 2
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      expect(match.getRemainingGamesNeededToWinByPlayer(1)).toEqual 1
      expect(match.current_game.ended).toEqual true
      expect(match.current_game.player.one.has_won).toEqual true
      expect(match.ended).toEqual false
      match.startNewGame()
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      expect(match.getRemainingGamesNeededToWinByPlayer(1)).toEqual 0
      expect(match.ended).toEqual true

    it "should be able to find the remaining games needed to win for player one", ->
      expect(match.getRemainingGamesNeededToWinByPlayer(1)).toEqual 2
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      expect(match.getRemainingGamesNeededToWinByPlayer(1)).toEqual 1

    it "should be able to find the remaining games needed to win for player two", ->
      expect(match.getRemainingGamesNeededToWinByPlayer(2)).toEqual 7
      match.shotMissed()
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.current_game.setBallTypeByPlayer(2, 'stripes')
      expect(match.current_game.player.two.has_won).toEqual true
      expect(match.getRemainingGamesNeededToWinByPlayer(2)).toEqual 6

    it "should add current game to the completed_games list and start a new Game when the game has completed", ->
      expect(match.completed_games.length).toEqual 0
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.startNewGame()
      expect(match.completed_games.length).toEqual 1
      expect(match.current_game.ended).toEqual false
      expect(match.completed_games[0].ended).toEqual true

    it "should know if the match is completed", ->
      expect(match.ended).toEqual false

    it "should hold multiple completed games", ->
      expect(match.completed_games).toNotEqual null


  describe "Players", ->
    it "should be able to have the rank changed and have the BallCounts and timeouts_allowed automatically", ->
      expect(match.player.one.games_needed_to_win).toEqual 2 #Opponent is a 7
      expect(match.player.two.games_needed_to_win).toEqual 7 #Opponent is a 2
      expect(match.player.one.timeouts_allowed).toEqual 2
      match.player.one.rank = 7
      match.resetPlayerRankStats()
      expect(match.player.one.games_needed_to_win).toEqual 5 #Opponent is a 7
      expect(match.player.one.timeouts_allowed).toEqual 1
      expect(match.player.two.games_needed_to_win).toEqual 5 #Opponent is a 7

    it "should change currently up player on missed shot", ->
      expect(match.player.one.currently_up).toEqual true
      match.shotMissed()
      expect(match.player.two.currently_up).toEqual true

    it "should be able to get the player twos games won", ->
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.getGamesWonByPlayer(2)).toEqual 0
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 9
      match.scoreNumberedBall 10
      match.scoreNumberedBall 11
      match.scoreNumberedBall 12
      match.scoreNumberedBall 13
      match.scoreNumberedBall 14
      match.scoreNumberedBall 15
      match.scoreNumberedBall 8
      expect(match.getGamesWonByPlayer(2)).toEqual 1
      match.startNewGame()
      expect(match.getGamesWonByPlayer(2)).toEqual 1
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      expect(match.getGamesWonByPlayer(2)).toEqual 2

    it "should be able to get the the games won. (example 2-0)", ->
      expect(match.getMatchPoints()).toEqual "TIE"
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.getMatchPoints()).toEqual "TIE"
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 9
      match.scoreNumberedBall 10
      match.scoreNumberedBall 11
      match.scoreNumberedBall 12
      match.scoreNumberedBall 13
      match.scoreNumberedBall 14
      match.scoreNumberedBall 15
      match.scoreNumberedBall 8
      match.startNewGame()
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.scoreNumberedBall 9
      match.startNewGame()
      match.scoreNumberedBall 1
      expect(match.getMatchPoints()).toEqual "0-1"


  it "should be able to get the winning player", ->
    match.scoreNumberedBall 1
    match.scoreNumberedBall 2
    match.scoreNumberedBall 3
    match.scoreNumberedBall 4
    match.scoreNumberedBall 5
    match.scoreNumberedBall 6
    match.scoreNumberedBall 7
    match.scoreNumberedBall 8
    match.startNewGame()
    expect(match.getWinningPlayer().name).toEqual "Player1"

  it "should be able to return playerones match points", ->
    expect(match.getMatchPointsByPlayer(1)).toEqual 0
    match.scoreNumberedBall 8
    expect(match.getMatchPointsByPlayer(1)).toEqual 1

  it "should be able to return playertwos match points", ->
    expect(match.getMatchPointsByPlayer(2)).toEqual 0
    match.shotMissed()
    match.scoreNumberedBall 8
    match.startNewGame()
    match.scoreNumberedBall 8
    match.startNewGame()
    match.scoreNumberedBall 8
    match.startNewGame()
    match.scoreNumberedBall 8
    match.startNewGame()
    match.scoreNumberedBall 8
    expect(match.getMatchPointsByPlayer(2)).toEqual 1

  it "should be able to get the total number of innings", ->
    expect(match.getTotalInnings()).toEqual 0
    match.shotMissed()
    match.shotMissed()
    match.shotMissed()
    match.shotMissed()
    expect(match.getTotalInnings()).toEqual 2
    match.shotMissed()
    match.shotMissed()
    expect(match.getTotalInnings()).toEqual 3

  it "should be able to hold on to the original_id from the database", ->
    expect(match.original_id).toEqual 0

  it "should be able to hold on to the league_match_id from the database", ->
    expect(match.league_match_id).toEqual 0

  it "should be able to know when the last thing that happened was a player switch", ->
    expect(match.ArePlayersSwitching).toEqual false
    match.shotMissed()
    expect(match.ArePlayersSwitching).toEqual true
    match.scoreNumberedBall 1
    expect(match.ArePlayersSwitching).toEqual false

  it "should be able to put match into sudden death mode", ->
    expect(match.sudden_death).toEqual false
    expect(match.player.one.games_needed_to_win).toEqual 2
    expect(match.player.two.games_needed_to_win).toEqual 7
    match.setSuddenDeathMode()
    expect(match.sudden_death).toEqual true
    expect(match.player.one.games_needed_to_win).toEqual 1
    expect(match.player.two.games_needed_to_win).toEqual 1

  it "should switch players if eight ball is hit in without all other 7 balls", ->
    match.shotMissed()
    expect(match.player.two.currently_up).toEqual true
    expect(match.player.one.currently_up).toEqual false
    match.scoreNumberedBall 8
    expect(match.player.one.currently_up).toEqual true
    expect(match.player.two.currently_up).toEqual false

  it "should be able to know the current game number", ->
    expect(match.getCurrentGameNumber()).toEqual 1
    match.scoreNumberedBall 1
    match.scoreNumberedBall 2
    match.scoreNumberedBall 3
    match.scoreNumberedBall 4
    match.scoreNumberedBall 5
    match.scoreNumberedBall 6
    match.scoreNumberedBall 7
    match.scoreNumberedBall 8
    match.startNewGame()
    expect(match.getCurrentGameNumber()).toEqual 2

  it "should be able to get total number of safeties", ->
    expect(match.getTotalSafeties()).toEqual "0 to 0"

  it "should be able to hit a safety", ->
    expect(match.getTotalSafeties()).toEqual "0 to 0"
    match.hitSafety()
    expect(match.getTotalSafeties()).toEqual "1 to 0"
    expect(match.player.one.safeties).toEqual 1
    match.shotMissed()
    match.hitSafety()
    expect(match.getTotalSafeties()).toEqual "2 to 0"
    expect(match.player.two.safeties).toEqual 0
    match.hitSafety()
    expect(match.getTotalSafeties()).toEqual "2 to 1"
    expect(match.player.two.safeties).toEqual 1

  it "should reset Timeouts taken for each player when a game has ended", ->
    expect(match.current_game.player.one.timeouts_taken).toEqual 0
    expect(match.current_game.player.two.timeouts_taken).toEqual 0
    match.current_game.takeTimeout()
    expect(match.current_game.player.one.timeouts_taken).toEqual 1
    match.shotMissed()
    match.current_game.takeTimeout()
    expect(match.current_game.player.two.timeouts_taken).toEqual 1
    match.scoreNumberedBall 8
    match.startNewGame()
    expect(match.current_game.player.one.timeouts_taken).toEqual 0
    expect(match.current_game.player.two.timeouts_taken).toEqual 0

  it "should be able to tell who won the entire match", ->
    expect(match.player.one.has_won).toEqual false
    expect(match.player.two.has_won).toEqual false
    match.scoreNumberedBall 8
    match.startNewGame()
    match.scoreNumberedBall 8
    expect(match.getRemainingGamesNeededToWinByPlayer(1)).toEqual "0"
    expect(match.player.one.has_won).toEqual true

  describe "toJSON/fromJSON", ->
    it "should be able to take a new Match and turn it into a JSON object", ->
      console.log match
      expect(match.toJSON()).toEqual
        player_one:
          name: "Player1"
          rank: 2
          games_needed_to_win: 2
          number: "12345"
          team_number: "123"
          games_won: 0
          safeties: 0
          eight_on_snaps: 0
          break_and_runs: 0
          currently_up: true

        player_two:
          name: "Player2"
          rank: 7
          games_needed_to_win: 7
          number: "987654"
          team_number: "456"
          games_won: 0
          safeties: 0
          eight_on_snaps: 0
          break_and_runs: 0
          currently_up: false

        player_one_games_won: 0
        player_two_games_won: 0
        current_game:
          player_one_timeouts_taken: 0
          player_two_timeouts_taken: 0
          number_of_innings: 0
          player_one_eight_on_snap: false
          player_one_break_and_run: false
          player_two_eight_on_snap: false
          player_two_break_and_run: false
          player_one_ball_type: null
          player_two_ball_type: null
          player_one_eight_ball: []
          player_two_eight_ball: []
          player_one_won: false
          player_two_won: false
          ended: false
          striped_balls_hit_in: [12, 9, 10, 11, 13, 14, 15]
          solid_balls_hit_in: [1, 2, 3, 4, 5, 6, 7]
          last_ball_hit_in: null
          on_break: true
          breaking_player_still_shooting: true

        completed_games: [
          player_one_timeouts_taken: 2
          player_two_timeouts_taken: 0
          player_one_eight_on_snap: false
          player_one_break_and_run: true
          player_two_eight_on_snap: false
          player_two_break_and_run: false
          player_one_ball_type: 2
          player_two_ball_type: 1
          player_one_eight_ball: [ 8 ]
          player_two_eight_ball: [  ]
          player_one_won: true
          player_two_won: false
          number_of_innings: 0
          early_eight: false
          scratch_on_eight: false
          breaking_player_still_shooting: true
          striped_balls_hit_in: [ 12, 9, 10, 11, 13, 14, 15 ]
          solid_balls_hit_in: [ 1, 2, 3, 4, 5, 6, 7 ]
          last_ball_hit_in: 8 
          on_break: true
          ended: true 
        ]
        ended: false
        original_id: 0
        league_match_id: 0


    it "should be able to take a filled Match and turn it into a JSON object", ->
      match.scoreNumberedBall 1
      match.shotMissed()
      match.scoreNumberedBall 12
      match.shotMissed()
      match.scoreNumberedBall 8
      match.startNewGame()
      expect(match.toJSON()).toEqual
        player_one:
          name: "Player1"
          rank: 2
          games_needed_to_win: 2
          number: "12345"
          team_number: "123"
          games_won: 0
          safeties: 0
          eight_on_snaps: 0
          break_and_runs: 0
          currently_up: true

        player_two:
          name: "Player2"
          rank: 7
          games_needed_to_win: 7
          number: "987654"
          team_number: "456"
          games_won: 0
          safeties: 0
          eight_on_snaps: 0
          break_and_runs: 0
          currently_up: false

        player_one_games_won: 1
        player_two_games_won: 0
        current_game:
          player_one_timeouts_taken: 0
          player_two_timeouts_taken: 0
          number_of_innings: 0
          player_one_eight_on_snap: false
          player_one_break_and_run: false
          player_two_eight_on_snap: false
          player_two_break_and_run: false
          player_one_ball_type: null
          player_two_ball_type: null
          player_one_eight_ball: []
          player_two_eight_ball: []
          player_one_won: false
          player_two_won: false
          ended: false
          striped_balls_hit_in: []
          solid_balls_hit_in: []
          last_ball_hit_in: null
          on_break: true
          breaking_player_still_shooting: true

        completed_games: [        
          player_one_timeouts_taken: 0
          player_two_timeouts_taken: 0
          number_of_innings: 0
          player_one_eight_on_snap: false
          player_one_break_and_run: false
          player_two_eight_on_snap: false
          player_two_break_and_run: false
          player_one_ball_type: 2
          player_two_ball_type: 1
          player_one_eight_ball: []
          player_two_eight_ball: [8]
          player_one_won: true
          player_two_won: false
          ended: true
          striped_balls_hit_in: [12]
          solid_balls_hit_in: [1]
          last_ball_hit_in: 8
          on_break: false
          breaking_player_still_shooting: false
        ]
        ended: false
        original_id: 0
        league_match_id: 0


    it "should be able to put a matches completed games into a JSON object", ->
      match.scoreNumberedBall 1
      match.shotMissed() #Ending breaking
      match.scoreNumberedBall 15
      match.shotMissed()
      match.scoreNumberedBall 8
      match.startNewGame()
      expect(match.completedGamesToJSON()).toEqual [
        player_one_timeouts_taken: 0
        player_two_timeouts_taken: 0
        number_of_innings: 0
        player_one_eight_on_snap: false
        player_one_break_and_run: false
        player_two_eight_on_snap: false
        player_two_break_and_run: false
        player_one_ball_type: 2
        player_two_ball_type: 1
        player_one_eight_ball: []
        player_two_eight_ball: [8]
        player_one_won: true
        player_two_won: false
        ended: true
        striped_balls_hit_in: [15]
        solid_balls_hit_in: [1]
        last_ball_hit_in: 8
        on_break: false
        breaking_player_still_shooting: false
      ]

    it "should be able to take a Player JSON and fill a Player object and return it", ->
      player = match.playerFromJSON(
        name: "James Armstead"
        rank: 2
        games_needed_to_win: 0
        number: "4321"
        team_number: "789"
        games_won: 1
        safeties: 1
        eight_on_snaps: 2
        break_and_runs: 3
        currently_up: true
      )
      expect(player.name).toEqual "James Armstead"
      expect(player.rank).toEqual 2
      expect(player.number).toEqual "4321"
      expect(player.team_number).toEqual "789"
      expect(player.games_won).toEqual 1
      expect(player.safeties).toEqual 1
      expect(player.eight_on_snaps).toEqual 2
      expect(player.break_and_runs).toEqual 3
      expect(player.currently_up).toEqual true
      player.addOneToEightOnSnaps()
      expect(player.eight_on_snaps).toEqual 3

    it "should be able to take a Match JSON and fill its values", ->
      match.fromJSON
        player_one:
          name: "Player1"
          rank: 2
          number: "12345"
          team_number: "123"
          games_won: 0
          safeties: 0
          eight_on_snaps: 0
          break_and_runs: 0
          currently_up: true

        player_two:
          name: "Player2"
          rank: 7
          number: "987654"
          team_number: "456"
          games_won: 0
          safeties: 0
          eight_on_snaps: 0
          break_and_runs: 0
          currently_up: false

        player_one_games_won: 0
        player_two_games_won: 1
        
        current_game:
          player_one_timeouts_taken: 0
          player_two_timeouts_taken: 0
          number_of_innings: 0
          player_one_eight_on_snap: false
          player_one_break_and_run: false
          player_two_eight_on_snap: false
          player_two_break_and_run: false
          player_one_ball_type: null
          player_two_ball_type: null
          player_one_eight_ball: []
          player_two_eight_ball: []
          player_one_won: false
          player_two_won: false
          ended: false
          striped_balls_hit_in: []
          solid_balls_hit_in: []
          last_ball_hit_in: null
          on_break: true
          breaking_player_still_shooting: true

        completed_games: [        
          player_one_timeouts_taken: 0
          player_two_timeouts_taken: 0
          number_of_innings: 0
          player_one_eight_on_snap: false
          player_one_break_and_run: false
          player_two_eight_on_snap: false
          player_two_break_and_run: false
          player_one_ball_type: 2
          player_two_ball_type: 1
          player_one_eight_ball: []
          player_two_eight_ball: [8]
          player_one_won: true
          player_two_won: false
          ended: true
          striped_balls_hit_in: [12]
          solid_balls_hit_in: [1]
          last_ball_hit_in: 8
          on_break: false
          breaking_player_still_shooting: false
        ]
        ended: false
        original_id: 0
        league_match_id: 0

      expect(match.getGamesWonByPlayer(1)).toEqual 0
      expect(match.getGamesWonByPlayer(2)).toEqual 1
      expect(match.ended).toEqual false
      expect(match.original_id).toEqual 0
      expect(match.player.one.name).toEqual "Player1"
      expect(match.player.two.name).toEqual "Player2"
      expect(match.current_game.breaking_player_still_shooting).toEqual true
      expect(match.completed_games[0].breaking_player_still_shooting).toEqual false
      expect(match.completed_games[0].player.two.has_won).toEqual true
      expect(match.player.one.getGamesNeededToWin()).toEqual "2"

    it "should be able to take a completed_games JSON array and convert it to JS Array with Objects", ->
      completed_games = match.completedGamesFromJSON([
        player_one_timeouts_taken: 0
        player_two_timeouts_taken: 0
        number_of_innings: 0
        player_one_eight_on_snap: false
        player_one_break_and_run: false
        player_two_eight_on_snap: false
        player_two_break_and_run: false
        player_one_ball_type: 1
        player_two_ball_type: null
        player_one_eight_ball: []
        player_two_eight_ball: [8]
        player_one_won: true
        player_two_won: false
        ended: true
        striped_balls_hit_in: [1]
        solid_balls_hit_in: [12]
        last_ball_hit_in: 12
        on_break: false
        breaking_player_still_shooting: false
      ])
      
      expect(completed_games[0].getBallsHitInByPlayer(1)).toEqual [1]
      expect(completed_games[0].player.one.has_won).toEqual true
