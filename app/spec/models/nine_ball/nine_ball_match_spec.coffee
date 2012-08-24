describe "Nine Ball Match", ->
  match = undefined
  matchCallback = undefined
  
  beforeEach ->
    matchCallback = jasmine.createSpy()
    match = new $CS.Models.NineBall.Match(
      options = 
        playerOneName: "Player1"
        playerTwoName: "Player2"
        playerOneRank: 1
        playerTwoRank: 7
        playerOneNumber: "12345"
        playerTwoNumber: "987654"
        playerOneTeamNumber: "123"
        playerTwoTeamNumber: "456"
        matchCallback: matchCallback
    )
    match.player.one.currentlyUp = true
    
    match.completedGames = []
    match.ended = false
    match.originalId = 0
    match.leagueMatchId = 0
    match.playerNumberWinning = 0
    match.suddenDeath = false
    match.forfeit = false

    match.currentGame.player.one.score = 0
    match.currentGame.player.one.nineOnSnap = false
    match.currentGame.player.one.breakAndRun = false
    match.currentGame.player.one.ballsHitIn = []
    match.currentGame.player.one.deadBalls = []
    match.currentGame.player.one.lastBall = null
    match.currentGame.player.one.timeoutsTaken = 0
    match.currentGame.player.two.score = 0
    match.currentGame.player.two.nineOnSnap = false
    match.currentGame.player.two.breakAndRun = false
    match.currentGame.player.two.ballsHitIn = []
    match.currentGame.player.two.deadBalls = []
    match.currentGame.player.two.lastBall = null
    match.currentGame.player.two.timeoutsTaken = 0
    match.currentGame.numberOfInnings = 0
    match.currentGame.ended = false
    match.currentGame.onBreak = true
    match.currentGame.breakingPlayerStillShooting = true

  describe "Constructor", ->
    it "should take 4 parameters", ->
      expect(match).toNotEqual null

    it "should have 2 players", ->
      expect(match.player.one.name).toEqual "Player1"
      expect(match.player.one.rank).toEqual 1
      expect(match.player.one.number).toEqual "12345"
      expect(match.player.one.teamNumber).toEqual "123"
      expect(match.player.two.name).toEqual "Player2"
      expect(match.player.two.rank).toEqual 7
      expect(match.player.two.number).toEqual "987654"
      expect(match.player.two.teamNumber).toEqual "456"

    it "should set Player 1 to break first", ->
      expect(match.player.one.currentlyUp).toEqual true

    it "should set create the first Game and set it to currentGame", ->
      expect(match.currentGame).toNotEqual null


  describe "Scoring", ->
    it "should accept a number for the ball that was hit in", ->
      match.scoreNumberedBall 1

    it "should add 1 to the current Ball Count for the current player up for balls #1-8", ->
      expect(match.currentGame.player.one.score).toEqual 0
      match.scoreNumberedBall 1
      expect(match.currentGame.player.one.score).toEqual 1
      match.scoreNumberedBall 2
      expect(match.currentGame.player.one.score).toEqual 2
      match.scoreNumberedBall 3
      expect(match.currentGame.player.one.score).toEqual 3
      match.scoreNumberedBall 4
      expect(match.currentGame.player.one.score).toEqual 4
      match.scoreNumberedBall 5
      expect(match.currentGame.player.one.score).toEqual 5
      match.scoreNumberedBall 6
      expect(match.currentGame.player.one.score).toEqual 6
      match.scoreNumberedBall 7
      expect(match.currentGame.player.one.score).toEqual 7
      match.scoreNumberedBall 8
      expect(match.currentGame.player.one.score).toEqual 8

    it "should add 2 to the current Ball Count for the current player up for ball #9", ->
      expect(match.currentGame.player.one.score).toEqual 0
      match.scoreNumberedBall 9
      expect(match.currentGame.player.one.score).toEqual 2

    it "should be able to get match's points by the team number", ->
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.getMatchPointsByTeamNumber("123")).toEqual 20

    it "should be able to remember the last person that was winning incase of a tie", ->
      match.scoreNumberedBall 1
      expect(match.playerNumberWinning).toEqual 1
      match.shotMissed()
      match.shotMissed()
      expect(match.player.two.currentlyUp).toEqual true
      match.scoreNumberedBall 2
      expect(match.playerNumberWinning).toEqual 1
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      expect(match.playerNumberWinning).toEqual 2
      match.shotMissed()
      match.scoreNumberedBall 7
      expect(match.playerNumberWinning).toEqual 1


  describe "Match/Game Ending", ->
    it "should add current game to the completedGames list and start a new Game when all 8 balls are accounted for on a DeadBall and 9 is scored", ->
      expect(match.completedGames.length).toEqual 0
      match.hitDeadBall 1
      match.hitDeadBall 2
      match.hitDeadBall 3
      match.hitDeadBall 4
      match.hitDeadBall 5
      match.hitDeadBall 6
      match.hitDeadBall 7
      match.hitDeadBall 8
      match.scoreNumberedBall 9
      match.startNewGame()
      expect(match.completedGames.length).toEqual 1
      expect(match.currentGame.getDeadBalls()).toEqual 0
      expect(match.currentGame.ended).toEqual false
      expect(match.completedGames[0].ended).toEqual true

    it "should add current game to the completedGames list and start a new Game when all 9 balls are accounted for on a ScoredBall", ->
      expect(match.completedGames.length).toEqual 0
      match.hitDeadBall 1
      match.hitDeadBall 2
      match.hitDeadBall 3
      match.hitDeadBall 4
      match.hitDeadBall 5
      match.hitDeadBall 6
      match.hitDeadBall 7
      match.hitDeadBall 8
      match.scoreNumberedBall 9
      match.startNewGame()
      expect(match.completedGames.length).toEqual 1
      expect(match.currentGame.getDeadBalls()).toEqual 0
      expect(match.currentGame.ended).toEqual false
      expect(match.completedGames[0].ended).toEqual true

    it "should know if the match is completed", ->
      expect(match.ended).toEqual false

    it "match should be ended when ball #1-8 scores, which then raises CurrentPlayers score to equal Ball Count", ->
      expect(match.ended).toEqual false
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
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.ended).toEqual true

    it "match should be ended when ball#9 scores, which then raises CurrentPlayers score to above or equal Ball Count", ->
      expect(match.ended).toEqual false
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
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 9
      expect(match.ended).toEqual true

    it "should hold multiple completed games", ->
      expect(match.completedGames).toNotEqual null


  describe "Players", ->
    it "should be able to find the losing player", ->
      match.scoreNumberedBall 9
      expect(match.getLosingPlayer().name).toEqual "Player2"

    it "should be able to find the winning player", ->
      match.scoreNumberedBall 9
      expect(match.getWinningPlayer().name).toEqual "Player1"

    it "should change currently up player on missed shot", ->
      expect(match.player.one.currentlyUp).toEqual true
      match.shotMissed()
      expect(match.player.two.currentlyUp).toEqual true

    it "should be able to get the player twos match points earned", ->
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.getMatchPointsByPlayer(2)).toEqual 0
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.scoreNumberedBall 9
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
      expect(match.getMatchPointsByPlayer(2)).toEqual 18

    it "should be able to see if Player One is winning", ->
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.isPlayerWinning(1)).toEqual true
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.scoreNumberedBall 9
      expect(match.isPlayerWinning(1)).toEqual true #Ratio (4/14) > (6/55)

    it "should be able to see if Player Two is winning", ->
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      expect(match.isPlayerWinning(2)).toEqual false
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 4
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      expect(match.isPlayerWinning(2)).toEqual false #Ratio (3/14) > (5/55)

    it "should be able to get the losing players match points earned", ->
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.getLosingPlayersMatchPoints()).toEqual 0
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.scoreNumberedBall 9
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
      expect(match.getLosingPlayersMatchPoints()).toEqual 2

    it "should be able to get the winning players match points earned", ->
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.getWinningPlayersMatchPoints()).toEqual 20
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.scoreNumberedBall 9
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
      expect(match.getWinningPlayersMatchPoints()).toEqual 18

    it "should be able to get the the match points. (example 20-0)", ->
      expect(match.getMatchPoints()).toEqual "Tied"
      match.scoreNumberedBall 1
      match.scoreNumberedBall 2
      match.scoreNumberedBall 3
      match.scoreNumberedBall 4
      expect(match.getMatchPoints()).toEqual "20-0"
      match.shotMissed() #Ending Break
      match.shotMissed() #All Balls are missed
      match.scoreNumberedBall 5
      match.scoreNumberedBall 6
      match.scoreNumberedBall 7
      match.scoreNumberedBall 8
      match.scoreNumberedBall 9
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
      expect(match.getMatchPoints()).toEqual "2-18"


  it "should be able to set the a ball to be a deadball", ->
    match.hitDeadBall 3
    expect(match.currentGame.player.one.deadBalls[0]).toEqual 3
    match.shotMissed()
    match.hitDeadBall 2
    expect(match.currentGame.player.two.deadBalls[0]).toEqual 2

  it "should be able to get the total number of innings", ->
    expect(match.getTotalInnings()).toEqual "0"
    match.shotMissed()
    match.shotMissed()
    match.shotMissed()
    match.shotMissed()
    expect(match.getTotalInnings()).toEqual "2"
    match.shotMissed()
    match.shotMissed()
    expect(match.getTotalInnings()).toEqual "3"

  it "should be able to get the total number of dead balls", ->
    expect(match.getTotalDeadBalls()).toEqual "0"
    match.scoreNumberedBall 9
    expect(match.getTotalDeadBalls()).toEqual "8"
    match.startNewGame()
    match.hitDeadBall 1
    match.hitDeadBall 2
    expect(match.getTotalDeadBalls()).toEqual "10"
    match.hitDeadBall 3
    match.hitDeadBall 4
    match.hitDeadBall 5
    match.hitDeadBall 6
    expect(match.getTotalDeadBalls()).toEqual "14"

  it "should be able to hold on to the originalId from the database", ->
    expect(match.originalId).toEqual 0

  it "should be able to hold on to the leagueMatchId from the database", ->
    expect(match.leagueMatchId).toEqual 0

  it "should be able to know the current game number", ->
    expect(match.getCurrentGameNumber()).toEqual "1"
    match.hitDeadBall 1
    match.hitDeadBall 2
    match.hitDeadBall 3
    match.hitDeadBall 4
    match.hitDeadBall 5
    match.hitDeadBall 6
    match.hitDeadBall 7
    match.hitDeadBall 8
    match.scoreNumberedBall 9
    match.startNewGame()
    expect(match.getCurrentGameNumber()).toEqual "2"

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
    expect(match.currentGame.player.one.timeoutsTaken).toEqual 0
    expect(match.currentGame.player.two.timeoutsTaken).toEqual 0
    match.currentGame.takeTimeout()
    expect(match.currentGame.player.one.timeoutsTaken).toEqual 1
    match.shotMissed()
    match.currentGame.takeTimeout()
    expect(match.currentGame.player.two.timeoutsTaken).toEqual 1
    match.scoreNumberedBall 9
    match.startNewGame()
    expect(match.currentGame.player.one.timeoutsTaken).toEqual 0
    expect(match.currentGame.player.two.timeoutsTaken).toEqual 0

  describe "toJSON/fromJSON", ->
    it "should be able to take a new Match and turn it into a JSON object", ->
      expect(match.toJSON()).toEqual
        player:
          one:
            name: "Player1"
            rank: 1
            ballCount: "14"
            number: "12345"
            teamNumber: "123"
            score: 0
            safeties: 0
            nineOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: true
    
          two:
            name: "Player2"
            rank: 7
            ballCount: "55"
            number: "987654"
            teamNumber: "456"
            score: 0
            safeties: 0
            nineOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: false
    
        playerOneMatchPointsEarned: 0
        playerTwoMatchPointsEarned: 0
        currentGame:
          playerOneScore: 0
          playerOneTimeoutsTaken: 0
          playerOneNineOnSnap: false
          playerOneBreakAndRun: false
          playerOneBallsHitIn: []
          playerOneDeadBalls: []
          playerOneLastBall: null
          playerTwoScore: 0
          playerTwoTimeoutsTaken: 0
          playerTwoNineOnSnap: false
          playerTwoBreakAndRun: false
          playerTwoBallsHitIn: []
          playerTwoDeadBalls: []
          playerTwoLastBall: null
          ended: false
          numberOfInnings: 0
          onBreak: true
          breakingPlayerStillShooting: true
    
        completedGames: []
        suddenDeath: false
        forfeit: false
        ended: false
        originalId: 0
        leagueMatchId: 0


    it "should be able to take a filled Match and turn it into a JSON object", ->
      match.scoreNumberedBall 1
      match.shotMissed()
      match.hitDeadBall 2
      match.shotMissed()
      match.scoreNumberedBall 9
      match.startNewGame()
      expect(match.toJSON()).toEqual
        player:
          one:
            name: "Player1"
            rank: 1
            ballCount: "14"
            number: "12345"
            teamNumber: "123"
            score: 1
            safeties: 0
            nineOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: false
    
          two:
            name: "Player2"
            rank: 7
            ballCount: "55"
            number: "987654"
            teamNumber: "456"
            score: 2
            safeties: 0
            nineOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: true
    
        playerOneMatchPointsEarned: 20
        playerTwoMatchPointsEarned: 0
        currentGame:
          playerOneScore: 1
          playerOneTimeoutsTaken: 0
          playerOneNineOnSnap: false
          playerOneBreakAndRun: false
          playerOneBallsHitIn: [1]
          playerOneDeadBalls: []
          playerOneLastBall: null
          playerTwoScore: 2
          playerTwoTimeoutsTaken: 0
          playerTwoNineOnSnap: false
          playerTwoBreakAndRun: false
          playerTwoBallsHitIn: [9]
          playerTwoDeadBalls: []
          playerTwoLastBall: null
          ended: false
          numberOfInnings: 0
          onBreak: true
          breakingPlayerStillShooting: true
    
        completedGames: [
          playerOneScore: 1
          playerOneTimeoutsTaken: 0
          playerOneNineOnSnap: false
          playerOneBreakAndRun: false
          playerOneBallsHitIn: [1]
          playerOneDeadBalls: []
          playerOneLastBall: null
          playerTwoScore: 2
          playerTwoTimeoutsTaken: 0
          playerTwoNineOnSnap: false
          playerTwoBreakAndRun: false
          playerTwoBallsHitIn: [9]
          playerTwoDeadBalls: []
          playerTwoLastBall: null
          ended: true
          numberOfInnings: 0
          onBreak: false
          breakingPlayerStillShooting: false
        ]
        suddenDeath: false
        forfeit: false
        ended: false
        originalId: 0
        leagueMatchId: 0


    it "should be able to put a matches completed games into a JSON object", ->
      match.scoreNumberedBall 1
      match.shotMissed() #Ending breaking
      match.hitDeadBall 2
      match.shotMissed()
      match.scoreNumberedBall 9
      match.startNewGame()
      expect(match.completedGamesToJSON()).toEqual [
        playerOneScore: 1
        playerOneTimeoutsTaken: 0
        playerOneNineOnSnap: false
        playerOneBreakAndRun: false
        playerOneBallsHitIn: [1]
        playerOneDeadBalls: []
        playerOneLastBall: null
        playerTwoScore: 2
        playerTwoTimeoutsTaken: 0
        playerTwoNineOnSnap: false
        playerTwoBreakAndRun: false
        playerTwoBallsHitIn: [9]
        playerTwoDeadBalls: []
        playerTwoLastBall: null
        ended: true
        numberOfInnings: 0
        onBreak: false
        breakingPlayerStillShooting: false
      ]

    it "should be able to take a Player JSON and fill a Player object and return it", ->
      player = match.playerFromJSON(
        name: "James Armstead"
        rank: 2
        number: "4321"
        teamNumber: "789"
        score: 12
        safeties: 1
        nineOnSnaps: 2
        breakAndRuns: 3
        currentlyUp: false
      )
      expect(player.name).toEqual "James Armstead"
      expect(player.rank).toEqual 2
      expect(player.number).toEqual "4321"
      expect(player.teamNumber).toEqual "789"
      expect(player.score).toEqual 12
      expect(player.safeties).toEqual 1
      expect(player.nineOnSnaps).toEqual 2
      expect(player.breakAndRuns).toEqual 3
      expect(player.ballCount).toEqual "19"
      expect(player.currentlyUp).toEqual false
      player.addToNineOnSnaps(1)
      expect(player.nineOnSnaps).toEqual 3

    it "should be able to take a Match JSON and fill its values", ->
      match = new $CS.Models.NineBall.Match(
        options = 
          playerOneName: "Player1"
          playerTwoName: "Player2"
          playerOneRank: 1
          playerTwoRank: 7
          playerOneNumber: "12345"
          playerTwoNumber: "987654"
          playerOneTeamNumber: "123"
          playerTwoTeamNumber: "456"
          matchCallback: matchCallback
      )
      match.fromJSON
        player:
          one:
            name: "Player1"
            rank: 1
            ballCount: "14"
            number: "12345"
            teamNumber: "123"
            score: 1
            safeties: 0
            nineOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: false
          two:
            name: "Player2"
            rank: 7
            ballCount: "55"
            number: "987654"
            teamNumber: "456"
            score: 2
            safeties: 0
            nineOnSnaps: 0
            breakAndRuns: 0
            currentlyUp: true

        playerOneMatchPointsEarned: 20
        playerTwoMatchPointsEarned: 0
        currentGame:
          playerOneScore: 0
          playerOneTimeoutsTaken: 0
          playerOneNineOnSnap: false
          playerOneBreakAndRun: false
          playerOneBallsHitIn: []
          playerOneDeadBalls: []
          playerOneLastBall: null
          playerTwoScore: 0
          playerTwoTimeoutsTaken: 0
          playerTwoNineOnSnap: false
          playerTwoBreakAndRun: false
          playerTwoBallsHitIn: []
          playerTwoDeadBalls: []
          playerTwoLastBall: null
          numberOfInnings: 0
          ended: false
          onBreak: false
          breakingPlayerStillShooting: false

        completedGames: [
          playerOneScore: 1
          playerOneTimeoutsTaken: 0
          playerOneNineOnSnap: false
          playerOneBreakAndRun: false
          playerOneBallsHitIn: [1]
          playerOneDeadBalls: [2]
          playerOneLastBall: null
          playerTwoScore: 2
          playerTwoTimeoutsTaken: 0
          playerTwoNineOnSnap: false
          playerTwoBreakAndRun: false
          playerTwoBallsHitIn: [9]
          playerTwoDeadBalls: [3, 4, 5, 6, 7, 8]
          playerTwoLastBall: 9
          numberOfInnings: 0
          ended: true
          onBreak: false
          breakingPlayerStillShooting: false
        ]
        ended: false
        originalId: 0
        leagueMatchId: 0

      expect(match.playerOneMatchPointsEarned).toEqual 20
      expect(match.playerTwoMatchPointsEarned).toEqual 0
      expect(match.ended).toEqual false
      expect(match.originalId).toEqual 0
      expect(match.player.one.name).toEqual "Player1"
      expect(match.player.two.name).toEqual "Player2"
      expect(match.currentGame.breakingPlayerStillShooting).toEqual false
      expect(match.completedGames[0].breakingPlayerStillShooting).toEqual false
      expect(match.completedGames[0].player.one.score).toEqual 1

    it "should be able to take a completedGames JSON array and convert it to JS Array with Objects", ->
      completedGames = match.completedGamesFromJSON([
        playerOneScore: 1
        playerOneTimeoutsTaken: 0
        playerOneNineOnSnap: false
        playerOneBreakAndRun: false
        playerOneBallsHitIn: [1]
        playerOneDeadBalls: [2]
        playerOneLastBall: null
        playerTwoScore: 2
        playerTwoTimeoutsTaken: 0
        playerTwoNineOnSnap: false
        playerTwoBreakAndRun: false
        playerTwoBallsHitIn: [9]
        playerTwoDeadBalls: [3, 4, 5, 6, 7, 8]
        playerTwoLastBall: 9
        numberOfInnings: 0
        ended: true
        onBreak: false
        breakingPlayerStillShooting: false
      ])
      expect(completedGames[0].player.one.score).toEqual 1


