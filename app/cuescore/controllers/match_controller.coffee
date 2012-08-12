# class MatchController
  # opts: {}
#   
  # constructor: (@options) ->
    # @options = _.extend({}, @opts, @options)
# 
    # @leagueMatch = match
    # @currentMatchNumber = 1
    # @matchStarted = [ 0, false, false, false, false, false ]
    # @atMatchResults = [ 0, false, false, false, false, false ]
    # @hasSentPDF = false
    # @currentMatch = @leagueMatch.MatchOne
    # @currentMatch.PlayerOne.Score = 0
    # @playerOnePocketBg = Ti.UI.createImageView(
      # backgroundImage: "images/match/layout/pocket-noglow-player1.png"
      # top: 0
      # left: 0
      # width: 282
      # height: 300
      # visible: true
      # isNinePatch: false
    # )
    # @playerTwoPocketBg = Ti.UI.createImageView(
      # backgroundImage: "images/match/layout/pocket-noglow-player2.png"
      # top: 0
      # right: 0
      # width: 292
      # height: 300
      # visible: true
      # isNinePatch: false
    # )
    # @playerOnePocketBgGlow = Ti.UI.createImageView(
      # backgroundImage: "images/match/layout/pocket-glow-player1.png"
      # top: 0
      # left: 0
      # width: 293
      # height: 300
      # visible: @currentMatch.PlayerOne.CurrentlyUp
      # isNinePatch: false
    # )
    # @playerTwoPocketBgGlow = Ti.UI.createImageView(
      # backgroundImage: "images/match/layout/pocket-glow-player2.png"
      # top: 0
      # right: 0
      # width: 292
      # height: 300
      # visible: @currentMatch.PlayerTwo.CurrentlyUp
      # isNinePatch: false
    # )
#       
    # @matchWindow = Ti.UI.createWindow(orientationModes: [ Ti.UI.PORTRAIT ])
    # @view = Ti.UI.createView(
      # backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/background-iphone-wpockets.png" else "images/match/background-android-wpockets.png")
      # backgroundColor: "transparent"
      # top: 0
      # isNinePatch: false
    # )
    # @view.add playerOnePocketBg
    # @view.add playerTwoPocketBg
    # @view.add playerOnePocketBgGlow
    # @view.add playerTwoPocketBgGlow
    # Ti.include "/pages/matchViews/header.js"
    # Ti.include "/pages/matchViews/footer.js"
    # if @leagueMatch.GameType is "NineBall"
      # Ti.include "/pages/matchViews/ballDisplayNine.js"
      # Ti.include "/pages/matchViews/rackOfBallsNine.js"
    # else if @leagueMatch.GameType is "EightBall"
      # Ti.include "/pages/matchViews/ballDisplayEight.js"
      # Ti.include "/pages/matchViews/rackOfBallsEight.js"
    # Ti.include "/pages/matchViews/ballSelector.js"
    # Ti.include "/pages/matchViews/questionsOverlay.js"
    # Ti.include "/pages/matchViews/overlays.js"
    # unless Ti.Platform.name is "android"
      # Ti.include "/pages/matchViews/signatureView-iPhone.js"
    # else
      # Ti.include "/pages/matchViews/signatureView.js"
    # Ti.UI.setBackgroundColor "#000000"
#     
    # @matchWindow.add @view
#     
    # showMatch: =>
      # unless Ti.Platform.name is "android"
        # Ti.UI.iPhone.showStatusBar()
        # @matchWindow.open fullscreen: false
        # @updateUI()
      # else
        # @matchWindow.open fullscreen: true
        # @updateUI()
#   
    # showMatch()
    # hideIndicator()
#   
  # setPlayerUpImages: ->
    # if @currentMatch.PlayerOne.CurrentlyUp is true
      # if @currentMatch.CurrentGa@OnBreak is false and @playerOneBallsRemainingLabel.color isnt "#ffffff"
        # if @currentMatch.CurrentGa@Ended is false
          # showOverlay @currentMatch.CurrentGa@getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now up!", 400, ->
            # @playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
            # @playerOneBallsRemainingLabel.color = "#ffffff"
            # @playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
            # @playerTwoBallsRemainingLabel.color = "#c4eca3"
        # else
          # @playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
          # @playerOneBallsRemainingLabel.color = "#ffffff"
          # @playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
          # @playerTwoBallsRemainingLabel.color = "#c4eca3"
      # else
        # @playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
        # @playerOneBallsRemainingLabel.color = "#ffffff"
        # @playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
        # @playerTwoBallsRemainingLabel.color = "#c4eca3"
    # else
      # if @currentMatch.CurrentGa@OnBreak is false and playerTwoBallsRemainingLabel.color isnt "#ffffff"
        # if @currentMatch.CurrentGa@Ended is false
          # showOverlay @currentMatch.CurrentGa@getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now up!", 400, ->
            # @playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
            # @playerOneBallsRemainingLabel.color = "#c4eca3"
            # @playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
            # @playerTwoBallsRemainingLabel.color = "#ffffff"
        # else
          # @playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
          # @playerOneBallsRemainingLabel.color = "#c4eca3"
          # @playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
          # @playerTwoBallsRemainingLabel.color = "#ffffff"
      # else
        # @playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
        # @playerOneBallsRemainingLabel.color = "#c4eca3"
        # @playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
        # @playerTwoBallsRemainingLabel.color = "#ffffff"
# 
  # setEndStartOverlays: ->
    # if @currentMatch.CurrentGa@OnBreak is true
      # @shotMissedButton.title = "End Break"
      # @shotMissedButton.backgroundImage = "images/match/buttons/btn-endbreak.png"
      # @statusBarInformationLabel.text = @currentMatch.CurrentGa@getCurrentlyUpPlayer().getFirstNameWithInitials() + " is currently breaking in game " + @currentMatch.getCurrentGameNumber()
      # @statusBarInformationGreen.remove @statusBarInformationLabel
      # @statusBarInformation.add @statusBarInformationLabel
      # @statusBarInformation.visible = true
      # @statusBarInformationGreen.visible = false
      # @statusBar.visible = false
      # if @currentMatch.getCurrentGameNumber() > 1 and @currentMatch.CurrentGa@getBallsHitIn().length < 1
        # @hideStartMatchOverlay()
        # @showOverlay @currentMatch.CurrentGa@getCurrentlyUpPlayer().getFirstNameWithInitials() + " is breaking!", 400
    # else
      # @hideStartMatchOverlay()
      # if @currentMatch.CurrentGa@BreakingPlayerStillHitting is true
        # @shotMissedButton.title = "Shot Missed"
        # @shotMissedButton.backgroundImage = "images/match/buttons/btn-shotmissed.png"
        # @statusBarInformationLabel.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.CurrentGa@getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now in 9BR contention." else @currentMatch.CurrentGa@getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now in 8BR contention.")
        # @statusBarInformation.remove @statusBarInformationLabel
        # @statusBarInformationGreen.add @statusBarInformationLabel
        # @statusBarInformationGreen.visible = true
        # @statusBarInformation.visible = false
        # @statusBar.visible = false
      # else
        # @shotMissedButton.title = "Shot Missed"
        # @shotMissedButton.backgroundImage = "images/match/buttons/btn-shotmissed.png"
        # @statusBarInformation.visible = false
        # @statusBarInformationGreen.visible = false
        # @statusBar.visible = true
# 
  # turnAndroidSignatureLabels: ->
    # if Ti.Platform.name is "android"
      # if @isSignatureTeamNameTurned is false
        # signatureTeamNumberT = Ti.UI.create2DMatrix().setFillAfter(true).rotate(90)
        # @signatureTeamNa@animate
          # transform: signatureTeamNumberT
          # duration: 1
      # if @isSignatureTeamNumberTurned is false
        # signatureTeamNumberT = Ti.UI.create2DMatrix().setFillAfter(true).rotate(90)
        # @signatureTeamNumber.animate
          # transform: signatureTeamNumberT
          # duration: 1
# 
  # updateNineBallUI: ->
    # @turnAndroidSignatureLabels()
    # @matchNumberLabel.text = (if (@currentMatch.Ended isnt true) then "Match " + @currentMatchNumber else "Finished")
    # if @currentMatch.Ended is true
      # @hideStartMatchOverlay()
      # if @atMatchResults[@currentMatchNumber] is true
        # @showMatchResultsOverlay()
        # @hideMatchFinishedOverlay()
      # else
        # @showMatchFinishedOverlay()
        # @hideMatchResultsOverlay()
      # if @leagueMatch.Ended() is true and @hasSentPDF is false
        # @hasSentPDF = true
        # leagueMatch.SmallJSON = false
        # DataService.sendLeagueMatch @leagueMatch
        # @matchResultsShowSignatureButton()
    # else
      # @matchResultsOverlayContainer.visible = false
      # @hideMatchResultsOverlay()
      # @hideMatchFinishedOverlay()
      # if @currentMatch.CurrentGa@getBallsHitIn().length < 1 and @isCurrentMatchStarted() is false
        # @showStartMatchOverlay()
      # else
        # @hideStartMatchOverlay()
        # if @currentMatch.CurrentGa@Ended is true
          # @showFinishedGameOverlay()
        # else
          # @hideFinishedGameOverlay()
        # @playerOneNameLabel.text = @currentMatch.PlayerOne.getFirstNameWithInitials()
        # @playerTwoNameLabel.text = @currentMatch.PlayerTwo.getFirstNameWithInitials()
        # @playerOneBallCountLabel.text = @currentMatch.PlayerOne.BallCount
        # @playerTwoBallCountLabel.text = @currentMatch.PlayerTwo.BallCount
        # @gameNumberLabel.text = "Game " + @currentMatch.getCurrentGameNumber()
        # @playerOneScoreLabel.text = @currentMatch.PlayerOne.getScore()
        # @playerTwoScoreLabel.text = @currentMatch.PlayerTwo.getScore()
        # @playerOneBallsRemainingLabel.text = @currentMatch.PlayerOne.getRemainingBallCount()
        # @playerTwoBallsRemainingLabel.text = @currentMatch.PlayerTwo.getRemainingBallCount()
        # @setPlayerUpImages()
        # @playerOne9BLabel.text = @currentMatch.PlayerOne.getNineOnSnaps()
        # @playerTwo9BLabel.text = @currentMatch.PlayerTwo.getNineOnSnaps()
        # @playerOne9BRLabel.text = @currentMatch.PlayerOne.getBreakAndRuns()
        # @playerTwo9BRLabel.text = @currentMatch.PlayerTwo.getBreakAndRuns()
        # @matchScorePointsLabel.text = @currentMatch.getMatchPoints()
        # @playerOneCurrentlyShootingBall.visible = @currentMatch.PlayerOne.CurrentlyUp
        # @playerTwoCurrentlyShootingBall.visible = @currentMatch.PlayerTwo.CurrentlyUp
        # @playerOnePocketBgGlow.visible = @currentMatch.PlayerOne.CurrentlyUp
        # @playerTwoPocketBgGlow.visible = @currentMatch.PlayerTwo.CurrentlyUp
        # @safetyButtonNumberLabel.text = @currentMatch.getTotalSafeties()
        # @timeoutButtonNumberLabel.text = @currentMatch.CurrentGa@getCurrentPlayerRemainingTimeouts()
        # @gameScoreLabel.text = @currentMatch.CurrentGa@getGameScore()
        # @inningsNumberLabel.text = @currentMatch.getTotalInnings()
        # @deadBallNumberLabel.text = @currentMatch.getTotalDeadBalls()
        # @updateShownBalls()
        # @setEndStartOverlays()
# 
  # updateEightBallUI: ->
    # @turnAndroidSignatureLabels()
    # @matchNumberLabel.text = (if (@currentMatch.Ended isnt true) then "Match " + @currentMatchNumber else "Finished")
    # if @currentMatch.Ended is true
      # unless @currentMatch.CurrentGa@PlayerOneBallType?
        # @showBallCategorySelector()
      # else
        # @hideBallCategorySelector()
        # @hideStartMatchOverlay()
        # if @atMatchResults[@currentMatchNumber] is true
          # @showMatchResultsOverlay()
          # @hideMatchFinishedOverlay()
        # else
          # @showMatchFinishedOverlay()
          # @hideMatchResultsOverlay()
        # if @leagueMatch.Ended() is true
          # leagueMatch.SmallJSON = false
          # DataService.sendLeagueMatch @leagueMatch
          # @matchResultsShowSignatureButton()
    # else
      # if not @currentMatch.CurrentGa@PlayerOneBallType? and @currentMatch.ArePlayersSwitching is true and @currentMatch.CurrentGa@getBallsHitIn().length > 0
        # @showBallCategorySelector()
      # else @hideBallCategorySelector()  if @ballCategorySelector.visible is true
      # @matchResultsOverlayContainer.visible = false
      # @hideMatchResultsOverlay()
      # @hideMatchFinishedOverlay()
      # if @currentMatch.CurrentGa@getBallsHitIn().length < 1 and @isCurrentMatchStarted() is false
        # @showStartMatchOverlay()
      # else
        # @hideStartMatchOverlay()
        # if @currentMatch.CurrentGa@Ended is true
          # @showFinishedGameOverlay()
        # else
          # @hideFinishedGameOverlay()
        # if @currentMatch.CurrentGa@PlayerOneBallType? and @currentMatch.CurrentGa@PlayerTwoBallType?
          # if @currentMatch.CurrentGa@PlayerOneBallType is 1
            # @stripedBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(-@stripedBallView.left, 0)
            # @solidBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(@getPlatformWidth() - 36 - @solidBallView.left, 0)
            # @stripedBallView.animate
              # transform: stripedBallViewTransformation
              # duration: 1
            # , ->
              # @stripedBallView.left = 0  if Ti.Platform.name is "android"
# 
            # @solidBallView.animate
              # transform: solidBallViewTransformation
              # duration: 1
            # , ->
              # @solidBallView.left = (@getPlatformWidth() - 36)  if Ti.Platform.name is "android"
          # else
            # @stripedBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(@getPlatformWidth() - 36 - @stripedBallView.left, 0)
            # @solidBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(-@solidBallView.left, 0)
            # @stripedBallView.animate
              # transform: stripedBallViewTransformation
              # duration: 1
            # , ->
              # @stripedBallView.left = (@getPlatformWidth() - 36)  if Ti.Platform.name is "android"
# 
            # @solidBallView.animate
              # transform: solidBallViewTransformation
              # duration: 1
            # , ->
              # @solidBallView.left = 0  if Ti.Platform.name is "android"
          # @stripedBallView.visible = true
          # @solidBallView.visible = true
        # @playerOneNameLabel.text = @currentMatch.PlayerOne.getFirstNameWithInitials()
        # @playerTwoNameLabel.text = @currentMatch.PlayerTwo.getFirstNameWithInitials()
        # @playerOneBallCountLabel.text = @currentMatch.PlayerOne.getGamesNeededToWin()
        # @playerTwoBallCountLabel.text = @currentMatch.PlayerTwo.getGamesNeededToWin()
        # @gameNumberLabel.text = "Game " + @currentMatch.getCurrentGameNumber()
        # @playerOneScoreLabel.text = @currentMatch.getPlayerOneGamesWon().toString()
        # @playerTwoScoreLabel.text = @currentMatch.getPlayerTwoGamesWon().toString()
        # @playerOneBallsRemainingLabel.text = @currentMatch.getPlayerOneRemainingGamesNeededToWin()
        # @playerTwoBallsRemainingLabel.text = @currentMatch.getPlayerTwoRemainingGamesNeededToWin()
        # @setPlayerUpImages()
        # @playerOne9BLabel.text = @currentMatch.PlayerOne.getEightOnSnaps()
        # @playerTwo9BLabel.text = @currentMatch.PlayerTwo.getEightOnSnaps()
        # @playerOne9BRLabel.text = @currentMatch.PlayerOne.getBreakAndRuns()
        # @playerTwo9BRLabel.text = @currentMatch.PlayerTwo.getBreakAndRuns()
        # @matchScorePointsLabel.text = @currentMatch.getMatchPoints()
        # @playerOneCurrentlyShootingBall.visible = @currentMatch.PlayerOne.CurrentlyUp
        # @playerTwoCurrentlyShootingBall.visible = @currentMatch.PlayerTwo.CurrentlyUp
        # @playerOnePocketBgGlow.visible = @currentMatch.PlayerOne.CurrentlyUp
        # @playerTwoPocketBgGlow.visible = @currentMatch.PlayerTwo.CurrentlyUp
        # @safetyButtonNumberLabel.text = @currentMatch.getTotalSafeties()
        # @timeoutButtonNumberLabel.text = @currentMatch.CurrentGa@getCurrentPlayerRemainingTimeouts()
        # @gameScoreLabel.text = @currentMatch.CurrentGa@getGameScore()
        # @inningsNumberLabel.text = @currentMatch.getTotalInnings()
        # @updateShownBalls()
        # @matchResultsOverlayContainer.visible = false
        # @hideMatchResultsOverlay()
        # @hideMatchFinishedOverlay()
        # @setEndStartOverlays()
# 
  # updateUI: ->
    # if @leagueMatch.GameType is "NineBall"
      # @updateNineBallUI()
    # else @updateEightBallUI()  if @leagueMatch.GameType is "EightBall"
# 
  # startCurrentMatch: ->
    # @matchStarted[@currentMatchNumber] = true
# 
  # currentMatchAtResults: ->
    # @atMatchResults[@currentMatchNumber] = true
# 
  # isCurrentMatchStarted: ->
    # @matchStarted[@currentMatchNumber]
# 
  # resetCurrentMatch: ->
    # switch @currentMatchNumber
      # when 1
        # @currentMatch = @leagueMatch.MatchOne
      # when 2
        # @currentMatch = @leagueMatch.MatchTwo
      # when 3
        # @currentMatch = @leagueMatch.MatchThree
      # when 4
        # @currentMatch = @leagueMatch.MatchFour
      # when 5
        # @currentMatch = @leagueMatch.MatchFive
    # @updateUI()
# 
  # setCurrentMatch: (match) ->
    # switch @currentMatchNumber
      # when 1
        # @leagueMatch.MatchOne = match
      # when 2
        # @leagueMatch.MatchTwo = match
      # when 3
        # @leagueMatch.MatchThree = match
      # when 4
        # @leagueMatch.MatchFour = match
      # when 5
        # @leagueMatch.MatchFive = match
    # @updateUI()
# 
  # save: ->
    # DataService.saveMatch @currentMatch, (id) ->
      # @currentMatch.OriginalId = id
# 
  # saveAndUpdateUI: ->
    # @save()
    # @updateUI()
# 
  # setCurrentMatchOriginalId: (id) ->
    # @currentMatch.OriginalId = id
# 
# $CS.Controllers.MatchController = MatchController
