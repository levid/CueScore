me = this
@matchTitleBar = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/layout/titlebar-matches.png"
  top: 0
  left: 0
  width: getPlatformWidth()
  height: 44
  isNinePatch: false
)
@matchNumberLabel = Ti.UI.createLabel(
  text: "Match 1"
  color: "#ffffff"
  shadowColor: "#000000"
  textAlign: "center"
  font:
    fontSize: 20
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@previousMatchButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-prev-match.png"
  top: 7
  left: 8
  width: 93
  height: 31
  isNinePatch: false
)
@previousMatchButtonLabel = Ti.UI.createLabel(
  text: "Prev Match"
  color: "#ffffff"
  shadowColor: "#000000"
  left: 13
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@previousMatchButton.add @previousMatchButtonLabel
@nextMatchButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-next-match.png"
  top: 7
  right: 8
  width: 93
  height: 31
  isNinePatch: false
)
@nextMatchButtonLabel = Ti.UI.createLabel(
  text: "Next Match"
  color: "#ffffff"
  shadowColor: "#000000"
  left: 8
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@nextMatchButton.add @nextMatchButtonLabel
@nextMatchButton.addEventListener "click", ->
  me.currentMatchNumber += 1
  me.currentMatchNumber = 1  if me.currentMatchNumber is 6
  me.resetCurrentMatch()

@previousMatchButton.addEventListener "click", ->
  me.currentMatchNumber -= 1
  me.currentMatchNumber = 5  if me.currentMatchNumber is 0
  me.resetCurrentMatch()

@matchTitleBar.add @nextMatchButton
@matchTitleBar.add @previousMatchButton
@matchTitleBar.add @matchNumberLabel
@view.add @matchTitleBar
@playerTitleBar = Ti.UI.createView(
  backgroundImage: "images/match/layout/titlebar-players.png"
  top: 44
  left: 0
  width: getPlatformWidth()
  height: 35
  isNinePatch: false
)
@playerOneContainer = Ti.UI.createView(
  top: 0
  left: 0
  width: 114
  height: 29
)
@playerOneNameLabel = Ti.UI.createLabel(
  text: @currentMatch.PlayerOne.getFirstNameWithInitials()
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 8
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOneBallCountLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerOne.BallCount else @currentMatch.PlayerOne.getGamesNeededToWin())
  color: "#afd5f1"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 98
  top: 5
  height: 20
  font:
    fontSize: 14
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwoContainer = Ti.UI.createView(
  top: 0
  right: 0
  width: 111
  height: 29
)
@playerTwoNameLabel = Ti.UI.createLabel(
  text: @currentMatch.PlayerTwo.getFirstNameWithInitials()
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 29
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwoBallCountLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerTwo.BallCount else @currentMatch.PlayerTwo.getGamesNeededToWin())
  color: "#afd5f1"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  left: 0
  top: 5
  height: 20
  font:
    fontSize: 14
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@gameNumberLabel = Ti.UI.createLabel(
  text: "Game " + currentMatch.getCurrentGameNumber()
  color: "#ffffff"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  top: 5
  left: 111
  width: 100
  Height: 19
  textAlign: "center"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOneContainer.add @playerOneNameLabel
@playerOneContainer.add @playerOneBallCountLabel
@playerTitleBar.add @playerOneContainer
@playerTwoContainer.add @playerTwoNameLabel
@playerTwoContainer.add @playerTwoBallCountLabel
@playerTitleBar.add @playerTwoContainer
@playerTitleBar.add @gameNumberLabel
@view.add @playerTitleBar
@matchScoreBox = Ti.UI.createView(
  backgroundImage: "images/match/layout/smallbox-matchpoints.png"
  top: 85
  width: 59
  height: 25
)
@matchScoreLabel = Ti.UI.createLabel(
  text: "Match Score"
  color: "#ffffff"
  shadowColor: "#053204"
  shadowOffset:
    x: 1
    y: 1

  top: 110
  width: 80
  height: 20
  textAlign: "center"
  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchScorePointsLabel = Ti.UI.createLabel(
  text: @currentMatch.getMatchPoints()
  color: "#afd5f1"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  top: 0
  height: 25
  width: 50
  textAlign: "center"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@matchScoreBox.add @matchScorePointsLabel
@view.add @matchScoreLabel
@view.add @matchScoreBox
@playerOnePocket = Ti.UI.createView(
  top: 69
  left: 0
  width: 96
  height: 80
)
@playerOneCurrentlyShootingBall = Ti.UI.createImageView(
  backgroundImage: "images/match/icons/icon-currentlyshooting.png"
  top: 6
  left: 3
  width: 19
  height: 19
  isNinePatch: false
)
@playerOneScoreLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerOne.getScore() else @currentMatch.getPlayerOneGamesWon().toString())
  color: "#ffffff"
  shadowColor: "#000000"
  top: 1
  left: 30
  width: 40
  height: 50
  textAlign: "center"
  font:
    fontSize: 35
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOneBallsRemainingBox = Ti.UI.createView(
  backgroundImage: "images/match/layout/indicator-pointsneededtowin.png"
  top: 44
  left: 16
  width: 38
  height: 29
  isNinePatch: false
)
@playerOneBallsRemainingLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerOne.getRemainingBallCount() else @currentMatch.getPlayerOneRemainingGamesNeededToWin())
  color: "#c4eca3"
  top: 0
  width: 37
  height: 24
  shadowColor: "#053204"
  shadowOffset:
    x: 1
    y: 1

  textAlign: "center"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOne9BLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerOne.getNineOnSnaps() else @currentMatch.PlayerOne.getEightOnSnaps())
  color: "#afd5f1"
  top: 43
  left: 56
  height: 16
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOne9BTitleLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then "9B" else "8B")
  color: "#ffffff"
  top: 43
  left: 65
  height: 16
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOne9BRLabel = Ti.UI.createLabel(
  text: @currentMatch.PlayerOne.getBreakAndRuns()
  color: "#afd5f1"
  top: 55
  left: 56
  height: 16
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOne9BRTitleLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then "9BR" else "8BR")
  color: "#ffffff"
  top: 55
  left: 65
  height: 16
  width: "auto"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerOneBallsRemainingBox.add @playerOneBallsRemainingLabel
@playerOnePocket.add @playerOneCurrentlyShootingBall
@playerOnePocket.add @playerOne9BLabel
@playerOnePocket.add @playerOne9BTitleLabel
@playerOnePocket.add @playerOne9BRLabel
@playerOnePocket.add @playerOne9BRTitleLabel
@playerOnePocket.add @playerOneBallsRemainingBox
@playerOnePocket.add @playerOneScoreLabel
@view.add @playerOnePocket
@playerTwoPocket = Ti.UI.createView(
  top: 69
  left: 222
  width: 96
  height: 80
)
@playerTwoCurrentlyShootingBall = Ti.UI.createImageView(
  backgroundImage: "images/match/icons/icon-currentlyshooting.png"
  top: 6
  left: 76
  width: 19
  height: 19
  visible: false
  isNinePatch: false
)
@playerTwoScoreLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerTwo.getScore() else @currentMatch.getPlayerTwoGamesWon().toString())
  color: "#ffffff"
  shadowColor: "#000000"
  top: 1
  left: 30
  width: 40
  height: 50
  textAlign: "center"
  font:
    fontSize: 35
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwoBallsRemainingBox = Ti.UI.createView(
  backgroundImage: "images/match/layout/indicator-pointsneededtowin.png"
  top: 44
  left: 16
  width: 38
  height: 29
  isNinePatch: false
)
@playerTwoBallsRemainingLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerTwo.getRemainingBallCount() else @currentMatch.getPlayerTwoRemainingGamesNeededToWin())
  color: "#c4eca3"
  top: 0
  width: 37
  height: 24
  shadowColor: "#053204"
  shadowOffset:
    x: 1
    y: 1

  textAlign: "center"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwo9BLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then @currentMatch.PlayerTwo.getNineOnSnaps() else @currentMatch.PlayerTwo.getEightOnSnaps())
  color: "#afd5f1"
  top: 43
  left: 56
  height: 16
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwo9BTitleLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then "9B" else "8B")
  color: "#ffffff"
  top: 43
  left: 65
  height: 16
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwo9BRLabel = Ti.UI.createLabel(
  text: @currentMatch.PlayerTwo.getBreakAndRuns()
  color: "#afd5f1"
  top: 55
  left: 56
  height: 16
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwo9BRTitleLabel = Ti.UI.createLabel(
  text: (if (@leagueMatch.GameType is "NineBall") then "9BR" else "8BR")
  color: "#ffffff"
  top: 55
  left: 65
  height: 16
  width: "auto"
  shadowColor: "#000000"
  shadowOffset:
    x: 1
    y: 1

  font:
    fontSize: 12
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@playerTwoBallsRemainingBox.add @playerTwoBallsRemainingLabel
@playerTwoPocket.add @playerTwoCurrentlyShootingBall
@playerTwoPocket.add @playerTwo9BLabel
@playerTwoPocket.add @playerTwo9BTitleLabel
@playerTwoPocket.add @playerTwo9BRLabel
@playerTwoPocket.add @playerTwo9BRTitleLabel
@playerTwoPocket.add @playerTwoBallsRemainingBox
@playerTwoPocket.add @playerTwoScoreLabel
@view.add @playerTwoPocket