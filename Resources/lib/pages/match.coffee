play = (match) ->
  me = this
  @leagueMatch = match
  @currentMatchNumber = 1
  @matchStarted = [ 0, false, false, false, false, false ]
  @atMatchResults = [ 0, false, false, false, false, false ]
  @hasSentPDF = false
  @currentMatch = @leagueMatch.MatchOne
  @currentMatch.PlayerOne.Score = 0
  @playerOnePocketBg = Ti.UI.createImageView(
    backgroundImage: "images/match/layout/pocket-noglow-player1.png"
    top: 0
    left: 0
    width: 282
    height: 300
    visible: true
    isNinePatch: false
  )
  @playerTwoPocketBg = Ti.UI.createImageView(
    backgroundImage: "images/match/layout/pocket-noglow-player2.png"
    top: 0
    right: 0
    width: 292
    height: 300
    visible: true
    isNinePatch: false
  )
  @playerOnePocketBgGlow = Ti.UI.createImageView(
    backgroundImage: "images/match/layout/pocket-glow-player1.png"
    top: 0
    left: 0
    width: 293
    height: 300
    visible: @currentMatch.PlayerOne.CurrentlyUp
    isNinePatch: false
  )
  @playerTwoPocketBgGlow = Ti.UI.createImageView(
    backgroundImage: "images/match/layout/pocket-glow-player2.png"
    top: 0
    right: 0
    width: 292
    height: 300
    visible: @currentMatch.PlayerTwo.CurrentlyUp
    isNinePatch: false
  )
  @setPlayerUpImages = ->
    if me.currentMatch.PlayerOne.CurrentlyUp is true
      if me.currentMatch.CurrentGame.OnBreak is false and me.playerOneBallsRemainingLabel.color isnt "#ffffff"
        if me.currentMatch.CurrentGame.Ended is false
          showOverlay me.currentMatch.CurrentGame.getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now up!", 400, ->
            me.playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
            me.playerOneBallsRemainingLabel.color = "#ffffff"
            me.playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
            me.playerTwoBallsRemainingLabel.color = "#c4eca3"
        else
          me.playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
          me.playerOneBallsRemainingLabel.color = "#ffffff"
          me.playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
          me.playerTwoBallsRemainingLabel.color = "#c4eca3"
      else
        me.playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
        me.playerOneBallsRemainingLabel.color = "#ffffff"
        me.playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
        me.playerTwoBallsRemainingLabel.color = "#c4eca3"
    else
      if me.currentMatch.CurrentGame.OnBreak is false and playerTwoBallsRemainingLabel.color isnt "#ffffff"
        if me.currentMatch.CurrentGame.Ended is false
          showOverlay me.currentMatch.CurrentGame.getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now up!", 400, ->
            me.playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
            me.playerOneBallsRemainingLabel.color = "#c4eca3"
            me.playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
            me.playerTwoBallsRemainingLabel.color = "#ffffff"
        else
          me.playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
          me.playerOneBallsRemainingLabel.color = "#c4eca3"
          me.playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
          me.playerTwoBallsRemainingLabel.color = "#ffffff"
      else
        me.playerOneBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin.png"
        me.playerOneBallsRemainingLabel.color = "#c4eca3"
        me.playerTwoBallsRemainingBox.backgroundImage = "images/match/layout/indicator-pointsneededtowin-currentplayer.png"
        me.playerTwoBallsRemainingLabel.color = "#ffffff"

  @setEndStartOverlays = ->
    if me.currentMatch.CurrentGame.OnBreak is true
      me.shotMissedButton.title = "End Break"
      me.shotMissedButton.backgroundImage = "images/match/buttons/btn-endbreak.png"
      me.statusBarInformationLabel.text = me.currentMatch.CurrentGame.getCurrentlyUpPlayer().getFirstNameWithInitials() + " is currently breaking in game " + me.currentMatch.getCurrentGameNumber()
      me.statusBarInformationGreen.remove me.statusBarInformationLabel
      me.statusBarInformation.add me.statusBarInformationLabel
      me.statusBarInformation.visible = true
      me.statusBarInformationGreen.visible = false
      me.statusBar.visible = false
      if me.currentMatch.getCurrentGameNumber() > 1 and me.currentMatch.CurrentGame.getBallsHitIn().length < 1
        me.hideStartMatchOverlay()
        me.showOverlay me.currentMatch.CurrentGame.getCurrentlyUpPlayer().getFirstNameWithInitials() + " is breaking!", 400
    else
      me.hideStartMatchOverlay()
      if me.currentMatch.CurrentGame.BreakingPlayerStillHitting is true
        me.shotMissedButton.title = "Shot Missed"
        me.shotMissedButton.backgroundImage = "images/match/buttons/btn-shotmissed.png"
        me.statusBarInformationLabel.text = (if (me.leagueMatch.GameType is "NineBall") then me.currentMatch.CurrentGame.getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now in 9BR contention." else me.currentMatch.CurrentGame.getCurrentlyUpPlayer().getFirstNameWithInitials() + " is now in 8BR contention.")
        me.statusBarInformation.remove me.statusBarInformationLabel
        me.statusBarInformationGreen.add me.statusBarInformationLabel
        me.statusBarInformationGreen.visible = true
        me.statusBarInformation.visible = false
        me.statusBar.visible = false
      else
        me.shotMissedButton.title = "Shot Missed"
        me.shotMissedButton.backgroundImage = "images/match/buttons/btn-shotmissed.png"
        me.statusBarInformation.visible = false
        me.statusBarInformationGreen.visible = false
        me.statusBar.visible = true

  @turnAndroidSignatureLabels = ->
    if Ti.Platform.name is "android"
      if @isSignatureTeamNameTurned is false
        signatureTeamNumberT = Ti.UI.create2DMatrix().setFillAfter(true).rotate(90)
        @signatureTeamName.animate
          transform: signatureTeamNumberT
          duration: 1
      if @isSignatureTeamNumberTurned is false
        signatureTeamNumberT = Ti.UI.create2DMatrix().setFillAfter(true).rotate(90)
        @signatureTeamNumber.animate
          transform: signatureTeamNumberT
          duration: 1

  @updateNineBallUI = ->
    @turnAndroidSignatureLabels()
    me.matchNumberLabel.text = (if (me.currentMatch.Ended isnt true) then "Match " + me.currentMatchNumber else "Finished")
    if me.currentMatch.Ended is true
      me.hideStartMatchOverlay()
      if me.atMatchResults[me.currentMatchNumber] is true
        me.showMatchResultsOverlay()
        me.hideMatchFinishedOverlay()
      else
        me.showMatchFinishedOverlay()
        me.hideMatchResultsOverlay()
      if me.leagueMatch.Ended() is true and me.hasSentPDF is false
        me.hasSentPDF = true
        leagueMatch.SmallJSON = false
        DataService.sendLeagueMatch me.leagueMatch
        me.matchResultsShowSignatureButton()
    else
      @matchResultsOverlayContainer.visible = false
      me.hideMatchResultsOverlay()
      me.hideMatchFinishedOverlay()
      if me.currentMatch.CurrentGame.getBallsHitIn().length < 1 and me.isCurrentMatchStarted() is false
        me.showStartMatchOverlay()
      else
        me.hideStartMatchOverlay()
        if me.currentMatch.CurrentGame.Ended is true
          me.showFinishedGameOverlay()
        else
          me.hideFinishedGameOverlay()
        me.playerOneNameLabel.text = me.currentMatch.PlayerOne.getFirstNameWithInitials()
        me.playerTwoNameLabel.text = me.currentMatch.PlayerTwo.getFirstNameWithInitials()
        me.playerOneBallCountLabel.text = me.currentMatch.PlayerOne.BallCount
        me.playerTwoBallCountLabel.text = me.currentMatch.PlayerTwo.BallCount
        me.gameNumberLabel.text = "Game " + me.currentMatch.getCurrentGameNumber()
        me.playerOneScoreLabel.text = me.currentMatch.PlayerOne.getScore()
        me.playerTwoScoreLabel.text = me.currentMatch.PlayerTwo.getScore()
        me.playerOneBallsRemainingLabel.text = me.currentMatch.PlayerOne.getRemainingBallCount()
        me.playerTwoBallsRemainingLabel.text = me.currentMatch.PlayerTwo.getRemainingBallCount()
        me.setPlayerUpImages()
        me.playerOne9BLabel.text = me.currentMatch.PlayerOne.getNineOnSnaps()
        me.playerTwo9BLabel.text = me.currentMatch.PlayerTwo.getNineOnSnaps()
        me.playerOne9BRLabel.text = me.currentMatch.PlayerOne.getBreakAndRuns()
        me.playerTwo9BRLabel.text = me.currentMatch.PlayerTwo.getBreakAndRuns()
        me.matchScorePointsLabel.text = me.currentMatch.getMatchPoints()
        me.playerOneCurrentlyShootingBall.visible = me.currentMatch.PlayerOne.CurrentlyUp
        me.playerTwoCurrentlyShootingBall.visible = me.currentMatch.PlayerTwo.CurrentlyUp
        me.playerOnePocketBgGlow.visible = me.currentMatch.PlayerOne.CurrentlyUp
        me.playerTwoPocketBgGlow.visible = me.currentMatch.PlayerTwo.CurrentlyUp
        me.safetyButtonNumberLabel.text = me.currentMatch.getTotalSafeties()
        me.timeoutButtonNumberLabel.text = me.currentMatch.CurrentGame.getCurrentPlayerRemainingTimeouts()
        me.gameScoreLabel.text = me.currentMatch.CurrentGame.getGameScore()
        me.inningsNumberLabel.text = me.currentMatch.getTotalInnings()
        me.deadBallNumberLabel.text = me.currentMatch.getTotalDeadBalls()
        me.updateShownBalls()
        me.setEndStartOverlays()

  @updateEightBallUI = ->
    @turnAndroidSignatureLabels()
    me.matchNumberLabel.text = (if (me.currentMatch.Ended isnt true) then "Match " + me.currentMatchNumber else "Finished")
    if me.currentMatch.Ended is true
      unless me.currentMatch.CurrentGame.PlayerOneBallType?
        me.showBallCategorySelector()
      else
        me.hideBallCategorySelector()
        me.hideStartMatchOverlay()
        if me.atMatchResults[me.currentMatchNumber] is true
          me.showMatchResultsOverlay()
          me.hideMatchFinishedOverlay()
        else
          me.showMatchFinishedOverlay()
          me.hideMatchResultsOverlay()
        if me.leagueMatch.Ended() is true
          leagueMatch.SmallJSON = false
          DataService.sendLeagueMatch me.leagueMatch
          me.matchResultsShowSignatureButton()
    else
      if not me.currentMatch.CurrentGame.PlayerOneBallType? and me.currentMatch.ArePlayersSwitching is true and me.currentMatch.CurrentGame.getBallsHitIn().length > 0
        me.showBallCategorySelector()
      else me.hideBallCategorySelector()  if me.ballCategorySelector.visible is true
      @matchResultsOverlayContainer.visible = false
      me.hideMatchResultsOverlay()
      me.hideMatchFinishedOverlay()
      if me.currentMatch.CurrentGame.getBallsHitIn().length < 1 and me.isCurrentMatchStarted() is false
        me.showStartMatchOverlay()
      else
        me.hideStartMatchOverlay()
        if me.currentMatch.CurrentGame.Ended is true
          me.showFinishedGameOverlay()
        else
          me.hideFinishedGameOverlay()
        if @currentMatch.CurrentGame.PlayerOneBallType? and @currentMatch.CurrentGame.PlayerTwoBallType?
          if @currentMatch.CurrentGame.PlayerOneBallType is 1
            @stripedBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(-@stripedBallView.left, 0)
            @solidBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(@getPlatformWidth() - 36 - @solidBallView.left, 0)
            @stripedBallView.animate
              transform: stripedBallViewTransformation
              duration: 1
            , ->
              me.stripedBallView.left = 0  if Ti.Platform.name is "android"

            @solidBallView.animate
              transform: solidBallViewTransformation
              duration: 1
            , ->
              me.solidBallView.left = (me.getPlatformWidth() - 36)  if Ti.Platform.name is "android"
          else
            @stripedBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(@getPlatformWidth() - 36 - @stripedBallView.left, 0)
            @solidBallViewTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(-@solidBallView.left, 0)
            @stripedBallView.animate
              transform: stripedBallViewTransformation
              duration: 1
            , ->
              me.stripedBallView.left = (me.getPlatformWidth() - 36)  if Ti.Platform.name is "android"

            @solidBallView.animate
              transform: solidBallViewTransformation
              duration: 1
            , ->
              me.solidBallView.left = 0  if Ti.Platform.name is "android"
          @stripedBallView.visible = true
          @solidBallView.visible = true
        me.playerOneNameLabel.text = me.currentMatch.PlayerOne.getFirstNameWithInitials()
        me.playerTwoNameLabel.text = me.currentMatch.PlayerTwo.getFirstNameWithInitials()
        me.playerOneBallCountLabel.text = me.currentMatch.PlayerOne.getGamesNeededToWin()
        me.playerTwoBallCountLabel.text = me.currentMatch.PlayerTwo.getGamesNeededToWin()
        me.gameNumberLabel.text = "Game " + me.currentMatch.getCurrentGameNumber()
        me.playerOneScoreLabel.text = me.currentMatch.getPlayerOneGamesWon().toString()
        me.playerTwoScoreLabel.text = me.currentMatch.getPlayerTwoGamesWon().toString()
        me.playerOneBallsRemainingLabel.text = me.currentMatch.getPlayerOneRemainingGamesNeededToWin()
        me.playerTwoBallsRemainingLabel.text = me.currentMatch.getPlayerTwoRemainingGamesNeededToWin()
        me.setPlayerUpImages()
        me.playerOne9BLabel.text = me.currentMatch.PlayerOne.getEightOnSnaps()
        me.playerTwo9BLabel.text = me.currentMatch.PlayerTwo.getEightOnSnaps()
        me.playerOne9BRLabel.text = me.currentMatch.PlayerOne.getBreakAndRuns()
        me.playerTwo9BRLabel.text = me.currentMatch.PlayerTwo.getBreakAndRuns()
        me.matchScorePointsLabel.text = me.currentMatch.getMatchPoints()
        me.playerOneCurrentlyShootingBall.visible = me.currentMatch.PlayerOne.CurrentlyUp
        me.playerTwoCurrentlyShootingBall.visible = me.currentMatch.PlayerTwo.CurrentlyUp
        me.playerOnePocketBgGlow.visible = me.currentMatch.PlayerOne.CurrentlyUp
        me.playerTwoPocketBgGlow.visible = me.currentMatch.PlayerTwo.CurrentlyUp
        me.safetyButtonNumberLabel.text = me.currentMatch.getTotalSafeties()
        me.timeoutButtonNumberLabel.text = me.currentMatch.CurrentGame.getCurrentPlayerRemainingTimeouts()
        me.gameScoreLabel.text = me.currentMatch.CurrentGame.getGameScore()
        me.inningsNumberLabel.text = me.currentMatch.getTotalInnings()
        me.updateShownBalls()
        @matchResultsOverlayContainer.visible = false
        @hideMatchResultsOverlay()
        @hideMatchFinishedOverlay()
        me.setEndStartOverlays()

  @updateUI = ->
    if @leagueMatch.GameType is "NineBall"
      @updateNineBallUI()
    else @updateEightBallUI()  if @leagueMatch.GameType is "EightBall"

  @startCurrentMatch = ->
    @matchStarted[@currentMatchNumber] = true

  @currentMatchAtResults = ->
    @atMatchResults[@currentMatchNumber] = true

  @isCurrentMatchStarted = ->
    @matchStarted[@currentMatchNumber]

  @resetCurrentMatch = ->
    switch @currentMatchNumber
      when 1
        @currentMatch = @leagueMatch.MatchOne
      when 2
        @currentMatch = @leagueMatch.MatchTwo
      when 3
        @currentMatch = @leagueMatch.MatchThree
      when 4
        @currentMatch = @leagueMatch.MatchFour
      when 5
        @currentMatch = @leagueMatch.MatchFive
    @updateUI()

  @setCurrentMatch = (match) ->
    switch @currentMatchNumber
      when 1
        @leagueMatch.MatchOne = match
      when 2
        @leagueMatch.MatchTwo = match
      when 3
        @leagueMatch.MatchThree = match
      when 4
        @leagueMatch.MatchFour = match
      when 5
        @leagueMatch.MatchFive = match
    @updateUI()

  @save = ->
    DataService.saveMatch @currentMatch, (id) ->
      @currentMatch.OriginalId = id

  @saveAndUpdateUI = ->
    @save()
    @updateUI()

  @setCurrentMatchOriginalId = (id) ->
    @currentMatch.OriginalId = id

  @matchWindow = Ti.UI.createWindow(orientationModes: [ Ti.UI.PORTRAIT ])
  @view = Ti.UI.createView(
    backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/background-iphone-wpockets.png" else "images/match/background-android-wpockets.png")
    backgroundColor: "transparent"
    top: 0
    isNinePatch: false
  )
  @view.add playerOnePocketBg
  @view.add playerTwoPocketBg
  @view.add playerOnePocketBgGlow
  @view.add playerTwoPocketBgGlow
  Ti.include "/pages/matchViews/header.js"
  Ti.include "/pages/matchViews/footer.js"
  if @leagueMatch.GameType is "NineBall"
    Ti.include "/pages/matchViews/ballDisplayNine.js"
    Ti.include "/pages/matchViews/rackOfBallsNine.js"
  else if @leagueMatch.GameType is "EightBall"
    Ti.include "/pages/matchViews/ballDisplayEight.js"
    Ti.include "/pages/matchViews/rackOfBallsEight.js"
  Ti.include "/pages/matchViews/ballSelector.js"
  Ti.include "/pages/matchViews/questionsOverlay.js"
  Ti.include "/pages/matchViews/overlays.js"
  unless Ti.Platform.name is "android"
    Ti.include "/pages/matchViews/signatureView-iPhone.js"
  else
    Ti.include "/pages/matchViews/signatureView.js"
  Ti.UI.setBackgroundColor "#000000"
  @matchWindow.add @view
  @showMatch = ->
    unless Ti.Platform.name is "android"
      Ti.UI.iPhone.showStatusBar()
      @matchWindow.open fullscreen: false
      @updateUI()
    else
      @matchWindow.open fullscreen: true
      @updateUI()

  showMatch()
  hideIndicator()
  this