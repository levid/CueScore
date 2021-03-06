describe "Nine Ball League Match", ->
  leagueMatch = undefined
  
  beforeEach ->
    leagueMatch = new $CS.Models.NineBall.LeagueMatch(
      options =
        homeTeamNumber: "123"
        awayTeamNumber: "345" 
        homeTeamName: "HomeTeam"
        awayTeamName: "AwayTeam"
        startTime: "10:00 pm"
        tableType: "Coin-Operated"
    )

    leagueMatch.setMatch new $CS.Models.NineBall.Match(
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
    leagueMatch.setMatch new $CS.Models.NineBall.Match(
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
    leagueMatch.setMatch new $CS.Models.NineBall.Match(
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
    leagueMatch.setMatch new $CS.Models.NineBall.Match(
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
    leagueMatch.setMatch new $CS.Models.NineBall.Match(
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

  it "should be able to calculate home and away teams scores", ->
    
    #Player1 20 points (Home)
    leagueMatch.match.one.currentGame.breakIsOver()
    leagueMatch.match.one.scoreNumberedBall 1
    leagueMatch.match.one.scoreNumberedBall 2
    leagueMatch.match.one.scoreNumberedBall 3
    leagueMatch.match.one.scoreNumberedBall 4
    leagueMatch.match.one.scoreNumberedBall 5
    leagueMatch.match.one.scoreNumberedBall 6
    leagueMatch.match.one.shotMissed()
    leagueMatch.match.one.scoreNumberedBall 7
    leagueMatch.match.one.scoreNumberedBall 8
    leagueMatch.match.one.scoreNumberedBall 9
    expect(leagueMatch.getMatchPointsByTeam('home')).toEqual 95
    expect(leagueMatch.getMatchPointsByTeam('away')).toEqual 5
    
    #PlayerTwo 19 points (Home)
    leagueMatch.match.two.currentGame.breakIsOver()
    leagueMatch.match.two.scoreNumberedBall 1
    leagueMatch.match.two.scoreNumberedBall 2
    leagueMatch.match.two.scoreNumberedBall 3
    leagueMatch.match.two.shotMissed()
    leagueMatch.match.two.scoreNumberedBall 4
    leagueMatch.match.two.scoreNumberedBall 5
    leagueMatch.match.two.scoreNumberedBall 6
    leagueMatch.match.two.scoreNumberedBall 7
    
    #PlayerTwo 19 Points (Away)
    leagueMatch.match.three.currentGame.breakIsOver()
    leagueMatch.match.three.scoreNumberedBall 1
    leagueMatch.match.three.scoreNumberedBall 2
    leagueMatch.match.three.scoreNumberedBall 3
    leagueMatch.match.three.shotMissed()
    leagueMatch.match.three.scoreNumberedBall 4
    leagueMatch.match.three.scoreNumberedBall 5
    leagueMatch.match.three.scoreNumberedBall 6
    leagueMatch.match.three.scoreNumberedBall 7
    
    #PlayerTwo 18 points (Away)
    leagueMatch.match.four.currentGame.breakIsOver()
    leagueMatch.match.four.scoreNumberedBall 1
    leagueMatch.match.four.scoreNumberedBall 2
    leagueMatch.match.four.scoreNumberedBall 3
    leagueMatch.match.four.scoreNumberedBall 4
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.four.scoreNumberedBall 4
    leagueMatch.match.four.scoreNumberedBall 5
    leagueMatch.match.four.scoreNumberedBall 6
    leagueMatch.match.four.scoreNumberedBall 9
    
    #PlayerTwo 18 points (Home)
    leagueMatch.match.five.scoreNumberedBall 1
    leagueMatch.match.five.scoreNumberedBall 2
    leagueMatch.match.five.scoreNumberedBall 3
    leagueMatch.match.five.scoreNumberedBall 4
    leagueMatch.match.five.shotMissed()
    leagueMatch.match.five.scoreNumberedBall 4
    leagueMatch.match.five.scoreNumberedBall 5
    leagueMatch.match.five.scoreNumberedBall 6
    leagueMatch.match.five.scoreNumberedBall 9
    
    expect(leagueMatch.getMatchPointsByTeam('home')).toEqual 65
    expect(leagueMatch.getMatchPointsByTeam('away')).toEqual 35

  it "should know which team is winning the match", ->
    leagueMatch.match.one.scoreNumberedBall 1
    leagueMatch.match.one.scoreNumberedBall 2
    leagueMatch.match.one.scoreNumberedBall 3
    leagueMatch.match.one.scoreNumberedBall 4
    expect(leagueMatch.isHomeTeamWinning()).toEqual true
    expect(leagueMatch.isAwayTeamWinning()).toEqual false
    leagueMatch.match.two.scoreNumberedBall 1
    leagueMatch.match.two.scoreNumberedBall 2
    leagueMatch.match.two.scoreNumberedBall 3
    leagueMatch.match.two.currentGame.breakIsOver()
    leagueMatch.match.two.shotMissed()
    leagueMatch.match.two.scoreNumberedBall 4
    leagueMatch.match.two.scoreNumberedBall 5
    leagueMatch.match.two.scoreNumberedBall 6
    leagueMatch.match.two.scoreNumberedBall 7
    leagueMatch.match.three.currentGame.breakIsOver()
    leagueMatch.match.three.shotMissed()
    leagueMatch.match.three.scoreNumberedBall 1
    leagueMatch.match.three.scoreNumberedBall 2
    leagueMatch.match.three.scoreNumberedBall 3
    leagueMatch.match.three.scoreNumberedBall 4
    leagueMatch.match.three.scoreNumberedBall 5
    leagueMatch.match.three.scoreNumberedBall 6
    leagueMatch.match.three.scoreNumberedBall 7
    leagueMatch.match.four.currentGame.breakIsOver()
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.four.scoreNumberedBall 1
    leagueMatch.match.four.scoreNumberedBall 2
    leagueMatch.match.four.scoreNumberedBall 3
    leagueMatch.match.four.scoreNumberedBall 4
    leagueMatch.match.four.scoreNumberedBall 4
    leagueMatch.match.four.scoreNumberedBall 5
    leagueMatch.match.four.scoreNumberedBall 6
    leagueMatch.match.four.scoreNumberedBall 9
    leagueMatch.match.five.shotMissed()
    leagueMatch.match.five.scoreNumberedBall 1
    leagueMatch.match.five.scoreNumberedBall 2
    leagueMatch.match.five.scoreNumberedBall 3
    leagueMatch.match.five.scoreNumberedBall 4
    leagueMatch.match.five.scoreNumberedBall 4
    leagueMatch.match.five.scoreNumberedBall 5
    leagueMatch.match.five.scoreNumberedBall 6
    leagueMatch.match.five.scoreNumberedBall 9
    expect(leagueMatch.isHomeTeamWinning()).toEqual false
    expect(leagueMatch.isAwayTeamWinning()).toEqual true

  it "should be able to get the winning teams number", ->
    leagueMatch.match.one.scoreNumberedBall 1
    leagueMatch.match.one.scoreNumberedBall 2
    leagueMatch.match.one.scoreNumberedBall 3
    leagueMatch.match.one.scoreNumberedBall 4
    expect(leagueMatch.getWinningTeamNumber()).toEqual "123"
    leagueMatch.match.two.currentGame.breakIsOver()
    leagueMatch.match.two.scoreNumberedBall 1
    leagueMatch.match.two.scoreNumberedBall 2
    leagueMatch.match.two.scoreNumberedBall 3
    leagueMatch.match.two.shotMissed()
    leagueMatch.match.two.scoreNumberedBall 4
    leagueMatch.match.two.scoreNumberedBall 5
    leagueMatch.match.two.scoreNumberedBall 6
    leagueMatch.match.two.scoreNumberedBall 7
    leagueMatch.match.three.currentGame.breakIsOver()
    leagueMatch.match.three.shotMissed()
    leagueMatch.match.three.scoreNumberedBall 1
    leagueMatch.match.three.scoreNumberedBall 2
    leagueMatch.match.three.scoreNumberedBall 3
    leagueMatch.match.three.scoreNumberedBall 4
    leagueMatch.match.three.scoreNumberedBall 5
    leagueMatch.match.three.scoreNumberedBall 6
    leagueMatch.match.three.scoreNumberedBall 7
    leagueMatch.match.four.currentGame.breakIsOver()
    leagueMatch.match.four.shotMissed()
    leagueMatch.match.four.scoreNumberedBall 1
    leagueMatch.match.four.scoreNumberedBall 2
    leagueMatch.match.four.scoreNumberedBall 3
    leagueMatch.match.four.scoreNumberedBall 4
    leagueMatch.match.four.scoreNumberedBall 4
    leagueMatch.match.four.scoreNumberedBall 5
    leagueMatch.match.four.scoreNumberedBall 6
    leagueMatch.match.four.scoreNumberedBall 9
    leagueMatch.match.five.shotMissed()
    leagueMatch.match.five.scoreNumberedBall 1
    leagueMatch.match.five.scoreNumberedBall 2
    leagueMatch.match.five.scoreNumberedBall 3
    leagueMatch.match.five.scoreNumberedBall 4
    leagueMatch.match.five.scoreNumberedBall 4
    leagueMatch.match.five.scoreNumberedBall 5
    leagueMatch.match.five.scoreNumberedBall 6
    leagueMatch.match.five.scoreNumberedBall 9
    expect(leagueMatch.getWinningTeamNumber()).toEqual "345"

  it "should be able to set each match and set the leagueMatchId for each", ->
    expect(leagueMatch.match.one.leagueMatchId).toEqual 1
    expect(leagueMatch.match.two.leagueMatchId).toEqual 2
    expect(leagueMatch.match.three.leagueMatchId).toEqual 3
    expect(leagueMatch.match.four.leagueMatchId).toEqual 4
    expect(leagueMatch.match.five.leagueMatchId).toEqual 5

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

  it "should know when all of the matches have ended and the league match is complete", ->
    leagueMatch.match.one.ended = true
    leagueMatch.match.two.ended = true
    leagueMatch.match.three.ended = true
    leagueMatch.match.four.ended = true
    leagueMatch.match.five.ended = true
    expect(leagueMatch.ended()).toEqual true

  describe "toJSON/fromJSON", ->
    it "should be able to take a new League Match and turn it into a JSON object", ->
      leagueMatch.smallJSON = false
      expect(leagueMatch.toJSON()).toEqual
        match:
          one:
            player:
              one:
                name: "Player1"
                rank: 2
                ballCount: "19"
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                ballCount: "19"
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneMatchPointsEarned: 0
            playerTwoMatchPointsEarned: 0
            currentGame:
              playerOneScore: 35
              playerOneTimeoutsTaken: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerOneBallsHitIn: []
              playerOneDeadBalls: []
              playerOneLastBall: null
              playerTwoScore: 43
              playerTwoTimeoutsTaken: 0
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: true
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
            leagueMatchId: 1
    
          two:
            player:
              one:
                name: "Player1"
                rank: 2
                ballCount: "19"
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                ballCount: "19"
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneMatchPointsEarned: 0
            playerTwoMatchPointsEarned: 0
            currentGame:
              playerOneScore: 35
              playerOneTimeoutsTaken: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerOneBallsHitIn: []
              playerOneDeadBalls: []
              playerOneLastBall: null
              playerTwoScore: 43
              playerTwoTimeoutsTaken: 0
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: true
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
            leagueMatchId: 2
    
          three:
            player:
              one:
                name: "Player1"
                rank: 2
                ballCount: "19"
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                ballCount: "19"
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneMatchPointsEarned: 0
            playerTwoMatchPointsEarned: 0
            currentGame:
              playerOneScore: 35
              playerOneTimeoutsTaken: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerOneBallsHitIn: []
              playerOneDeadBalls: []
              playerOneLastBall: null
              playerTwoScore: 43
              playerTwoTimeoutsTaken: 0
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: true
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
            leagueMatchId: 3
    
          four:
            player:
              one:
                name: "Player1"
                rank: 2
                ballCount: "19"
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                ballCount: "19"
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneMatchPointsEarned: 0
            playerTwoMatchPointsEarned: 0
            currentGame:
              playerOneScore: 35
              playerOneTimeoutsTaken: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerOneBallsHitIn: []
              playerOneDeadBalls: []
              playerOneLastBall: null
              playerTwoScore: 43
              playerTwoTimeoutsTaken: 0
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: true
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
            leagueMatchId: 4
    
          five:
            player:
              one:
                name: "Player1"
                rank: 2
                ballCount: "19"
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: true
    
              two:
                name: "Player2"
                rank: 2
                ballCount: "19"
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                currentlyUp: false
    
            playerOneMatchPointsEarned: 0
            playerTwoMatchPointsEarned: 0
            currentGame:
              playerOneScore: 35
              playerOneTimeoutsTaken: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerOneBallsHitIn: []
              playerOneDeadBalls: []
              playerOneLastBall: null
              playerTwoScore: 43
              playerTwoTimeoutsTaken: 0
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: true
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
            leagueMatchId: 5
    
        teamNumber: ""
        homeTeamNumber: "123"
        awayTeamNumber: "345"
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
      leagueMatch.smallJSON = true
      expect(leagueMatch.toJSON()).toEqual
        teamNumber: ""
        homeTeamNumber: "123"
        awayTeamNumber: "345"
        startTime: "10:00 pm"
        endTime: ""
        tableType: "Coin-Operated"
        leagueMatchId: 1

    it "should be able to take a json object and fill its own values", ->
      leagueMatch = new $CS.Models.NineBall.LeagueMatch(
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
                name: "PlayerOne"
                rank: 1
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: true
              two:
                name: "Player2"
                rank: 1
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: false
  
            currentGame:
              playerOneScore: 0
              playerTwoScore: 0
              numberOfInnings: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: false
              ended: false
              playerOneBallsHitIn: []
              playerTwoBallsHitIn: []
              playerOneDeadBalls: []
              playerTwoDeadBalls: []
              playerOneLastBall: null
              playerTwoLastBall: null
              onBreak: true
              breakingPlayerStillShooting: true
  
            completedGames: []
            ended: false
            originalId: 0
            leagueMatchId: 1
  
          two:
            player:
              one:
                name: "PlayerOne"
                rank: 1
                number: "1"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: false
              two:
                name: "Player2"
                rank: 1
                number: "2"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: true
  
            currentGame:
              playerOneScore: 0
              playerTwoScore: 0
              numberOfInnings: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: false
              ended: false
              playerOneBallsHitIn: []
              playerTwoBallsHitIn: []
              playerOneDeadBalls: []
              playerTwoDeadBalls: []
              playerOneLastBall: null
              playerTwoLastBall: null
              onBreak: true
              breakingPlayerStillShooting: true
  
            completedGames: []
            ended: false
            originalId: 0
            leagueMatchId: 1
  
          three:
            player:
              one:
                name: "PlayerOne"
                rank: 1
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: true
              two:
                name: "Player2"
                rank: 1
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: false
  
            currentGame:
              playerOneScore: 0
              playerTwoScore: 0
              numberOfInnings: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: false
              ended: false
              playerOneBallsHitIn: []
              playerTwoBallsHitIn: []
              playerOneDeadBalls: []
              playerTwoDeadBalls: []
              playerOneLastBall: null
              playerTwoLastBall: null
              onBreak: true
              breakingPlayerStillShooting: true
  
            completedGames: []
            ended: false
            originalId: 0
            leagueMatchId: 1
  
          four:
            player:
              one:
                name: "PlayerOne"
                rank: 1
                number: "1"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: true
              two:
                name: "Player2"
                rank: 1
                number: "2"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: false
    
            currentGame:
              playerOneScore: 0
              playerTwoScore: 0
              numberOfInnings: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: false
              ended: false
              playerOneBallsHitIn: []
              playerTwoBallsHitIn: []
              playerOneDeadBalls: []
              playerTwoDeadBalls: []
              playerOneLastBall: null
              playerTwoLastBall: null
              onBreak: true
              breakingPlayerStillShooting: true
  
            completedGames: []
            ended: false
            originalId: 0
            leagueMatchId: 1
  
          five:
            player:
              one:
                name: "TestPlayer"
                rank: 1
                number: "1"
                teamNumber: "345"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: true
              two:
                name: "Player2"
                rank: 1
                number: "2"
                teamNumber: "123"
                score: 0
                safeties: 0
                nineOnSnaps: 0
                breakAndRuns: 0
                timeoutsTaken: 0
                currentlyUp: false
  
            currentGame:
              playerOneScore: 0
              playerTwoScore: 0
              numberOfInnings: 0
              playerOneNineOnSnap: false
              playerOneBreakAndRun: false
              playerTwoNineOnSnap: false
              playerTwoBreakAndRun: false
              ended: false
              playerOneBallsHitIn: []
              playerTwoBallsHitIn: []
              playerOneDeadBalls: []
              playerTwoDeadBalls: []
              playerOneLastBall: null
              playerTwoLastBall: null
              onBreak: true
              breakingPlayerStillShooting: true
  
            completedGames: []
            ended: false
            originalId: 0
            leagueMatchId: 1

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
      expect(leagueMatch.match.five.player.one.name).toEqual "TestPlayer"
      leagueMatch.match.five.scoreNumberedBall 9
      expect(leagueMatch.match.five.currentGame.getBallsScored()).toEqual [9]
      leagueMatch.match.five.startNewGame()
      expect(leagueMatch.match.five.currentGame.getBallsScored()).toEqual []
      expect(leagueMatch.match.five.completedGames.length).toEqual 1

    it "should be able to take a small json object and fill its own values", ->
      leagueMatch = new $CS.Models.NineBall.LeagueMatch(
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


