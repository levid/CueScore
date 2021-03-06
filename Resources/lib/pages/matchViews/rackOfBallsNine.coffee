me = this
@ballSelectorContainer = Ti.UI.createImageView(
  backgroundColor: "transparent"
  top: 0
  left: 0
  height: getPlatformHeight()
  width: getPlatformWidth()
)
@ballSelectorContainer.visible = false
@ballView = Ti.UI.createView(
  top: (if (Ti.Platform.name isnt "android") then 125 else 150)
  height: 220
  width: 155
)
@ballOneButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/1ball-large.png"
  top: 168
  left: 54
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballOneBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/1ball-large-inactive.png"
  top: 168
  left: 54
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballOneShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 158
  left: 44
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballTwoButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/2ball-large.png"
  top: 128
  left: 32
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTwoBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/2ball-large-inactive.png"
  top: 128
  left: 32
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTwoShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 118
  left: 23
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballThreeButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/3ball-large.png"
  top: 128
  left: 76
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballThreeBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/3ball-large-inactive.png"
  top: 128
  left: 76
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballThreeShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 118
  left: 67
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballFourButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/4ball-large.png"
  top: 88
  left: 99
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFourBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/4ball-large-inactive.png"
  top: 88
  left: 99
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFourShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 78
  left: 90
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballFiveButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/5ball-large.png"
  top: 88
  left: 10
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFiveBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/5ball-large-inactive.png"
  top: 88
  left: 10
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFiveShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 78
  left: 0
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballSixButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/6ball-large.png"
  top: 48
  left: 32
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballSixBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/6ball-large-inactive.png"
  top: 48
  left: 32
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballSixShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 38
  left: 23
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballSevenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/7ball-large.png"
  top: 48
  left: 77
  opacity: 1
  width: 47
  height: 47
)
@ballSevenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/7ball-large-inactive.png"
  top: 48
  left: 77
  opacity: 1
  width: 47
  height: 47
)
@ballSevenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 38
  left: 68
  opacity: 1
  width: 66
  height: 66
)
@ballEightButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/8ball-large.png"
  top: 10
  left: 54
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballEightBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/8ball-large-inactive.png"
  top: 10
  left: 54
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballEightShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 0
  left: 45
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballNineButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/9ball-large.png"
  top: 88
  left: 55
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballNineBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/largeballs/9ball-large-inactive.png"
  top: 88
  left: 55
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballNineShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 78
  left: 45
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballSelectorContainer.addEventListener "click", ->
  me.closeBallSelector()

@ballOneButton.addEventListener "click", ->
  me.showBallSelector me.ballOneButton.top, me.ballOneButton.left, me.ballOneButton.height, me.ballOneButton.width, "1"

@ballTwoButton.addEventListener "click", ->
  me.showBallSelector me.ballTwoButton.top, me.ballTwoButton.left, me.ballTwoButton.height, me.ballTwoButton.width, "2"

@ballThreeButton.addEventListener "click", ->
  me.showBallSelector me.ballThreeButton.top, me.ballThreeButton.left, me.ballThreeButton.height, me.ballThreeButton.width, "3"

@ballFourButton.addEventListener "click", ->
  me.showBallSelector me.ballFourButton.top, me.ballFourButton.left, me.ballFourButton.height, me.ballFourButton.width, "4"

@ballFiveButton.addEventListener "click", ->
  me.showBallSelector me.ballFiveButton.top, me.ballFiveButton.left, me.ballFiveButton.height, me.ballFiveButton.width, "5"

@ballSixButton.addEventListener "click", ->
  me.showBallSelector me.ballSixButton.top, me.ballSixButton.left, me.ballSixButton.height, me.ballSixButton.width, "6"

@ballSevenButton.addEventListener "click", ->
  me.showBallSelector me.ballSevenButton.top, me.ballSevenButton.left, me.ballSevenButton.height, me.ballSevenButton.width, "7"

@ballEightButton.addEventListener "click", ->
  me.showBallSelector me.ballEightButton.top, me.ballEightButton.left, me.ballEightButton.height, me.ballEightButton.width, "8"

@ballNineButton.addEventListener "click", ->
  me.showBallSelector me.ballNineButton.top, me.ballNineButton.left, me.ballNineButton.height, me.ballNineButton.width, "9"

@ballView.add @ballOneShadow
@ballView.add @ballTwoShadow
@ballView.add @ballThreeShadow
@ballView.add @ballFourShadow
@ballView.add @ballFiveShadow
@ballView.add @ballSixShadow
@ballView.add @ballSevenShadow
@ballView.add @ballEightShadow
@ballView.add @ballNineShadow
@ballView.add @ballOneBg
@ballView.add @ballTwoBg
@ballView.add @ballThreeBg
@ballView.add @ballFourBg
@ballView.add @ballFiveBg
@ballView.add @ballSixBg
@ballView.add @ballSevenBg
@ballView.add @ballEightBg
@ballView.add @ballNineBg
@ballView.add @ballOneButton
@ballView.add @ballTwoButton
@ballView.add @ballThreeButton
@ballView.add @ballFourButton
@ballView.add @ballFiveButton
@ballView.add @ballSixButton
@ballView.add @ballSevenButton
@ballView.add @ballEightButton
@ballView.add @ballNineButton
@view.add @ballSelectorContainer
@view.add @ballView
@showBallSelector = (top, left, height, width, ballNumber) ->
  centerTop = ((height / 2) + top + @ballView.top)
  centerLeft = (width / 2) + left + (@getPlatformWidth() / 2) - (@ballView.width / 2)
  @centerBallSelector centerTop, centerLeft, ballNumber

@closeBallSelector = ->
  @closeOverlay()

@updateShownBalls = ->
  ballsIn = @currentMatch.CurrentGame.getBallsHitIn()
  @ballOneButton.visible = not (ballsIn.exists(1))
  @ballTwoButton.visible = not (ballsIn.exists(2))
  @ballThreeButton.visible = not (ballsIn.exists(3))
  @ballFourButton.visible = not (ballsIn.exists(4))
  @ballFiveButton.visible = not (ballsIn.exists(5))
  @ballSixButton.visible = not (ballsIn.exists(6))
  @ballSevenButton.visible = not (ballsIn.exists(7))
  @ballEightButton.visible = not (ballsIn.exists(8))
  @ballNineButton.visible = not (ballsIn.exists(9))
  @ballOneShadow.visible = not (ballsIn.exists(1))
  @ballTwoShadow.visible = not (ballsIn.exists(2))
  @ballThreeShadow.visible = not (ballsIn.exists(3))
  @ballFourShadow.visible = not (ballsIn.exists(4))
  @ballFiveShadow.visible = not (ballsIn.exists(5))
  @ballSixShadow.visible = not (ballsIn.exists(6))
  @ballSevenShadow.visible = not (ballsIn.exists(7))
  @ballEightShadow.visible = not (ballsIn.exists(8))
  @ballNineShadow.visible = not (ballsIn.exists(9))
  @updatePlayerOneBalls()
  @updatePlayerTwoBalls()