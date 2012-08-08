updateSolidBalls = ->
  solidBallsHitIn = @currentMatch.CurrentGame.SolidBallsHitIn
  @displayBallOneButton.visible = solidBallsHitIn.exists(1)
  @displayBallTwoButton.visible = solidBallsHitIn.exists(2)
  @displayBallThreeButton.visible = solidBallsHitIn.exists(3)
  @displayBallFourButton.visible = solidBallsHitIn.exists(4)
  @displayBallFiveButton.visible = solidBallsHitIn.exists(5)
  @displayBallSixButton.visible = solidBallsHitIn.exists(6)
  @displayBallSevenButton.visible = solidBallsHitIn.exists(7)
  @displayBallOneShadow.visible = solidBallsHitIn.exists(1)
  @displayBallTwoShadow.visible = solidBallsHitIn.exists(2)
  @displayBallThreeShadow.visible = solidBallsHitIn.exists(3)
  @displayBallFourShadow.visible = solidBallsHitIn.exists(4)
  @displayBallFiveShadow.visible = solidBallsHitIn.exists(5)
  @displayBallSixShadow.visible = solidBallsHitIn.exists(6)
  @displayBallSevenShadow.visible = solidBallsHitIn.exists(7)
  @displayBallOneGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 1)
  @displayBallTwoGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 2)
  @displayBallThreeGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 3)
  @displayBallFourGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 4)
  @displayBallFiveGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 5)
  @displayBallSixGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 6)
  @displayBallSevenGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 7)
updateStripedBalls = ->
  stripedBallsHitIn = @currentMatch.CurrentGame.StripedBallsHitIn
  @displayBallNineButton.visible = stripedBallsHitIn.exists(9)
  @displayBallTenButton.visible = stripedBallsHitIn.exists(10)
  @displayBallElevenButton.visible = stripedBallsHitIn.exists(11)
  @displayBallTwelveButton.visible = stripedBallsHitIn.exists(12)
  @displayBallThirteenButton.visible = stripedBallsHitIn.exists(13)
  @displayBallFourteenButton.visible = stripedBallsHitIn.exists(14)
  @displayBallFifteenButton.visible = stripedBallsHitIn.exists(15)
  @displayBallNineShadow.visible = stripedBallsHitIn.exists(9)
  @displayBallTenShadow.visible = stripedBallsHitIn.exists(10)
  @displayBallElevenShadow.visible = stripedBallsHitIn.exists(11)
  @displayBallTwelveShadow.visible = stripedBallsHitIn.exists(12)
  @displayBallThirteenShadow.visible = stripedBallsHitIn.exists(13)
  @displayBallFourteenShadow.visible = stripedBallsHitIn.exists(14)
  @displayBallFifteenShadow.visible = stripedBallsHitIn.exists(15)
  @displayBallNineGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 9)
  @displayBallTenGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 10)
  @displayBallElevenGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 11)
  @displayBallTwelveGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 12)
  @displayBallThirteenGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 13)
  @displayBallFourteenGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 14)
  @displayBallFifteenGlow.visible = (@currentMatch.CurrentGame.LastBallHitIn is 15)
me = this
@solidBallView = Ti.UI.createView(
  top: 137
  left: 0
  height: 235
  anchorPoint:
    x: 0
    y: 0

  width: 36
)
@displayBallOneButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/1ball-small.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallOneBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/1ball-small-inactive.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallOneGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallOneShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallTwoButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/2ball-small.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallTwoBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/2ball-small-inactive.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallTwoGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallTwoShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallThreeButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/3ball-small.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallThreeBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/3ball-small-inactive.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallThreeGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallThreeShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFourButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/4ball-small.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFourBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/4ball-small-inactive.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFourGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFourShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFiveButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/5ball-small.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFiveBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/5ball-small-inactive.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFiveGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFiveShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallSixButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/6ball-small.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallSixBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/6ball-small-inactive.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallSixGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallSixShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallSevenButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/7ball-small.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallSevenBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/7ball-small-inactive.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallSevenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallSevenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displaySolidBallEightBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/8ball-small-inactive.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallOneButton.visible = false
@displayBallOneGlow.visible = false
@displayBallOneShadow.visible = false
@displayBallTwoButton.visible = false
@displayBallTwoGlow.visible = false
@displayBallTwoShadow.visible = false
@displayBallThreeButton.visible = false
@displayBallThreeGlow.visible = false
@displayBallThreeShadow.visible = false
@displayBallFourButton.visible = false
@displayBallFourGlow.visible = false
@displayBallFourShadow.visible = false
@displayBallFiveButton.visible = false
@displayBallFiveGlow.visible = false
@displayBallFiveShadow.visible = false
@displayBallSixButton.visible = false
@displayBallSixGlow.visible = false
@displayBallSixShadow.visible = false
@displayBallSevenButton.visible = false
@displayBallSevenGlow.visible = false
@displayBallSevenShadow.visible = false
@solidBallView.add @displayBallOneShadow
@solidBallView.add @displayBallTwoShadow
@solidBallView.add @displayBallThreeShadow
@solidBallView.add @displayBallFourShadow
@solidBallView.add @displayBallFiveShadow
@solidBallView.add @displayBallSixShadow
@solidBallView.add @displayBallSevenShadow
@solidBallView.add @displayBallOneGlow
@solidBallView.add @displayBallTwoGlow
@solidBallView.add @displayBallThreeGlow
@solidBallView.add @displayBallFourGlow
@solidBallView.add @displayBallFiveGlow
@solidBallView.add @displayBallSixGlow
@solidBallView.add @displayBallSevenGlow
@solidBallView.add @displayBallOneBg
@solidBallView.add @displayBallTwoBg
@solidBallView.add @displayBallThreeBg
@solidBallView.add @displayBallFourBg
@solidBallView.add @displayBallFiveBg
@solidBallView.add @displayBallSixBg
@solidBallView.add @displayBallSevenBg
@solidBallView.add @displaySolidBallEightBg
@solidBallView.add @displayBallOneButton
@solidBallView.add @displayBallTwoButton
@solidBallView.add @displayBallThreeButton
@solidBallView.add @displayBallFourButton
@solidBallView.add @displayBallFiveButton
@solidBallView.add @displayBallSixButton
@solidBallView.add @displayBallSevenButton
@view.add @solidBallView
@stripedBallView = Ti.UI.createView(
  top: 137
  left: @getPlatformWidth() - 36
  height: 235
  anchorPoint:
    x: 0
    y: 0

  width: 36
)
@displayBallNineButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/9ball-small.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallNineBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/9ball-small-inactive.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallNineGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallNineShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallTenButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/10ball-small.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallTenBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/10ball-small-inactive.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallTenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallTenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallElevenButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/11ball-small.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallElevenBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/11ball-small-inactive.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallElevenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallElevenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallTwelveButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/12ball-small.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallTwelveBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/12ball-small-inactive.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallTwelveGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallTwelveShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallThirteenButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/13ball-small.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallThirteenBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/13ball-small-inactive.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallThirteenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallThirteenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFourteenButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/14ball-small.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFourteenBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/14ball-small-inactive.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFourteenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFourteenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFifteenButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/15ball-small.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFifteenBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/15ball-small-inactive.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallFifteenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayBallFifteenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@displayStripedBallEightBg = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/smallballs/8ball-small-inactive.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@displayBallNineButton.visible = false
@displayBallNineGlow.visible = false
@displayBallNineShadow.visible = false
@displayBallTenButton.visible = false
@displayBallTenGlow.visible = false
@displayBallTenShadow.visible = false
@displayBallElevenButton.visible = false
@displayBallElevenGlow.visible = false
@displayBallElevenShadow.visible = false
@displayBallTwelveButton.visible = false
@displayBallTwelveGlow.visible = false
@displayBallTwelveShadow.visible = false
@displayBallThirteenButton.visible = false
@displayBallThirteenGlow.visible = false
@displayBallThirteenShadow.visible = false
@displayBallFourteenButton.visible = false
@displayBallFourteenGlow.visible = false
@displayBallFourteenShadow.visible = false
@displayBallFifteenButton.visible = false
@displayBallFifteenGlow.visible = false
@displayBallFifteenShadow.visible = false
@stripedBallView.add @displayBallNineShadow
@stripedBallView.add @displayBallTenShadow
@stripedBallView.add @displayBallElevenShadow
@stripedBallView.add @displayBallTwelveShadow
@stripedBallView.add @displayBallThirteenShadow
@stripedBallView.add @displayBallFourteenShadow
@stripedBallView.add @displayBallFifteenShadow
@stripedBallView.add @displayBallNineGlow
@stripedBallView.add @displayBallTenGlow
@stripedBallView.add @displayBallElevenGlow
@stripedBallView.add @displayBallTwelveGlow
@stripedBallView.add @displayBallThirteenGlow
@stripedBallView.add @displayBallFourteenGlow
@stripedBallView.add @displayBallFifteenGlow
@stripedBallView.add @displayBallNineBg
@stripedBallView.add @displayBallTenBg
@stripedBallView.add @displayBallElevenBg
@stripedBallView.add @displayBallTwelveBg
@stripedBallView.add @displayBallThirteenBg
@stripedBallView.add @displayBallFourteenBg
@stripedBallView.add @displayBallFifteenBg
@stripedBallView.add @displayStripedBallEightBg
@stripedBallView.add @displayBallNineButton
@stripedBallView.add @displayBallTenButton
@stripedBallView.add @displayBallElevenButton
@stripedBallView.add @displayBallTwelveButton
@stripedBallView.add @displayBallThirteenButton
@stripedBallView.add @displayBallFourteenButton
@stripedBallView.add @displayBallFifteenButton
@view.add @stripedBallView