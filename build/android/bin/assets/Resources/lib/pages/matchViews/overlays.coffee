me = this
@winnerOverlayContainer = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg-endgame.png"
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (getPlatformHeight() - 44)
  width: getPlatformWidth()
  visible: false
)
@winnerOverlayContainer.visible = false
@winnerOverlay = Ti.UI.createView(
  backgroundColor: "transparent"
  top: 155
  width: 215
  height: 174
  isNinePatch: false
  visible: false
)
@greyOverlay = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/layout/notification-endgame-winner.png"
  top: 0
  width: 215
  height: 57
  isNinePatch: false
)
@nameOfWinnerLabel = Ti.UI.createLabel(
  text: ""
  color: "#FCD21C"
  top: 3
  width: 215
  height: 30
  textAlign: "center"
  font:
    fontSize: 27
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@winnerOfGameNumberLabel = Ti.UI.createLabel(
  text: "wins game " + @currentMatch.getCurrentGameNumber()
  color: "#ffffff"
  height: 20
  width: 215
  top: 34
  textAlign: "center"
  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@greyOverlay.add @nameOfWinnerLabel
@greyOverlay.add @winnerOfGameNumberLabel
@continueMatchButton = Ti.UI.createButton(
  backgroundImage: "images/match/buttons/btn-continue-match.png"
  top: 71
  width: 166
  height: 39
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  title: "Continue Match"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
)
@editHistoryButton = Ti.UI.createButton(
  backgroundImage: "images/match/buttons/btn-edit-history.png"
  top: 116
  width: 114
  height: 27
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  title: "Edit History"
  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
)
continueMatchButton.addEventListener "click", ->
  me.winnerOverlay.visible = false
  me.winnerOverlayContainer.visible = false
  me.currentMatch.startNewGame()
  me.updateUI()

@winnerOverlay.add @greyOverlay
@winnerOverlay.add @continueMatchButton
@winnerOverlay.add @editHistoryButton
@view.add @winnerOverlayContainer
@view.add @winnerOverlay
@showFinishedGameOverlay = ->
  @nameOfWinnerLabel.text = @currentMatch.CurrentGame.getWinningPlayerName()
  unless @nameOfWinnerLabel.text is "Tie"
    @winnerOfGameNumberLabel.text = "wins game " + @currentMatch.getCurrentGameNumber()
  else
    @winnerOfGameNumberLabel.text = "Game " + @currentMatch.getCurrentGameNumber() + " ends in a Tie."
  @winnerOverlay.visible = true
  @winnerOverlayContainer.visible = true

@hideFinishedGameOverlay = ->
  @winnerOverlay.visible = false
  @winnerOverlayContainer.visible = false

@matchFinishedOverlayContainer = Ti.UI.createView(
  backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (getPlatformHeight() - 44)
  width: getPlatformWidth()
)
@matchFinishedOverlayContainer.visible = false
@matchFinishedLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  height: 40
  width: 300
  top: 18
  textAlign: "center"
  font:
    fontSize: 25
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchFinishedTrophyContainer = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-endmatch-trophy.png"
  backgroundColor: "transparent"
  top: 70
  left: 30
  height: 279
  width: 266
)
@matchFinishedTrophy = Ti.UI.createView(
  backgroundImage: "images/match/icons/endmatch-trophy.png"
  backgroundColor: "transparent"
  top: 15
  left: 45
  height: 246
  width: 224
)
@matchFinishedTrophyContainer.add @matchFinishedTrophy
@matchFinishedMatchResultsButton = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-startmatch.png"
  height: 39
  width: 166
  bottom: 18
)
@matchFinishedMatchResultsButtonLabel = Ti.UI.createLabel(
  text: "Match Results"
  color: "#ffffff"
  top: 8
  left: 0
  height: 20
  width: 166
  textAlign: "center"
  font:
    fontSize: 14
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchFinishedMatchResultsButton.add @matchFinishedMatchResultsButtonLabel
matchFinishedMatchResultsButton.addEventListener "click", ->
  me.currentMatchAtResults()
  me.updateUI()

@matchFinishedOverlayContainer.add @matchFinishedTrophyContainer
@matchFinishedOverlayContainer.add @matchFinishedMatchResultsButton
@matchFinishedOverlayContainer.add @matchFinishedLabel
@view.add @matchFinishedOverlayContainer
@showMatchFinishedOverlay = ->
  @matchFinishedLabel.text = @currentMatch.getWinningPlayer().getFirstNameWithInitials() + " Wins!"
  @matchFinishedOverlayContainer.visible = true

@hideMatchFinishedOverlay = ->
  @matchFinishedOverlayContainer.visible = false

@matchResultsOverlayContainer = Ti.UI.createView(
  backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (getPlatformHeight() - 44)
  width: getPlatformWidth()
)
@matchResultsOverlayContainer.visible = false
@matchResultsLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  height: 40
  width: 300
  top: 18
  textAlign: "center"
  font:
    fontSize: 25
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsTable = Ti.UI.createView(
  backgroundColor: "transparent"
  height: 279
  width: 266
  top: 65
)
@matchResultsPlayerOneTable = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg-matchresults-table-playerone.png"
  height: 279
  width: 266
  visible: false
)
@matchResultsPlayerTwoTable = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg-matchresults-table-playertwo.png"
  height: 279
  width: 266
  visible: false
)
@matchResultsPlayerOneWinnerNameLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  top: 7
  left: 10
  height: 20
  width: 90
  textAlign: "left"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsPlayerTwoWinnerNameLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  top: 7
  right: 10
  height: 20
  width: 90
  textAlign: "right"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsWinnerBall = Ti.UI.createImageView(
  backgroundImage: "images/match/icons/icon-endmatch-9ball-small.png"
  backgroundColor: "transparent"
  top: 0
  height: 31
  width: 31
)
@matchResultsTotalScoreView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 43
)
@matchResultsTotalScoreLabel = Ti.UI.createLabel(
  text: "Total Score"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsTotalScoreView.add @matchResultsTotalScoreLabel
@matchResultsTotalPlayerOneScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 35
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsTotalPlayerTwoScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 35
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsMatchPointsView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 82
)
@matchResultsMatchPointsLabel = Ti.UI.createLabel(
  text: "Match Points"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsMatchPointsView.add @matchResultsMatchPointsLabel
@matchResultsMatchPlayerOnePoints = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 74
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsMatchPlayerTwoPoints = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 74
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsSafetiesView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 121
)
@matchResultsSafetiesLabel = Ti.UI.createLabel(
  text: "Safeties"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsSafetiesView.add @matchResultsSafetiesLabel
@matchResultsPlayerOneSafeties = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 113
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsPlayerTwoSafeties = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 113
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsNineSnapView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 160
)
@matchResultsNineSnapLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then "9 Snaps" else "8 Snaps")
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsNineSnapView.add @matchResultsNineSnapLabel
@matchResultsPlayerOneNineOnSnaps = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 152
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsPlayerTwoNineOnSnaps = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 152
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsBreakAndRunView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 199
)
@matchResultsBreakAndRunLabel = Ti.UI.createLabel(
  text: "Break & Runs"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsBreakAndRunView.add @matchResultsBreakAndRunLabel
@matchResultsPlayerOneBreakAndRuns = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 191
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsPlayerTwoBreakAndRuns = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 191
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsInningsAndDeadballsView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-inning-deadball.png"
  height: 30
  width: 226
  top: 238
)
@matchResultsInningsScore = Ti.UI.createLabel(
  text: ""
  color: "#afd5f1"
  top: 6
  left: 0
  height: 20
  width: 44
  textAlign: "right"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsInningsLabel = Ti.UI.createLabel(
  text: "Innings"
  color: "#ffffff"
  top: 6
  left: 49
  height: 20
  width: 49
  textAlign: "left"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsDeadBallScore = Ti.UI.createLabel(
  text: ""
  color: "#afd5f1"
  top: 6
  left: 98
  height: 20
  width: 27
  textAlign: "right"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsDeadBallLabel = Ti.UI.createLabel(
  text: "Dead Balls"
  color: "#ffffff"
  top: 6
  left: 130
  height: 20
  width: 74
  textAlign: "left"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsEditButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-edit-match.png"
  top: 354
  left: 50
  width: 104
  height: 27
  isNinePatch: false
)
@matchResultsEditButtonLabel = Ti.UI.createLabel(
  text: "Edit Match"
  color: "#ffffff"
  left: 18
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsEditButton.add @matchResultsEditButtonLabel
@matchResultsMainMenuButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-main-menu.png"
  top: 354
  right: 50
  width: 104
  height: 27
  isNinePatch: false
)
@matchResultsMainMenuButtonLabel = Ti.UI.createLabel(
  text: "Main Menu"
  color: "#ffffff"
  left: 16
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchResultsMainMenuButton.add @matchResultsMainMenuButtonLabel
@leagueMatchResultsLeagueMatchResultsButton = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-sign-scoresheets.png"
  top: 354
  width: 131
  height: 27
  isNinePatch: false
)
@leagueMatchResultsLeagueMatchResultsButtonLabel = Ti.UI.createLabel(
  text: "Overall Results"
  color: "#ffffff"
  left: 12
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsLeagueMatchResultsButton.visible = false
@leagueMatchResultsLeagueMatchResultsButton.add @leagueMatchResultsLeagueMatchResultsButtonLabel
@leagueMatchResultsLeagueMatchResultsButton.addEventListener "click", ->
  me.showLeagueMatchResultsOverlay()

@matchResultsMainMenuButtonClick = ->
  me.matchWindow.close()

@matchResultsMainMenuButtonLabel.addEventListener "click", matchResultsMainMenuButtonClick
@matchResultsInningsAndDeadballsView.add @matchResultsInningsScore
@matchResultsInningsAndDeadballsView.add @matchResultsInningsLabel
@matchResultsInningsAndDeadballsView.add @matchResultsDeadBallScore
@matchResultsInningsAndDeadballsView.add @matchResultsDeadBallLabel
@matchResultsTable.add @matchResultsPlayerOneTable
@matchResultsTable.add @matchResultsPlayerTwoTable
@matchResultsTable.add @matchResultsPlayerOneWinnerNameLabel
@matchResultsTable.add @matchResultsPlayerTwoWinnerNameLabel
@matchResultsTable.add @matchResultsWinnerBall
@matchResultsTable.add @matchResultsTotalScoreView
@matchResultsTable.add @matchResultsTotalPlayerOneScore
@matchResultsTable.add @matchResultsTotalPlayerTwoScore
@matchResultsTable.add @matchResultsMatchPointsView
@matchResultsTable.add @matchResultsMatchPlayerOnePoints
@matchResultsTable.add @matchResultsMatchPlayerTwoPoints
@matchResultsTable.add @matchResultsSafetiesView
@matchResultsTable.add @matchResultsPlayerOneSafeties
@matchResultsTable.add @matchResultsPlayerTwoSafeties
@matchResultsTable.add @matchResultsNineSnapView
@matchResultsTable.add @matchResultsPlayerOneNineOnSnaps
@matchResultsTable.add @matchResultsPlayerTwoNineOnSnaps
@matchResultsTable.add @matchResultsBreakAndRunView
@matchResultsTable.add @matchResultsPlayerOneBreakAndRuns
@matchResultsTable.add @matchResultsPlayerTwoBreakAndRuns
@matchResultsTable.add @matchResultsInningsAndDeadballsView
@matchResultsOverlayContainer.add @matchResultsLabel
@matchResultsOverlayContainer.add @matchResultsTable
@matchResultsOverlayContainer.add @matchResultsEditButton
@matchResultsOverlayContainer.add @matchResultsMainMenuButton
@matchResultsOverlayContainer.add @leagueMatchResultsLeagueMatchResultsButton
@view.add @matchResultsOverlayContainer
@showMatchResultsOverlay = ->
  @matchResultsLabel.text = "Match " + @currentMatchNumber + " Results"
  @matchResultsPlayerOneTable.visible = @currentMatch.isPlayerOneWinning()
  @matchResultsPlayerTwoTable.visible = @currentMatch.isPlayerTwoWinning()
  if @currentMatch.isPlayerOneWinning()
    @matchResultsWinnerBall.left = 75
  else
    @matchResultsWinnerBall.left = 150
  @matchResultsPlayerOneWinnerNameLabel.text = @currentMatch.PlayerOne.getFirstNameWithInitials()
  @matchResultsPlayerTwoWinnerNameLabel.text = @currentMatch.PlayerTwo.getFirstNameWithInitials()
  @matchResultsDeadBallScore.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.getTotalDeadBalls() else "0")
  @matchResultsInningsScore.text = @currentMatch.getTotalInnings()
  @matchResultsTotalPlayerOneScore.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerOne.Score.toString() else @currentMatch.getPlayerOneGamesWon().toString())
  @matchResultsTotalPlayerTwoScore.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerTwo.Score.toString() else @currentMatch.getPlayerTwoGamesWon().toString())
  @matchResultsMatchPlayerOnePoints.text = @currentMatch.getPlayerOneMatchPoints().toString()
  @matchResultsMatchPlayerTwoPoints.text = @currentMatch.getPlayerTwoMatchPoints().toString()
  @matchResultsPlayerOneSafeties.text = @currentMatch.PlayerOne.Safeties.toString()
  @matchResultsPlayerTwoSafeties.text = @currentMatch.PlayerTwo.Safeties.toString()
  @matchResultsPlayerOneNineOnSnaps.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerOne.NineOnSnaps.toString() else @currentMatch.PlayerOne.EightOnSnaps.toString())
  @matchResultsPlayerTwoNineOnSnaps.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerTwo.NineOnSnaps.toString() else @currentMatch.PlayerTwo.EightOnSnaps.toString())
  @matchResultsPlayerOneBreakAndRuns.text = @currentMatch.PlayerOne.BreakAndRuns.toString()
  @matchResultsPlayerTwoBreakAndRuns.text = @currentMatch.PlayerTwo.BreakAndRuns.toString()
  if @leagueMatch.Ended() is true
    @matchResultsEditButton.visible = false
    @matchResultsMainMenuButton.visible = false
    @leagueMatchResultsLeagueMatchResultsButton.visible = true
  @matchResultsOverlayContainer.visible = true

@hideMatchResultsOverlay = ->
  @matchResultsOverlayContainer.visible = false

@matchResultsShowSignatureButton = ->
  @matchResultsMainMenuButtonLabel.text = "Sign Match"

@matchResultsShowMainMenuButton = ->
  @matchResultsMainMenuButtonLabel.text = "Main Menu"

@startMatchOverlayContainer = Ti.UI.createView(
  backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
  top: 44
  left: 0
  height: (getPlatformHeight() - 44)
  width: getPlatformWidth()
  visible: false
)
@startMatchTable = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-startmatch-players.png"
  height: 85
  width: 266
  top: 25
)
@playerVsLabel = Ti.UI.createLabel(
  text: "VS"
  color: "#ffffff"
  top: 3
  left: 0
  height: 20
  width: 266
  textAlign: "center"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOneStartNameLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  top: 3
  left: 10
  height: 20
  width: 80
  textAlign: "left"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwoStartNameLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  top: 3
  right: 10
  height: 20
  width: 85
  textAlign: "right"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchPointsNeededToWinView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-startmatch-pointstowin.png"
  height: 34
  width: 110
  top: 40
)
@matchPointsNeededToWinLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then "Points to Win" else "Games to Win")
  color: "#ffffff"
  top: 6
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchPointsNeededToWinView.add @matchPointsNeededToWinLabel
@startMatchPlayerOnePoints = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 35
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@startMatchPlayerTwoPoints = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 35
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@whoIsBreakingLabel = Ti.UI.createLabel(
  text: "Who Breaks First?"
  color: "#ffffff"
  height: 30
  width: 300
  top: 117
  textAlign: "center"
  font:
    fontSize: 22
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@whoIsBreakingSelectorTableBG = Ti.UI.createView(
  backgroundColor: "#0e1115"
  top: 7
  left: 0
  height: 64
  width: 262
)
@whoIsBreakingSelectorTableBGTop = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg_menu_container_top.png"
  top: 0
  left: 0
  height: 7
  width: 262
)
@whoIsBreakingSelectorTableBGBottom = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg_menu_container_bottom.png"
  bottom: 0
  left: 0
  height: 7
  width: 262
)
@whoIsBreakingSelectorTable = Ti.UI.createView(
  backgroundColor: "transparent"
  height: 78
  width: 260
  top: 157
)
@whoIsBreakingSelectorTable.add @whoIsBreakingSelectorTableBGTop
@whoIsBreakingSelectorTable.add @whoIsBreakingSelectorTableBGBottom
@whoIsBreakingSelectorTable.add @whoIsBreakingSelectorTableBG
@whoIsBreakingPlayerOneButton = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-menus-topbutton-wgradient.png"
  height: 36
  width: 254
  left: 3
  top: 3
)
@whoIsBreakingPlayerOneButtonActive = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-menus-topbutton-wgradient-active.png"
  height: 36
  width: 254
  left: 3
  top: 3
  visible: false
)
@whoIsBreakingPlayerOneButtonLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  top: 11
  left: 13
  height: 20
  width: 240
  textAlign: "left"
  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  touchEnabled: false
)
@whoIsBreakingPlayerTwoButton = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-menus-bottombutton-wgradient.png"
  height: 36
  width: 254
  left: 3
  bottom: 3
)
@whoIsBreakingPlayerTwoButtonActive = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-menus-bottombutton-wgradient-active.png"
  height: 36
  width: 254
  left: 3
  bottom: 3
  visible: false
)
@whoIsBreakingPlayerTwoButtonLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  bottom: 11
  left: 13
  height: 20
  width: 240
  textAlign: "left"
  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  touchEnabled: false
)
@whoIsBreakingStartMatchButton = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-startmatch.png"
  height: 39
  width: 166
  top: 250
)
@whoIsBreakingStartMatchButtonLabel = Ti.UI.createLabel(
  text: "Start the Match"
  color: "#ffffff"
  top: 8
  left: 0
  height: 20
  width: 166
  textAlign: "center"
  font:
    fontSize: 14
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@whoIsBreakingStartMatchButton.add @whoIsBreakingStartMatchButtonLabel
@whoIsBreakingForfeitMatchButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-edit-match.png"
  top: 294
  width: 104
  height: 27
  isNinePatch: false
)
@whoIsBreakingForfeitMatchButtonLabel = Ti.UI.createLabel(
  text: "Forfeit"
  color: "#ffffff"
  left: 30
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@whoIsBreakingForfeitMatchButton.add @whoIsBreakingForfeitMatchButtonLabel
@whoIsBreakingSuddenDeathMatchButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-edit-match.png"
  top: 326
  width: 104
  height: 27
  isNinePatch: false
)
@whoIsBreakingSuddenDeathMatchButtonLabel = Ti.UI.createLabel(
  text: "Sudden Death"
  color: "#ffffff"
  left: 7
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@whoIsBreakingSuddenDeathMatchButton.add @whoIsBreakingSuddenDeathMatchButtonLabel
@whoIsBreakingForfeitMatchButton.addEventListener "click", ->
  me.currentMatch.PlayerTwo.CurrentlyUp = true
  me.currentMatch.Ended = true
  me.currentMatch.Forfeit = true
  me.atMatchResults[me.currentMatchNumber] = true
  me.updateUI()

@whoIsBreakingSuddenDeathMatchButton.addEventListener "click", ->
  me.currentMatch.setSuddenDeathMode()
  me.updateUI()

@whoIsBreakingStartMatchButton.addEventListener "click", ->
  if me.currentMatch.PlayerOne.CurrentlyUp is false and me.currentMatch.PlayerTwo.CurrentlyUp is false
    me.showOverlay "Must pick who breaks first!", 300
    return
  if me.currentMatch.PlayerTwo.CurrentlyUp is true
    holdPlayer = me.currentMatch.PlayerOne
    me.currentMatch.PlayerOne = me.currentMatch.PlayerTwo
    me.currentMatch.PlayerTwo = holdPlayer
    me.save()
  me.startCurrentMatch()
  me.updateUI()
  me.startMatchOverlayContainer.visible = false

whoIsBreakingPlayerOneButtonClick = ->
  if me.currentMatch.PlayerOne.CurrentlyUp is false
    me.currentMatch.PlayerOne.CurrentlyUp = true
    me.currentMatch.PlayerTwo.CurrentlyUp = false
    me.updateStartMatchOverlay()

whoIsBreakingPlayerTwoButtonClick = ->
  if me.currentMatch.PlayerTwo.CurrentlyUp is false
    me.currentMatch.PlayerOne.CurrentlyUp = false
    me.currentMatch.PlayerTwo.CurrentlyUp = true
    me.updateStartMatchOverlay()

@whoIsBreakingPlayerOneButton.addEventListener "click", whoIsBreakingPlayerOneButtonClick
@whoIsBreakingPlayerTwoButton.addEventListener "click", whoIsBreakingPlayerTwoButtonClick
@whoIsBreakingPlayerOneButtonLabel.addEventListener "click", whoIsBreakingPlayerOneButtonClick
@whoIsBreakingPlayerTwoButtonLabel.addEventListener "click", whoIsBreakingPlayerTwoButtonClick
@whoIsBreakingSelectorTable.add @whoIsBreakingPlayerOneButtonActive
@whoIsBreakingSelectorTable.add @whoIsBreakingPlayerTwoButtonActive
@whoIsBreakingSelectorTable.add @whoIsBreakingPlayerOneButton
@whoIsBreakingSelectorTable.add @whoIsBreakingPlayerTwoButton
@whoIsBreakingSelectorTable.add @whoIsBreakingPlayerOneButtonLabel
@whoIsBreakingSelectorTable.add @whoIsBreakingPlayerTwoButtonLabel
@startMatchTable.add @playerOneStartNameLabel
@startMatchTable.add @playerTwoStartNameLabel
@startMatchTable.add @playerVsLabel
@startMatchTable.add @matchPointsNeededToWinView
@startMatchTable.add @startMatchPlayerOnePoints
@startMatchTable.add @startMatchPlayerTwoPoints
@startMatchOverlayContainer.add @whoIsBreakingStartMatchButton
@startMatchOverlayContainer.add @whoIsBreakingForfeitMatchButton
@startMatchOverlayContainer.add @whoIsBreakingSuddenDeathMatchButton
@startMatchOverlayContainer.add @whoIsBreakingSelectorTable
@startMatchOverlayContainer.add @whoIsBreakingLabel
@startMatchOverlayContainer.add @startMatchTable
@view.add @startMatchOverlayContainer
@showStartMatchOverlay = ->
  @playerOneStartNameLabel.text = @currentMatch.PlayerOne.getFirstNameWithInitials()
  @playerTwoStartNameLabel.text = @currentMatch.PlayerTwo.getFirstNameWithInitials()
  @whoIsBreakingPlayerOneButtonLabel.text = @currentMatch.PlayerOne.Name
  @whoIsBreakingPlayerTwoButtonLabel.text = @currentMatch.PlayerTwo.Name
  @startMatchPlayerOnePoints.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerOne.BallCount else @currentMatch.PlayerOne.getGamesNeededToWin())
  @startMatchPlayerTwoPoints.text = (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerTwo.BallCount else @currentMatch.PlayerTwo.getGamesNeededToWin())
  @updateStartMatchOverlay()
  @startMatchOverlayContainer.visible = true

@updateStartMatchOverlay = ->
  @whoIsBreakingPlayerOneButton.visible = not (@currentMatch.PlayerOne.CurrentlyUp)
  @whoIsBreakingPlayerOneButtonActive.visible = (@currentMatch.PlayerOne.CurrentlyUp)
  @whoIsBreakingPlayerTwoButton.visible = not (@currentMatch.PlayerTwo.CurrentlyUp)
  @whoIsBreakingPlayerTwoButtonActive.visible = (@currentMatch.PlayerTwo.CurrentlyUp)

@hideStartMatchOverlay = ->
  @startMatchOverlayContainer.visible = false

me = this
@statusOverlayContainer = Ti.UI.createImageView(
  backgroundImage: "/images/match/layout/bg-endgame.png"
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (getPlatformHeight() - 44)
  width: getPlatformWidth()
  visible: false
)
@statusOverlay = Ti.UI.createView(
  backgroundColor: "transparent"
  width: 215
  height: 120
  isNinePatch: false
  visible: false
)
@statusOverlayMessage = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-statusmessages.png"
  backgroundColor: "transparent"
  width: 226
  height: 30
  isNinePatch: false
)
@statusMessage = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  width: 215
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@statusOverlayButton = Ti.UI.createButton(
  backgroundImage: "images/match/buttons/btn-continue-match.png"
  top: 80
  width: 166
  height: 39
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  title: ""
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
  visible: false
)
@statusOverlayButton.addEventListener "click", ->
  me.startCurrentMatch()
  me.fadeOutOverlayFast()

@statusOverlayMessage.add @statusMessage
@statusOverlay.add @statusOverlayMessage
@statusOverlay.add @statusOverlayButton
@view.add @statusOverlayContainer
@view.add @statusOverlay
@fadeOutOverlayFast = (showOverlayCallback) ->
  if @statusOverlay.visible is true
    @statusOverlay.animate
      opacity: 0
      duration: 75
    , ->
      me.statusOverlay.visible = false
      me.statusOverlayContainer.visible = false
      me.statusOverlayButton.visible = false
      me.statusOverlay.opacity = 0
      showOverlayCallback()  if showOverlayCallback?
  else
    showOverlayCallback()  if showOverlayCallback?

@showOverlay = (message, durationSpeed, actionToDoCallback) ->
  @fadeOutOverlayFast ->
    me.statusMessage.text = message
    me.statusOverlay.visible = true
    me.statusOverlay.animate
      opacity: 1
      duration: durationSpeed
    , ->
      return  if actionToDoCallback() is false  if actionToDoCallback?
      setTimeout (->
        me.statusOverlay.animate
          opacity: 0
          duration: durationSpeed
        , ->
          statusOverlay.visible = false
          statusOverlay.opacity = 0
      ), 1000

@showOverlayUntilTap = (message, buttonMessage, durationSpeed) ->
  @fadeOutOverlayFast ->
    me.statusMessage.text = message
    me.statusOverlayButton.title = buttonMessage
    me.statusOverlayContainer.visible = true
    me.statusOverlayButton.visible = true
    me.statusOverlay.visible = true
    me.statusOverlay.animate
      opacity: 1
      duration: 400
    , ->
      me.statusOverlay.opacity = 1

@leagueMatchResultsOverlayContainer = Ti.UI.createView(
  backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (getPlatformHeight() - 44)
  width: getPlatformWidth()
  visible: false
)
@leagueMatchResultsLabel = Ti.UI.createLabel(
  text: "Final Match Results"
  color: "#ffffff"
  height: 40
  width: 300
  top: 18
  textAlign: "center"
  font:
    fontSize: 25
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsTable = Ti.UI.createView(
  backgroundColor: "transparent"
  height: 279
  width: 266
  top: 65
)
@leagueMatchResultsTeamOneTable = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg-leaguematchresults-table-teamone.png"
  height: 279
  width: 266
  visible: false
)
@leagueMatchResultsTeamTwoTable = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg-leaguematchresults-table-teamtwo.png"
  height: 279
  width: 266
  visible: false
)
@leagueMatchResultsTeamOneWinnerNameLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  top: 6
  left: 10
  height: 20
  width: 100
  textAlign: "left"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsTeamTwoWinnerNameLabel = Ti.UI.createLabel(
  text: ""
  color: "#ffffff"
  top: 6
  right: 10
  height: 20
  width: 100
  textAlign: "right"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsWinnerBall = Ti.UI.createImageView(
  backgroundImage: "images/match/icons/icon-endmatch-9ball-small.png"
  backgroundColor: "transparent"
  top: 0
  left: 117
  height: 31
  width: 31
)
@leagueMatchResultsMatchOneScoreView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 43
)
@leagueMatchResultsMatchOneScoreLabel = Ti.UI.createLabel(
  text: "Match One"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchOneScoreView.add @leagueMatchResultsMatchOneScoreLabel
@leagueMatchResultsMatchOneTeamOneScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 35
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchOneTeamTwoScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 35
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchTwoScoreView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 82
)
@leagueMatchResultsMatchTwoScoreLabel = Ti.UI.createLabel(
  text: "Match Two"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchTwoScoreView.add @leagueMatchResultsMatchTwoScoreLabel
@leagueMatchResultsMatchTwoTeamOneScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 74
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchTwoTeamTwoScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 74
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchThreeScoreView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 121
)
@leagueMatchResultsMatchThreeScoreLabel = Ti.UI.createLabel(
  text: "Match Three"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchThreeScoreView.add @leagueMatchResultsMatchThreeScoreLabel
@leagueMatchResultsMatchThreeTeamOneScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 113
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchThreeTeamTwoScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 113
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchFourScoreView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 160
)
@leagueMatchResultsMatchFourScoreLabel = Ti.UI.createLabel(
  text: "Match Four"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchFourScoreView.add @leagueMatchResultsMatchFourScoreLabel
@leagueMatchResultsMatchFourTeamOneScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 152
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchFourTeamTwoScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 152
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchFiveScoreView = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-matchresults-smalltitles.png"
  height: 30
  width: 110
  top: 199
)
@leagueMatchResultsMatchFiveScoreLabel = Ti.UI.createLabel(
  text: "Match Five"
  color: "#ffffff"
  top: 5
  left: 0
  height: 20
  width: 110
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchFiveScoreView.add @leagueMatchResultsMatchFiveScoreLabel
@leagueMatchResultsMatchFiveTeamOneScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 191
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsMatchFiveTeamTwoScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 191
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsTeamOneTotalScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 238
  left: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsTotalScoresLabel = Ti.UI.createLabel(
  text: "Total Scores"
  color: "#ffffff"
  top: 248
  left: 0
  height: 20
  width: 266
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsTeamTwoTotalScore = Ti.UI.createLabel(
  text: ""
  color: "#f8d317"
  top: 238
  right: 0
  height: 35
  width: 77
  textAlign: "center"
  font:
    fontSize: 30
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsEditButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-edit-match.png"
  top: 354
  left: 39
  width: 104
  height: 27
  isNinePatch: false
)
@leagueMatchResultsEditButtonLabel = Ti.UI.createLabel(
  text: "Edit Match"
  color: "#ffffff"
  left: 18
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsEditButton.add @leagueMatchResultsEditButtonLabel
@leagueMatchResultsEditButton.addEventListener "click", ->
  me.matchWindow.visible = false

@leagueMatchResultsSignScoresheetsButton = Ti.UI.createView(
  backgroundImage: "images/match/buttons/btn-sign-scoresheets.png"
  top: 354
  right: 39
  width: 131
  height: 27
  isNinePatch: false
)
@leagueMatchResultsSignScoresheetsButtonLabel = Ti.UI.createLabel(
  text: "Sign Scoresheets"
  color: "#ffffff"
  left: 12
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@leagueMatchResultsSignScoresheetsButton.add @leagueMatchResultsSignScoresheetsButtonLabel
@leagueMatchResultsSignScoresheetsButtonClick = ->
  me.openSignatureView()

@leagueMatchResultsSignScoresheetsButtonLabel.addEventListener "click", @leagueMatchResultsSignScoresheetsButtonClick
@leagueMatchResultsTable.add @leagueMatchResultsTeamOneTable
@leagueMatchResultsTable.add @leagueMatchResultsTeamTwoTable
@leagueMatchResultsTable.add @leagueMatchResultsTeamOneWinnerNameLabel
@leagueMatchResultsTable.add @leagueMatchResultsTeamTwoWinnerNameLabel
@leagueMatchResultsTable.add @leagueMatchResultsWinnerBall
@leagueMatchResultsTable.add @leagueMatchResultsMatchOneScoreView
@leagueMatchResultsTable.add @leagueMatchResultsMatchOneTeamOneScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchOneTeamTwoScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchTwoScoreView
@leagueMatchResultsTable.add @leagueMatchResultsMatchTwoTeamOneScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchTwoTeamTwoScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchThreeScoreView
@leagueMatchResultsTable.add @leagueMatchResultsMatchThreeTeamOneScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchThreeTeamTwoScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchFourScoreView
@leagueMatchResultsTable.add @leagueMatchResultsMatchFourTeamOneScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchFourTeamTwoScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchFiveScoreView
@leagueMatchResultsTable.add @leagueMatchResultsMatchFiveTeamOneScore
@leagueMatchResultsTable.add @leagueMatchResultsMatchFiveTeamTwoScore
@leagueMatchResultsTable.add @leagueMatchResultsTotalScoresLabel
@leagueMatchResultsTable.add @leagueMatchResultsTeamOneTotalScore
@leagueMatchResultsTable.add @leagueMatchResultsTeamTwoTotalScore
@leagueMatchResultsOverlayContainer.add @leagueMatchResultsLabel
@leagueMatchResultsOverlayContainer.add @leagueMatchResultsTable
@leagueMatchResultsOverlayContainer.add @leagueMatchResultsEditButton
@leagueMatchResultsOverlayContainer.add @leagueMatchResultsSignScoresheetsButton
@view.add @leagueMatchResultsOverlayContainer
@showLeagueMatchResultsOverlay = ->
  @leagueMatchResultsTeamOneTable.visible = @leagueMatch.isHomeTeamWinning()
  @leagueMatchResultsTeamTwoTable.visible = @leagueMatch.isAwayTeamWinning()
  @matchNumberLabel.text = "Team " + @leagueMatch.getWinningTeamNumber() + " Wins!"
  @previousMatchButton.visible = false
  @nextMatchButton.visible = false
  @leagueMatchResultsTeamOneWinnerNameLabel.text = "Team " + @leagueMatch.HomeTeamNumber
  @leagueMatchResultsTeamTwoWinnerNameLabel.text = "Team " + @leagueMatch.AwayTeamNumber
  @leagueMatchResultsMatchOneTeamOneScore.text = @leagueMatch.MatchOne.getMatchPointsByTeamNumber(@leagueMatch.HomeTeamNumber).toString()
  @leagueMatchResultsMatchOneTeamTwoScore.text = @leagueMatch.MatchOne.getMatchPointsByTeamNumber(@leagueMatch.AwayTeamNumber).toString()
  @leagueMatchResultsMatchTwoTeamOneScore.text = @leagueMatch.MatchTwo.getMatchPointsByTeamNumber(@leagueMatch.HomeTeamNumber).toString()
  @leagueMatchResultsMatchTwoTeamTwoScore.text = @leagueMatch.MatchTwo.getMatchPointsByTeamNumber(@leagueMatch.AwayTeamNumber).toString()
  @leagueMatchResultsMatchThreeTeamOneScore.text = @leagueMatch.MatchThree.getMatchPointsByTeamNumber(@leagueMatch.HomeTeamNumber).toString()
  @leagueMatchResultsMatchThreeTeamTwoScore.text = @leagueMatch.MatchThree.getMatchPointsByTeamNumber(@leagueMatch.AwayTeamNumber).toString()
  @leagueMatchResultsMatchFourTeamOneScore.text = @leagueMatch.MatchFour.getMatchPointsByTeamNumber(@leagueMatch.HomeTeamNumber).toString()
  @leagueMatchResultsMatchFourTeamTwoScore.text = @leagueMatch.MatchFour.getMatchPointsByTeamNumber(@leagueMatch.AwayTeamNumber).toString()
  @leagueMatchResultsMatchFiveTeamOneScore.text = @leagueMatch.MatchFive.getMatchPointsByTeamNumber(@leagueMatch.HomeTeamNumber).toString()
  @leagueMatchResultsMatchFiveTeamTwoScore.text = @leagueMatch.MatchFive.getMatchPointsByTeamNumber(@leagueMatch.AwayTeamNumber).toString()
  @leagueMatchResultsTeamOneTotalScore.text = @leagueMatch.getHomeTeamMatchPoints().toString()
  @leagueMatchResultsTeamTwoTotalScore.text = @leagueMatch.getAwayTeamMatchPoints().toString()
  @leagueMatchResultsOverlayContainer.visible = true

@hideLeagueMatchOverlay = ->
  @leagueMatchResultsOverlayContainer.visible = false

@leagueMatchResultsShowSignatureButton = ->
  me.leagueMatchResultsMainMenuButtonLabel.text = "Sign Match"

@leagueMatchResultsShowMainMenuButton = ->
  me.leagueMatchResultsMainMenuButtonLabel.text = "Main Menu"