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
  height: 235
  width: 251
)
@ballOneButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/1ball-large.png"
  top: 10
  left: 102
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballOneBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/1ball-large-inactive.png"
  top: 10
  left: 102
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballOneShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 0
  left: 92
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballTwoButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/2ball-large.png"
  top: 86
  left: 148
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTwoBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/2ball-large-inactive.png"
  top: 86
  left: 148
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTwoShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 76
  left: 138
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballThreeButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/3ball-large.png"
  top: 162
  left: 148
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballThreeBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/3ball-large-inactive.png"
  top: 162
  left: 148
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballThreeShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 152
  left: 138
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballFourButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/4ball-large.png"
  top: 124
  left: 125
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFourBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/4ball-large-inactive.png"
  top: 124
  left: 125
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFourShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 114
  left: 115
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballFiveButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/5ball-large.png"
  top: 162
  left: 56
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFiveBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/5ball-large-inactive.png"
  top: 162
  left: 56
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFiveShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 152
  left: 46
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballSixButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/6ball-large.png"
  top: 124
  left: 33
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballSixBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/6ball-large-inactive.png"
  top: 124
  left: 33
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballSixShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 114
  left: 23
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballSevenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/7ball-large.png"
  top: 48
  left: 79
  opacity: 1
  width: 47
  height: 47
)
@ballSevenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/7ball-large-inactive.png"
  top: 48
  left: 79
  opacity: 1
  width: 47
  height: 47
)
@ballSevenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 38
  left: 69
  opacity: 1
  width: 66
  height: 66
)
@ballEightButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/8ball-large.png"
  top: 86
  left: 102
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballEightBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/8ball-large-inactive.png"
  top: 86
  left: 102
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballEightShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 76
  left: 92
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballNineButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/9ball-large.png"
  top: 48
  left: 125
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballNineBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/9ball-large-inactive.png"
  top: 48
  left: 125
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballNineShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 38
  left: 115
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballTenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/10ball-large.png"
  top: 162
  left: 10
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/10ball-large-inactive.png"
  top: 162
  left: 10
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 152
  left: 0
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballElevenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/11ball-large.png"
  top: 162
  left: 194
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballElevenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/11ball-large-inactive.png"
  top: 162
  left: 194
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballElevenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 152
  left: 184
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballTwelveButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/12ball-large.png"
  top: 162
  left: 102
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTwelveBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/12ball-large-inactive.png"
  top: 162
  left: 102
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballTwelveShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 152
  left: 92
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballThirteenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/13ball-large.png"
  top: 124
  left: 79
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballThirteenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/13ball-large-inactive.png"
  top: 124
  left: 79
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballThirteenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 114
  left: 69
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballFourteenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/14ball-large.png"
  top: 86
  left: 56
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFourteenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/14ball-large-inactive.png"
  top: 86
  left: 56
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFourteenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 76
  left: 46
  opacity: 1
  width: 66
  height: 66
  isNinePatch: false
)
@ballFifteenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/15ball-large.png"
  top: 124
  left: 171
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFifteenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/8ball/largeballs/15ball-large-inactive.png"
  top: 124
  left: 171
  opacity: 1
  width: 47
  height: 47
  isNinePatch: false
)
@ballFifteenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/largeballs/shadow-large-balls.png"
  top: 114
  left: 161
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

@ballTenButton.addEventListener "click", ->
  me.showBallSelector me.ballTenButton.top, me.ballTenButton.left, me.ballTenButton.height, me.ballTenButton.width, "10"

@ballElevenButton.addEventListener "click", ->
  me.showBallSelector me.ballElevenButton.top, me.ballElevenButton.left, me.ballElevenButton.height, me.ballElevenButton.width, "11"

@ballTwelveButton.addEventListener "click", ->
  me.showBallSelector me.ballTwelveButton.top, me.ballTwelveButton.left, me.ballTwelveButton.height, me.ballTwelveButton.width, "12"

@ballThirteenButton.addEventListener "click", ->
  me.showBallSelector me.ballThirteenButton.top, me.ballThirteenButton.left, me.ballThirteenButton.height, me.ballThirteenButton.width, "13"

@ballFourteenButton.addEventListener "click", ->
  me.showBallSelector me.ballFourteenButton.top, me.ballFourteenButton.left, me.ballFourteenButton.height, me.ballFourteenButton.width, "14"

@ballFifteenButton.addEventListener "click", ->
  me.showBallSelector me.ballFifteenButton.top, me.ballFifteenButton.left, me.ballFifteenButton.height, me.ballFifteenButton.width, "15"

@ballView.add @ballOneShadow
@ballView.add @ballTwoShadow
@ballView.add @ballThreeShadow
@ballView.add @ballFourShadow
@ballView.add @ballFiveShadow
@ballView.add @ballSixShadow
@ballView.add @ballSevenShadow
@ballView.add @ballEightShadow
@ballView.add @ballNineShadow
@ballView.add @ballTenShadow
@ballView.add @ballElevenShadow
@ballView.add @ballTwelveShadow
@ballView.add @ballThirteenShadow
@ballView.add @ballFourteenShadow
@ballView.add @ballFifteenShadow
@ballView.add @ballOneBg
@ballView.add @ballTwoBg
@ballView.add @ballThreeBg
@ballView.add @ballFourBg
@ballView.add @ballFiveBg
@ballView.add @ballSixBg
@ballView.add @ballSevenBg
@ballView.add @ballEightBg
@ballView.add @ballNineBg
@ballView.add @ballTenBg
@ballView.add @ballElevenBg
@ballView.add @ballTwelveBg
@ballView.add @ballThirteenBg
@ballView.add @ballFourteenBg
@ballView.add @ballFifteenBg
@ballView.add @ballOneButton
@ballView.add @ballTwoButton
@ballView.add @ballThreeButton
@ballView.add @ballFourButton
@ballView.add @ballFiveButton
@ballView.add @ballSixButton
@ballView.add @ballSevenButton
@ballView.add @ballEightButton
@ballView.add @ballNineButton
@ballView.add @ballTenButton
@ballView.add @ballElevenButton
@ballView.add @ballTwelveButton
@ballView.add @ballThirteenButton
@ballView.add @ballFourteenButton
@ballView.add @ballFifteenButton
@view.add @ballSelectorContainer
@view.add @ballView
@showBallSelector = (top, left, height, width, ballNumber) ->
  centerTop = ((height / 2) + top + me.ballView.top)
  centerLeft = (width / 2) + left + (me.getPlatformWidth() / 2) - (me.ballView.width / 2)
  me.centerBallSelector centerTop, centerLeft, ballNumber

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
  @ballTenButton.visible = not (ballsIn.exists(10))
  @ballElevenButton.visible = not (ballsIn.exists(11))
  @ballTwelveButton.visible = not (ballsIn.exists(12))
  @ballThirteenButton.visible = not (ballsIn.exists(13))
  @ballFourteenButton.visible = not (ballsIn.exists(14))
  @ballFifteenButton.visible = not (ballsIn.exists(15))
  @ballOneShadow.visible = not (ballsIn.exists(1))
  @ballTwoShadow.visible = not (ballsIn.exists(2))
  @ballThreeShadow.visible = not (ballsIn.exists(3))
  @ballFourShadow.visible = not (ballsIn.exists(4))
  @ballFiveShadow.visible = not (ballsIn.exists(5))
  @ballSixShadow.visible = not (ballsIn.exists(6))
  @ballSevenShadow.visible = not (ballsIn.exists(7))
  @ballEightShadow.visible = not (ballsIn.exists(8))
  @ballNineShadow.visible = not (ballsIn.exists(9))
  @ballTenShadow.visible = not (ballsIn.exists(10))
  @ballElevenShadow.visible = not (ballsIn.exists(11))
  @ballTwelveShadow.visible = not (ballsIn.exists(12))
  @ballThirteenShadow.visible = not (ballsIn.exists(13))
  @ballFourteenShadow.visible = not (ballsIn.exists(14))
  @ballFifteenShadow.visible = not (ballsIn.exists(15))
  @updateSolidBalls()
  @updateStripedBalls()