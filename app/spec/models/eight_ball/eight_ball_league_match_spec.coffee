describe "Eight Ball League Match", ->
  leagueMatch = undefined
  
  beforeEach ->
    leagueMatch = new $CS.Models.EightBall.LeagueMatch(
      options =
        homeTeamNumber: "123"
        awayTeamNumber: "345" 
        homeTeamName: "HomeTeam"
        awayTeamName: "AwayTeam"
        startTime: "10:00 pm"
        tableType: "Coin-Operated"
    )
    leagueMatch.setMatch new $CS.Models.EightBall.Match(
      options = 
        playerOneName: "Player1"
        playerTwoName: "Player2"
        playerOneRank: 2
        playerTwoRank: 2
        playerOneNumber: "1"
        playerTwoNumber: "2"
        playerOneTeamNumber: "123"
        playerTwoTeamNumber: "345"
    ), 1
    leagueMatch.match.one.player.one.currentlyUp = true
    leagueMatch.setMatch new $CS.Models.EightBall.Match(
      options = 
        playerOneName: "Player1"
        playerTwoName: "Player2"
        playerOneRank: 2
        playerTwoRank: 2
        playerOneNumber: "1"
        playerTwoNumber: "2"
        playerOneTeamNumber: "345"
        playerTwoTeamNumber: "123"
    ), 2
    leagueMatch.match.two.player.one.currentlyUp = true
    leagueMatch.setMatch new $CS.Models.EightBall.Match(
      options = 
        playerOneName: "Player1"
        playerTwoName: "Player2"
        playerOneRank: 2
        playerTwoRank: 2
        playerOneNumber: "1"
        playerTwoNumber: "2"
        playerOneTeamNumber: "123"
        playerTwoTeamNumber: "345"
    ), 3
    leagueMatch.match.three.player.one.currentlyUp = true
    leagueMatch.setMatch new $CS.Models.EightBall.Match(
      options = 
        playerOneName: "Player1"
        playerTwoName: "Player2"
        playerOneRank: 2
        playerTwoRank: 2
        playerOneNumber: "1"
        playerTwoNumber: "2"
        playerOneTeamNumber: "345"
        playerTwoTeamNumber: "123"
    ), 4
    leagueMatch.match.four.player.one.currentlyUp = true
    leagueMatch.setMatch new $CS.Models.EightBall.Match(
      options = 
        playerOneName: "Player1"
        playerTwoName: "Player2"
        playerOneRank: 2
        playerTwoRank: 2
        playerOneNumber: "1"
        playerTwoNumber: "2"
        playerOneTeamNumber: "123"
        playerTwoTeamNumber: "345"
    ), 5
    leagueMatch.match.five.player.one.currentlyUp = true

    setUpMatchDefaults = (matchNum) ->
      leagueMatch.match[matchNum].player.one.currentlyUp = true
      leagueMatch.match[matchNum].completedGames = []
      leagueMatch.match[matchNum].ended = false
      leagueMatch.match[matchNum].playerNumberWinning = 0
      leagueMatch.match[matchNum].playerOneWon = false
      leagueMatch.match[matchNum].playerTwoWon = false
      leagueMatch.match[matchNum].arePlayersSwitching = false
      leagueMatch.match[matchNum].suddenDeath = false
      leagueMatch.match[matchNum].forfeit = false
      
      leagueMatch.match[matchNum].currentGame.numberOfInnings = 0
      leagueMatch.match[matchNum].currentGame.player.one.eightOnSnap = false
      leagueMatch.match[matchNum].currentGame.player.one.breakAndRun = false
      leagueMatch.match[matchNum].currentGame.player.two.eightOnSnap = false
      leagueMatch.match[matchNum].currentGame.player.two.breakAndRun = false
      leagueMatch.match[matchNum].currentGame.player.one.ballType = null
      leagueMatch.match[matchNum].currentGame.player.two.ballType = null
      leagueMatch.match[matchNum].currentGame.player.one.eightBall = []
      leagueMatch.match[matchNum].currentGame.player.two.eightBall = []
      leagueMatch.match[matchNum].currentGame.player.one.callback().gamesWon = 0
      leagueMatch.match[matchNum].currentGame.player.two.callback().gamesWon = 0
      leagueMatch.match[matchNum].currentGame.playerOneWon = false
      leagueMatch.match[matchNum].currentGame.playerTwoWon = false
      leagueMatch.match[matchNum].currentGame.ended = false
      leagueMatch.match[matchNum].currentGame.ballsHitIn.stripes = []
      leagueMatch.match[matchNum].currentGame.ballsHitIn.solids = []
      leagueMatch.match[matchNum].currentGame.lastBallHitIn = null
      leagueMatch.match[matchNum].currentGame.onBreak = true
      leagueMatch.match[matchNum].currentGame.breakingPlayerStillShooting = true
      leagueMatch.match[matchNum].currentGame.player.one.callback().currentlyUp = true
      leagueMatch.match[matchNum].currentGame.player.two.callback().currentlyUp = false
      
    setUpMatchDefaults('one')
    setUpMatchDefaults('two')
    setUpMatchDefaults('three')
    setUpMatchDefaults('four')
    setUpMatchDefaults('five')

  it "should have homeTeamNumber, awayTeamNumber, startTime, and tableType initialized from constructor", ->
    expect(leagueMatch.homeTeamNumber).toEqual "123"
    expect(leagueMatch.awayTeamNumber).toEqual "345"
    expect(leagueMatch.startTime).toEqual "10:00 pm"
    expect(leagueMatch.tableType).toEqual "Coin-Operated"

  it "should hold 5 different games", ->
    expect(leagueMatch.match.one).toNotEqual null
    expect(leagueMatch.match.two).toNotEqual null
    expect(leagueMatch.match.three).toNotEqual null
    expect(leagueMatch.match.four).toNotEqual null
    expect(leagueMatch.match.five).toNotEqual null

  it "should hold a home and away team numbers", ->
    expect(leagueMatch.homeTeamNumber).toEqual "123"
    expect(leagueMatch.awayTeamNumber).toEqual "345"

  it "should keep scorecard team owners number", ->
    expect(leagueMatch.teamNumber).toEqual ""

  it "should have the Start Time and End Time", ->
    expect(leagueMatch.endTime).toEqual ""

  it "should be able to set each match and set the leagueMatchId for each", ->
    expect(leagueMatch.match.one.leagueMatchId).toEqual 1
    expect(leagueMatch.match.two.leagueMatchId).toEqual 2
    expect(leagueMatch.match.three.leagueMatchId).toEqual 3
    expect(leagueMatch.match.four.leagueMatchId).toEqual 4
    expect(leagueMatch.match.five.leagueMatchId).toEqual 5

  it "should know when all of the matches have ended and the league match is complete", ->
    leagueMatch.match.one.ended = true
    leagueMatch.match.two.ended = true
    leagueMatch.match.three.ended = true
    leagueMatch.match.four.ended = true
    leagueMatch.match.five.ended = true
    expect(leagueMatch.ended()).toEqual true

  it "should be able to get the home teams total match points", ->
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.shotMissed()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.shotMissed()
    leagueMatch.match.one.scoreNumberedBall 8
    
    leagueMatch.match.two.currentGame.breakIsOver()
    leagueMatch.match.two.shotMissed()
    leagueMatch.match.two.scoreNumberedBall 8
    leagueMatch.match.two.startNewGame()
    leagueMatch.match.two.currentGame.breakIsOver()
    leagueMatch.match.two.shotMissed()
    leagueMatch.match.two.scoreNumberedBall 8
    
    leagueMatch.match.three.currentGame.breakIsOver()
    leagueMatch.match.three.shotMissed()
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.currentGame.breakIsOver()
    leagueMatch.match.three.shotMissed()
    leagueMatch.match.three.scoreNumberedBall 8
    
    leagueMatch.match.four.currentGame.breakIsOver()
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.currentGame.breakIsOver()
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.four.scoreNumberedBall 8
    
    leagueMatch.match.five.currentGame.breakIsOver()
    leagueMatch.match.five.shotMissed()
    leagueMatch.match.five.scoreNumberedBall 8
    leagueMatch.match.five.startNewGame()
    leagueMatch.match.five.currentGame.breakIsOver()
    leagueMatch.match.five.shotMissed()
    leagueMatch.match.five.scoreNumberedBall 8

    expect(leagueMatch.getMatchPointsByTeam('home')).toEqual 5

  it "should be able to get the away teams total match points", ->
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.scoreNumberedBall 8
  
    leagueMatch.match.two.currentGame.breakIsOver()
    leagueMatch.match.two.scoreNumberedBall 8
    leagueMatch.match.two.startNewGame()
    leagueMatch.match.two.currentGame.breakIsOver()
    leagueMatch.match.two.scoreNumberedBall 8
    
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    
    leagueMatch.match.five.scoreNumberedBall 8
    leagueMatch.match.five.startNewGame()
    leagueMatch.match.five.scoreNumberedBall 8
    
    expect(leagueMatch.getMatchPointsByTeam('home')).toEqual 0
    expect(leagueMatch.getMatchPointsByTeam('away')).toEqual 5

  it "should know if home team is winning the match", ->
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.shotMissed()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.scoreNumberedBall 8
    
    leagueMatch.match.two.scoreNumberedBall 8
    leagueMatch.match.two.startNewGame()
    leagueMatch.match.two.scoreNumberedBall 8
    
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    
    leagueMatch.match.five.shotMissed()
    leagueMatch.match.five.scoreNumberedBall 8
    leagueMatch.match.five.startNewGame()
    leagueMatch.match.five.scoreNumberedBall 8
    
    expect(leagueMatch.isHomeTeamWinning()).toEqual true

  it "should know if away team is winning the match", ->
    
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.scoreNumberedBall 8
    
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.two.scoreNumberedBall 8
    leagueMatch.match.two.startNewGame()
    leagueMatch.match.two.scoreNumberedBall 8
    
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    
    leagueMatch.match.five.scoreNumberedBall 8
    leagueMatch.match.five.startNewGame()
    leagueMatch.match.five.scoreNumberedBall 8
    leagueMatch.match.five.startNewGame()
    leagueMatch.match.five.scoreNumberedBall 8
    
    expect(leagueMatch.getMatchPointsByTeam('away')).toEqual 5
    expect(leagueMatch.getMatchPointsByTeam('home')).toEqual 0
    expect(leagueMatch.isAwayTeamWinning()).toEqual true

  it "should be able to get the winning team number if its the away team", ->
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.scoreNumberedBall 8
    
    leagueMatch.match.two.scoreNumberedBall 8
    leagueMatch.match.two.startNewGame()
    leagueMatch.match.two.scoreNumberedBall 8
    
    leagueMatch.match.three.shotMissed()
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    
    leagueMatch.match.five.scoreNumberedBall 8
    leagueMatch.match.five.startNewGame()
    leagueMatch.match.five.scoreNumberedBall 8

    expect(leagueMatch.getWinningTeamNumber()).toEqual "345"

  it "should be able to get the winning team number if it is the home team", ->
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.startNewGame()
    leagueMatch.match.one.scoreNumberedBall 8
    
    leagueMatch.match.two.shotMissed()
    leagueMatch.match.two.scoreNumberedBall 8
    leagueMatch.match.two.startNewGame()
    leagueMatch.match.two.scoreNumberedBall 8
    
    leagueMatch.match.three.scoreNumberedBall 8
    leagueMatch.match.three.startNewGame()
    leagueMatch.match.three.scoreNumberedBall 8
    
    leagueMatch.match.four.scoreNumberedBall 8
    leagueMatch.match.four.startNewGame()
    leagueMatch.match.four.scoreNumberedBall 8
    
    leagueMatch.match.five.shotMissed()
    leagueMatch.match.five.scoreNumberedBall 8
    leagueMatch.match.five.startNewGame()
    leagueMatch.match.five.scoreNumberedBall 8
    
    expect(leagueMatch.getWinningTeamNumber()).toEqual "123"

  it "should be able to keep team names", ->
    expect(leagueMatch.homeTeamName).toEqual "HomeTeam"
    expect(leagueMatch.awayTeamName).toEqual "AwayTeam"

  it "should be able to tell which team has signed the match", ->
    expect(leagueMatch.homeTeamSigned).toEqual false
    expect(leagueMatch.awayTeamSigned).toEqual false
    leagueMatch.homeTeamSigned = true
    leagueMatch.awayTeamSigned = true
    expect(leagueMatch.homeTeamSigned).toEqual true
    expect(leagueMatch.awayTeamSigned).toEqual true

  describe "toJSON/fromJSON", ->
    it "should be able to take a new League Match and turn it into a JSON object", ->
      expect(leagueMatch.toJSON()).toEqual
        match:
          one:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 1
    
          two:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 2
    
          three:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 3
    
          four:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 4
    
          five:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 5
    
        teamNumber: ""
        homeTeamNumber: "123"
        awayTeamNumber: "345"
        homeTeamName: "HomeTeam"
        awayTeamName: "AwayTeam"
        startTime: "10:00 pm"
        endTime: ""
        tableType: "Coin-Operated"
        leagueMatchId: 1
          

    it "should be able to take a new League Match and turn it into a small JSON object", ->
      expect(leagueMatch.toSmallJSON()).toEqual
        teamNumber: ""
        homeTeamNumber: "123"
        awayTeamNumber: "345"
        startTime: "10:00 pm"
        endTime: ""
        tableType: "Coin-Operated"
        leagueMatchId: 1


    it "should be able to set SmallJSON = true to return only the small JSON object when toJSON is called.", ->
      leagueMatch.SmallJSON = true
      expect(leagueMatch.toJSON()).toEqual
        match:
          one:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 1
    
          two:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 2
    
          three:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 3
    
          four:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 4
    
          five:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 5
    
        teamNumber: ""
        homeTeamNumber: "123"
        awayTeamNumber: "345"
        homeTeamName: "HomeTeam"
        awayTeamName: "AwayTeam"
        startTime: "10:00 pm"
        endTime: ""
        tableType: "Coin-Operated"
        leagueMatchId: 1


    it "should be able to take a json object and fill its own values", ->
      leagueMatch = new $CS.Models.EightBall.LeagueMatch(
        options =
          homeTeamNumber: "123"
          awayTeamNumber: "345"
          homeTeamName: "HomeTeam"
          awayTeamName: "AwayTeam"
          startTime: "10:00 pm"
          tableType: "Coin-Operated"
      )
      leagueMatch.fromJSON
        match:
          one:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 1
    
          two:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 2
    
          three:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 3
    
          four:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 4
    
          five:
            player:
              one:
                name: "Player1"
                rank: 2
                gamesNeededToWin: 2
                number: "1"
                teamNumber: "123"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                gamesNeededToWin: 2
                number: "2"
                teamNumber: "345"
                gamesWon: 0
                safeties: 0
                eightOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneWon: 0
            playerTwoWon: 0
            currentGame:
              playerOneTimeoutsTaken: 0
              playerTwoTimeoutsTaken: 0
              playerOneEightOnSnap: false
              playerOneBreakAndRun: false
              playerTwoEightOnSnap: false
              playerTwoBreakAndRun: false
              playerOneBallType: null
              playerTwoBallType: null
              playerOneEightBall: []
              playerTwoEightBall: []
              playerOneWon: false
              playerTwoWon: false
              numberOfInnings: 0
              earlyEight: false
              scratchOnEight: false
              breakingPlayerStillShooting: true
              stripedBallsHitIn: []
              solidBallsHitIn: []
              lastBallHitIn: null
              onBreak: true
              ended: false
    
            completedGames: []
            suddenDeath: false
            forfeit: false
            ended: false
            originalId: 0
            leagueMatchId: 5
    
        teamNumber: ""
        homeTeamNumber: "123"
        awayTeamNumber: "345"
        startTime: "10:00 pm"
        endTime: ""
        tableType: "Coin-Operated"
        leagueMatchId: 1
        
      expect(leagueMatch.teamNumber).toEqual ""
      expect(leagueMatch.homeTeamNumber).toEqual "123"
      expect(leagueMatch.awayTeamNumber).toEqual "345"
      expect(leagueMatch.startTime).toEqual "10:00 pm"
      expect(leagueMatch.endTime).toEqual ""
      expect(leagueMatch.tableType).toEqual "Coin-Operated"
      expect(leagueMatch.leagueMatchId).toEqual 1
      expect(leagueMatch.match.five.player.one.name).toEqual "Player1"
      leagueMatch.match.five.scoreNumberedBall 8
      expect(leagueMatch.match.five.currentGame.getBallsHitIn()).toEqual [8]
      leagueMatch.match.five.startNewGame()
      expect(leagueMatch.match.five.currentGame.getBallsHitIn()).toEqual []
      expect(leagueMatch.match.five.completedGames.length).toEqual 1

    it "should be able to take a small json object and fill its own values", ->
      leagueMatch = new $CS.Models.EightBall.LeagueMatch(
        options =
          homeTeamNumber: "123"
          awayTeamNumber: "345"
          homeTeamName: "HomeTeam"
          awayTeamName: "AwayTeam"
          startTime: "10:00 pm"
          tableType: "Coin-Operated"
      )
      leagueMatch.fromSmallJSON
        teamNumber: ""
        homeTeamNumber: "123"
        awayTeamNumber: "345"
        startTime: "10:00 pm"
        endTime: ""
        tableType: "Coin-Operated"
        leagueMatchId: null

      expect(leagueMatch.teamNumber).toEqual ""
      expect(leagueMatch.homeTeamNumber).toEqual "123"
      expect(leagueMatch.awayTeamNumber).toEqual "345"
      expect(leagueMatch.startTime).toEqual "10:00 pm"
      expect(leagueMatch.endTime).toEqual ""
      expect(leagueMatch.tableType).toEqual "Coin-Operated"
      expect(leagueMatch.leagueMatchId).toEqual null


