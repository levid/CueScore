me = this
@buttonShelfBar = Ti.UI.createView(
  backgroundColor: "transparent"
  bottom: 72
  left: 0
  width: getPlatformWidth()
  height: 37
)
@buttonShelfContainer = Ti.UI.createView(
  backgroundColor: "transparent"
  bottom: 0
  width: 260
  height: 37
)
@buttonShelf = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/layout/shelf-for-buttons.png"
  bottom: 0
  top: 20
  width: 260
  height: 29
  isNinePatch: false
)
@buttonContainer = Ti.UI.createView(
  backgroundColor: "transparent"
  top: 0
  width: 235
  height: 28
)
@safetyButtonContainer = Ti.UI.createView(
  backgroundColor: "transparent"
  top: 0
  left: 0
  width: 132
  height: 28
)
@safetyButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-safety.png"
  top: 0
  left: 0
  width: 132
  height: 28
  isNinePatch: false
)
@safetySelectedButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-safety-selected.png"
  top: 0
  left: 0
  width: 132
  height: 28
  visible: false
  isNinePatch: false
)
@safetyButtonNameLabel = Ti.UI.createLabel(
  text: "Safety"
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 30
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  touchEnabled: false
)
@safetyButtonNumberLabel = Ti.UI.createLabel(
  text: @currentMatch.getTotalSafeties()
  color: "#afd5f1"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 74
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  touchEnabled: false
)
@timeoutButtonContainer = Ti.UI.createView(
  backgroundColor: "transparent"
  top: 0
  right: 0
  width: 100
  height: 28
)
@timeoutButton = Ti.UI.createView(
  color: "#fff"
  backgroundImage: "images/match/buttons/btn-timeout.png"
  top: 0
  left: 0
  width: 100
  height: 28
  isNinePatch: false
)
@timeoutSelectedButton = Ti.UI.createView(
  color: "#fff"
  backgroundImage: "images/match/buttons/btn-timeout-selected.png"
  top: 0
  right: 0
  width: 100
  height: 28
  visible: false
  isNinePatch: false
)
@timeoutButtonNameLabel = Ti.UI.createLabel(
  text: "Timeout"
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 28
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@timeoutButtonNumberLabel = Ti.UI.createLabel(
  text: @currentMatch.CurrentGame.getCurrentPlayerRemainingTimeouts()
  color: "#afd5f1"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 83
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@setSafteyBackground = ->
  me.safetyButton.backgroundImage = "images/match/buttons/btn-safety.png"
  me.safetyButton.hide()
  me.safetyButton.show()

@showSelectedSafety = (turnOn) ->
  me.safetyButton.visible = not turnOn
  me.safetySelectedButton.visible = turnOn

@showSelectedTimeout = (turnOn) ->
  me.timeoutButton.visible = not turnOn
  me.timeoutSelectedButton.visible = turnOn

@safetyButtonClick = ->
  if me.currentMatch.CurrentGame.OnBreak is true
    showOverlay "Must end break first!", 300
    return
  me.showSelectedSafety true
  me.currentMatch.hitSafety()
  me.saveAndUpdateUI()
  me.showSelectedSafety false

@timeoutButtonClick = ->
  me.showSelectedTimeout true
  me.currentMatch.CurrentGame.takeTimeout()
  me.saveAndUpdateUI()
  me.showSelectedTimeout false

@safetyButton.addEventListener "click", @safetyButtonClick
@safetyButtonNumberLabel.addEventListener "click", @safetyButtonClick
@safetyButtonNameLabel.addEventListener "click", @safetyButtonClick
@timeoutButton.addEventListener "click", @timeoutButtonClick
@timeoutButtonNumberLabel.addEventListener "click", @timeoutButtonClick
@timeoutButtonNameLabel.addEventListener "click", @timeoutButtonClick
@buttonShelfContainer.add @buttonShelf
@safetyButtonContainer.add @safetyButton
@safetyButtonContainer.add @safetySelectedButton
@safetyButtonContainer.add @safetyButtonNameLabel
@safetyButtonContainer.add @safetyButtonNumberLabel
@buttonContainer.add @safetyButtonContainer
@timeoutButtonContainer.add @timeoutButton
@timeoutButtonContainer.add @timeoutSelectedButton
@timeoutButtonContainer.add @timeoutButtonNameLabel
@timeoutButtonContainer.add @timeoutButtonNumberLabel
@buttonContainer.add @timeoutButtonContainer
@buttonShelfContainer.add @buttonContainer
@buttonShelfBar.add @buttonShelfContainer
@view.add @buttonShelfBar
@getInningText = ->
  if @currentMatch.getTotalInnings() is 1
    "Inning"
  else
    "Innings"

@getDeadBallText = ->
  if @leagueMatch.GameType is "NineBall"
    if @currentMatch.getTotalDeadBalls() is 1
      "Dead Ball"
    else
      "Dead Balls"

@statusBarInformation = Ti.UI.createView(
  backgroundImage: "images/match/layout/statusbar-messages.png"
  bottom: 44
  left: 0
  width: getPlatformWidth()
  height: 28
  isNinePatch: false
)
@statusBarInformationGreen = Ti.UI.createView(
  backgroundImage: "images/match/layout/statusbar-messages-green.png"
  bottom: 44
  left: 0
  width: getPlatformWidth()
  height: 28
  isNinePatch: false
)
@statusBarInformationGreen.visible = false
@statusBarInformationLabel = Ti.UI.createLabel(
  text: @currentMatch.CurrentGame.getCurrentlyUpPlayer().getFirstNameWithInitials() + " is currently breaking in game " + @currentMatch.getCurrentGameNumber()
  color: "#ffffff"
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@statusBar = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/layout/statusbar.png"
  bottom: 44
  left: 0
  width: getPlatformWidth()
  height: 28
  isNinePatch: false
  visible: false
)
@gameScoreView = Ti.UI.createView(
  backgroundColor: "transparent"
  left: 0
  width: 125
  height: 28
)
@gameScoreNameLabel = Ti.UI.createLabel(
  text: "Game Score"
  color: "#ffffff"
  left: 8
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@gameScoreLabel = Ti.UI.createLabel(
  text: @currentMatch.CurrentGame.getGameScore()
  color: "#afd5f1"
  left: 90
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@gameScoreView.add @gameScoreNameLabel
@gameScoreView.add @gameScoreLabel
@inningsView = Ti.UI.createView(
  backgroundColor: "transparent"
  left: 121
  width: 93
  height: 28
)
@inningsPencilImage = Ti.UI.createImageView(
  backgroundImage: "images/match/icons/icon-edit.png"
  left: 6
  width: 12
  height: 13
  isNinePatch: false
)
@inningsNumberLabel = Ti.UI.createLabel(
  text: @currentMatch.getTotalInnings()
  color: "#afd5f1"
  left: 19
  width: 18
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@inningsNameLabel = Ti.UI.createLabel(
  text: getInningText()
  color: "#ffffff"
  left: 37
  width: 56
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@inningsView.add @inningsPencilImage
@inningsView.add @inningsNumberLabel
@inningsView.add @inningsNameLabel
@deadBallView = Ti.UI.createView(
  backgroundColor: "transparent"
  left: 215
  width: 105
  height: 28
)
@deadBallPencilImage = Ti.UI.createImageView(
  backgroundImage: "images/match/icons/icon-edit.png"
  left: 2
  width: 12
  height: 13
  isNinePatch: false
)
@deadBallNumberLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.getTotalDeadBalls() else "0")
  color: "#afd5f1"
  left: 16
  width: 18
  textAlign: "center"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@deadBallNameLabel = Ti.UI.createLabel(
  text: "Dead Balls"
  color: "#ffffff"
  left: 34
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@deadBallView.add @deadBallPencilImage
@deadBallView.add @deadBallNumberLabel
@deadBallView.add @deadBallNameLabel
@statusBarInformation.add @statusBarInformationLabel
@statusBar.add @deadBallView
@statusBar.add @gameScoreView
@statusBar.add @inningsView
@view.add @statusBarInformationGreen
@view.add @statusBarInformation
@view.add @statusBar
me = this
@buttonFooterBar = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/layout/footerbar.png"
  bottom: 0
  left: 0
  width: getPlatformWidth()
  height: 44
  isNinePatch: false
)
@mainButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-main.png"
  top: 6
  left: 6
  width: 50
  height: 31
  isNinePatch: false
)
@mainButtonLabel = Ti.UI.createLabel(
  text: "Main"
  color: "#ffffff"
  left: 12
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@mainButton.add mainButtonLabel
@gameStatsButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-gamestats.png"
  top: 6
  left: 60
  width: 86
  height: 31
  isNinePatch: false
)
@gameStatsButtonLabel = Ti.UI.createLabel(
  text: "Game Stats"
  color: "#ffffff"
  width: 86
  textAlign: "center"
  shadowColor: "#000000"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@gameStatsButton.add gameStatsButtonLabel
@shotMissedButton = Ti.UI.createButton(
  title: "End Break"
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-shotmissed.png"
  top: 6
  left: 150
  width: 89
  height: 31
  isNinePatch: false
  color: "#ffffff"
  shadowColor: "#1e5523"
  font:
    fontSize: 12.5
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@undoButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-undo.png"
  top: 6
  left: 244
  width: 69
  height: 31
  isNinePatch: false
)
@undoButtonLabel = Ti.UI.createLabel(
  text: "Undo"
  color: "#ffffff"
  left: 27
  shadowColor: "#701613"
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@undoButton.add undoButtonLabel
@mainButton.addEventListener "click", ->
  me.matchWindow.close()

@shotMissedButton.addEventListener "click", ->
  me.currentMatch.shotMissed()
  me.saveAndUpdateUI()

@undoButton.addEventListener "click", ->
  me.showOverlay "Undoing Last Action!", 300, ->
    oldMatchJSON = DataService.undoMatch(@currentMatch.OriginalId)
    if oldMatchJSON?
      oldMatch = (if (@leagueMatch.GameType is "NineBall") then new NineBallMatch() else new EightBallMatch())
      oldMatch.fromJSON oldMatchJSON
      me.setCurrentMatch oldMatch
      me.resetCurrentMatch()
    else
      me.showOverlay "End of History!", 400
      false

@buttonFooterBar.add @undoButton
@buttonFooterBar.add @shotMissedButton
@buttonFooterBar.add @gameStatsButton
@buttonFooterBar.add @mainButton
@view.add @buttonFooterBar