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
    match.player.one.currentlyUp = true

  describe "Constructor", ->
    it "should have 2 players", ->
      expect(match.player.one.name).toEqual "Player1"
      expect(match.player.one.rank).toEqual 2
      expect(match.player.one.number).toEqual "12345"
      expect(match.player.one.teamNumber).toEqual "123"
      expect(match.player.one.gamesNeededToWin).toEqual 2
      expect(match.player.two.name).toEqual "Player2"
      expect(match.player.two.rank).toEqual 7
      expect(match.player.two.number).toEqual "987654"
      expect(match.player.two.teamNumber).toEqual "456"
      expect(match.player.two.gamesNeededToWin).toEqual 7

    it "should set Player 1 to break first", ->
      expect(match.player.one.currentlyUp).toEqual true

    it "should create the first Game and set it to current_game", ->
      expect(match.current_game).toNotEqual null


  describe "Scoring", ->
    it "should accept a number for the ball that was hit in", ->
      match.scoreNumberedBall 1

    it "should add 1 to the respective ball type array when a ball is scored", ->
      match.scoreNumberedBall 1
      expect(match.current_game.ballsHitIn.solids).toEqual [1]
      match.scoreNumberedBall 12
      expect(match.current_game.ballsHitIn.stripes).toEqual [12]


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
      expect(match.current_game.player.one.hasWon).toEqual true
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
      expect(match.current_game.player.two.hasWon).toEqual true
      expect(match.getRemainingGamesNeededToWinByPlayer(2)).toEqual 6

    it "should add current game to the completedGames list and start a new Game when the game has completed", ->
      expect(match.completedGames.length).toEqual 0
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.startNewGame()
      expect(match.completedGames.length).toEqual 1
      expect(match.current_game.ended).toEqual false
      expect(match.completedGames[0].ended).toEqual true

    it "should know if the match is completed", ->
      expect(match.ended).toEqual false

    it "should hold multiple completed games", ->
      expect(match.completedGames).toNotEqual null


  describe "Players", ->
    it "should be able to have the rank changed and have the BallCounts and timeouts_allowed automatically", ->
      expect(match.player.one.gamesNeededToWin).toEqual 2 #Opponent is a 7
      expect(match.player.two.gamesNeededToWin).toEqual 7 #Opponent is a 2
      expect(match.player.one.timeouts_allowed).toEqual 2
      match.player.one.rank = 7
      match.resetPlayerRankStats()
      expect(match.player.one.gamesNeededToWin).toEqual 5 #Opponent is a 7
      expect(match.player.one.timeouts_allowed).toEqual 1
      expect(match.player.two.gamesNeededToWin).toEqual 5 #Opponent is a 7

    it "should change currently up player on missed shot", ->
      expect(match.player.one.currentlyUp).toEqual true
      match.shotMissed()
      expect(match.player.two.currentlyUp).toEqual true

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

  it "should be able to hold on to the originalId from the database", ->
    expect(match.originalId).toEqual 0

  it "should be able to hold on to the leagueMatchId from the database", ->
    expect(match.leagueMatchId).toEqual 0

  it "should be able to know when the last thing that happened was a player switch", ->
    expect(match.ArePlayersSwitching).toEqual false
    match.shotMissed()
    expect(match.ArePlayersSwitching).toEqual true
    match.scoreNumberedBall 1
    expect(match.ArePlayersSwitching).toEqual false

  it "should be able to put match into sudden death mode", ->
    expect(match.suddenDeath).toEqual false
    expect(match.player.one.gamesNeededToWin).toEqual 2
    expect(match.player.two.gamesNeededToWin).toEqual 7
    match.setSuddenDeathMode()
    expect(match.suddenDeath).toEqual true
    expect(match.player.one.gamesNeededToWin).toEqual 1
    expect(match.player.two.gamesNeededToWin).toEqual 1

  it "should switch players if eight ball is hit in without all other 7 balls", ->
    match.shotMissed()
    expect(match.player.two.currentlyUp).toEqual true
    expect(match.player.one.currentlyUp).toEqual false
    match.scoreNumberedBall 8
    expect(match.player.one.currentlyUp).toEqual true
    expect(match.player.two.currentlyUp).toEqual false

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
    expect(match.player.one.hasWon).toEqual false
    expect(match.player.two.hasWon).toEqual false
    match.scoreNumberedBall 8
    match.startNewGame()
    match.scoreNumberedBall 8
    expect(match.getRemainingGamesNeededToWinByPlayer(1)).toEqual "0"
    expect(match.player.one.hasWon).toEqual true

  describe "toJSON/fromJSON", ->
    it "should be able to take a new Match and turn it into a JSON object", ->
      expect(match.toJSON()).toEqual
        player:
          one:
            name: "Player1"
            rank: 2
            gamesNeededToWin: 2
            number: "12345"
            teamNumber: "123"
            gamesWon: 0
            safeties: 0
            eightOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: true
    
          two:
            name: "Player2"
            rank: 7
            gamesNeededToWin: 7
            number: "987654"
            teamNumber: "456"
            gamesWon: 0
            safeties: 0
            eightOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: false
    
        playerOneWon: 3
        playerTwoWon: 0
        current_game:
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: true
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: null
          onBreak: true
          ended: false
    
        completedGames: [
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: true
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: 8
          onBreak: true
          ended: true
        ,
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: false
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: 15
          onBreak: false
          ended: true
        ]
        suddenDeath: false
        forfeit: false
        ended: false
        originalId: 0
        leagueMatchId: 0
        
    it "should be able to take a filled Match and turn it into a JSON object", ->
      match.scoreNumberedBall 1
      match.shotMissed()
      match.scoreNumberedBall 12
      match.shotMissed()
      match.scoreNumberedBall 8
      match.startNewGame()
      expect(match.toJSON()).toEqual
        player:
          one:
            name: "Player1"
            rank: 2
            gamesNeededToWin: 2
            number: "12345"
            teamNumber: "123"
            gamesWon: 0
            safeties: 0
            eightOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: false
    
          two:
            name: "Player2"
            rank: 7
            gamesNeededToWin: 7
            number: "987654"
            teamNumber: "456"
            gamesWon: 0
            safeties: 0
            eightOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: true
    
        playerOneWon: 3
        playerTwoWon: 0
        current_game:
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: false
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: null
          onBreak: false
          ended: false
    
        completedGames: [
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: true
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: 8
          onBreak: true
          ended: true
        ,
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: false
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: 15
          onBreak: false
          ended: true
        ]
        suddenDeath: false
        forfeit: false
        ended: false
        originalId: 0
        leagueMatchId: 0


    it "should be able to put a matches completed games into a JSON object", ->
      match.scoreNumberedBall 1
      match.shotMissed() #Ending breaking
      match.scoreNumberedBall 15
      match.shotMissed()
      match.scoreNumberedBall 8
      match.startNewGame()
      expect(match.completedGamesToJSON()).toEqual [
        playerOneTimeoutsTaken: 2
        playerTwoTimeoutsTaken: 0
        playerOneEightOnSnap: false
        playerOneBreakAndRun: true
        playerTwoEightOnSnap: false
        playerTwoBreakAndRun: false
        playerOneBallType: 2
        playerTwoBallType: 1
        playerOneEightBall: [8]
        playerTwoEightBall: []
        playerOneWon: true
        playerTwoWon: false
        numberOfInnings: 0
        earlyEight: false
        scratchOnEight: false
        breakingPlayerStillShooting: true
        stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
        solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
        lastBallHitIn: 8
        onBreak: true
        ended: true
      ,
        playerOneTimeoutsTaken: 2
        playerTwoTimeoutsTaken: 0
        playerOneEightOnSnap: false
        playerOneBreakAndRun: true
        playerTwoEightOnSnap: false
        playerTwoBreakAndRun: false
        playerOneBallType: 2
        playerTwoBallType: 1
        playerOneEightBall: [8]
        playerTwoEightBall: []
        playerOneWon: true
        playerTwoWon: false
        numberOfInnings: 0
        earlyEight: false
        scratchOnEight: false
        breakingPlayerStillShooting: false
        stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
        solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
        lastBallHitIn: 15
        onBreak: false
        ended: true
      ]

    it "should be able to take a Player JSON and fill a Player object and return it", ->
      player = match.playerFromJSON(
        name: "James Armstead"
        rank: 2
        gamesNeededToWin: 0
        number: "4321"
        teamNumber: "789"
        gamesWon: 1
        safeties: 1
        eightOnSnaps: 2
        breakAndRuns: 3
        currentlyUp: true
      )
      expect(player.name).toEqual "James Armstead"
      expect(player.rank).toEqual 2
      expect(player.number).toEqual "4321"
      expect(player.teamNumber).toEqual "789"
      expect(player.gamesWon).toEqual 1
      expect(player.safeties).toEqual 1
      expect(player.eightOnSnaps).toEqual 2
      expect(player.breakAndRuns).toEqual 3
      expect(player.currentlyUp).toEqual true
      player.addOneToEightOnSnaps()
      expect(player.eightOnSnaps).toEqual 3

    it "should be able to take a Match JSON and fill its values", ->
      match.fromJSON
        player:
          one:
            name: "Player1"
            rank: 2
            gamesNeededToWin: 2
            number: "12345"
            teamNumber: "123"
            gamesWon: 0
            safeties: 0
            eightOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: true
    
          two:
            name: "Player2"
            rank: 7
            gamesNeededToWin: 7
            number: "987654"
            teamNumber: "456"
            gamesWon: 0
            safeties: 0
            eightOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: false
    
        playerOneWon: 3
        playerTwoWon: 0
        current_game:
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: true
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: null
          onBreak: true
          ended: false
    
        completedGames: [
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: false
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: 8
          onBreak: true
          ended: true
        ,
          playerOneTimeoutsTaken: 2
          playerTwoTimeoutsTaken: 0
          playerOneEightOnSnap: false
          playerOneBreakAndRun: true
          playerTwoEightOnSnap: false
          playerTwoBreakAndRun: false
          playerOneBallType: 2
          playerTwoBallType: 1
          playerOneEightBall: [8]
          playerTwoEightBall: []
          playerOneWon: true
          playerTwoWon: false
          numberOfInnings: 0
          earlyEight: false
          scratchOnEight: false
          breakingPlayerStillShooting: false
          stripedBallsHitIn: [12, 9, 10, 11, 13, 14, 15]
          solidBallsHitIn: [1, 2, 3, 4, 5, 6, 7]
          lastBallHitIn: 15
          onBreak: false
          ended: true
        ]
        suddenDeath: false
        forfeit: false
        ended: false
        originalId: 0
        leagueMatchId: 0

      expect(match.getGamesWonByPlayer(1)).toEqual 0
      expect(match.getGamesWonByPlayer(2)).toEqual 1
      expect(match.ended).toEqual false
      expect(match.originalId).toEqual 0
      expect(match.player.one.name).toEqual "Player1"
      expect(match.player.two.name).toEqual "Player2"
      expect(match.current_game.breakingPlayerStillShooting).toEqual true
      expect(match.completedGames[0].breakingPlayerStillShooting).toEqual false
      expect(match.completedGames[0].player.two.hasWon).toEqual true
      expect(match.player.one.getGamesNeededToWin()).toEqual "2"

    it "should be able to take a completedGames JSON array and convert it to JS Array with Objects", ->
      completedGames = match.completedGamesFromJSON([
        playerOneTimeoutsTaken: 0
        playerTwoTimeoutsTaken: 0
        numberOfInnings: 0
        playerOneEightOnSnap: false
        playerOneBreakAndRun: false
        playerTwoEightOnSnap: false
        playerTwoBreakAndRun: false
        playerOneBallType: 1
        playerTwoBallType: null
        playerOneEightBall: []
        playerTwoEightBall: [8]
        playerOneWon: true
        playerTwoWon: false
        ended: true
        stripedBallsHitIn: [1]
        solidBallsHitIn: [12]
        lastBallHitIn: 12
        onBreak: false
        breakingPlayerStillShooting: false
      ])
      
      expect(completedGames[0].getBallsHitInByPlayer(1)).toEqual [1]
      expect(completedGames[0].player.one.hasWon).toEqual true
