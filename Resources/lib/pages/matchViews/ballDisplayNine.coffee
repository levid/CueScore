updatePlayerOneBalls = ->
  playerOneSmallBallsIn = @currentMatch.CurrentGame.PlayerOneBallsHitIn
  playerOneDeadBallsIn = @currentMatch.CurrentGame.PlayerOneDeadBalls
  @playerOneSmallBallOneButton.visible = playerOneSmallBallsIn.exists(1)
  @playerOneSmallBallTwoButton.visible = playerOneSmallBallsIn.exists(2)
  @playerOneSmallBallThreeButton.visible = playerOneSmallBallsIn.exists(3)
  @playerOneSmallBallFourButton.visible = playerOneSmallBallsIn.exists(4)
  @playerOneSmallBallFiveButton.visible = playerOneSmallBallsIn.exists(5)
  @playerOneSmallBallSixButton.visible = playerOneSmallBallsIn.exists(6)
  @playerOneSmallBallSevenButton.visible = playerOneSmallBallsIn.exists(7)
  @playerOneSmallBallEightButton.visible = playerOneSmallBallsIn.exists(8)
  @playerOneSmallBallNineButton.visible = playerOneSmallBallsIn.exists(9)
  @playerOneSmallBallOneDeadBall.visible = playerOneDeadBallsIn.exists(1)
  @playerOneSmallBallTwoDeadBall.visible = playerOneDeadBallsIn.exists(2)
  @playerOneSmallBallThreeDeadBall.visible = playerOneDeadBallsIn.exists(3)
  @playerOneSmallBallFourDeadBall.visible = playerOneDeadBallsIn.exists(4)
  @playerOneSmallBallFiveDeadBall.visible = playerOneDeadBallsIn.exists(5)
  @playerOneSmallBallSixDeadBall.visible = playerOneDeadBallsIn.exists(6)
  @playerOneSmallBallSevenDeadBall.visible = playerOneDeadBallsIn.exists(7)
  @playerOneSmallBallEightDeadBall.visible = playerOneDeadBallsIn.exists(8)
  @playerOneSmallBallNineDeadBall.visible = playerOneDeadBallsIn.exists(9)
  @playerOneSmallBallOneShadow.visible = playerOneSmallBallsIn.exists(1)
  @playerOneSmallBallTwoShadow.visible = playerOneSmallBallsIn.exists(2)
  @playerOneSmallBallThreeShadow.visible = playerOneSmallBallsIn.exists(3)
  @playerOneSmallBallFourShadow.visible = playerOneSmallBallsIn.exists(4)
  @playerOneSmallBallFiveShadow.visible = playerOneSmallBallsIn.exists(5)
  @playerOneSmallBallSixShadow.visible = playerOneSmallBallsIn.exists(6)
  @playerOneSmallBallSevenShadow.visible = playerOneSmallBallsIn.exists(7)
  @playerOneSmallBallEightShadow.visible = playerOneSmallBallsIn.exists(8)
  @playerOneSmallBallNineShadow.visible = playerOneSmallBallsIn.exists(9)
  @playerOneSmallBallOneGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 1)
  @playerOneSmallBallTwoGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 2)
  @playerOneSmallBallThreeGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 3)
  @playerOneSmallBallFourGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 4)
  @playerOneSmallBallFiveGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 5)
  @playerOneSmallBallSixGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 6)
  @playerOneSmallBallSevenGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 7)
  @playerOneSmallBallEightGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 8)
  @playerOneSmallBallNineGlow.visible = (@currentMatch.CurrentGame.PlayerOneLastBall is 9)
updatePlayerTwoBalls = ->
  playerTwoSmallBallsIn = @currentMatch.CurrentGame.PlayerTwoBallsHitIn
  playerTwoDeadBallsIn = @currentMatch.CurrentGame.PlayerTwoDeadBalls
  @playerTwoSmallBallOneButton.visible = playerTwoSmallBallsIn.exists(1)
  @playerTwoSmallBallTwoButton.visible = playerTwoSmallBallsIn.exists(2)
  @playerTwoSmallBallThreeButton.visible = playerTwoSmallBallsIn.exists(3)
  @playerTwoSmallBallFourButton.visible = playerTwoSmallBallsIn.exists(4)
  @playerTwoSmallBallFiveButton.visible = playerTwoSmallBallsIn.exists(5)
  @playerTwoSmallBallSixButton.visible = playerTwoSmallBallsIn.exists(6)
  @playerTwoSmallBallSevenButton.visible = playerTwoSmallBallsIn.exists(7)
  @playerTwoSmallBallEightButton.visible = playerTwoSmallBallsIn.exists(8)
  @playerTwoSmallBallNineButton.visible = playerTwoSmallBallsIn.exists(9)
  @playerTwoSmallBallOneDeadBall.visible = playerTwoDeadBallsIn.exists(1)
  @playerTwoSmallBallTwoDeadBall.visible = playerTwoDeadBallsIn.exists(2)
  @playerTwoSmallBallThreeDeadBall.visible = playerTwoDeadBallsIn.exists(3)
  @playerTwoSmallBallFourDeadBall.visible = playerTwoDeadBallsIn.exists(4)
  @playerTwoSmallBallFiveDeadBall.visible = playerTwoDeadBallsIn.exists(5)
  @playerTwoSmallBallSixDeadBall.visible = playerTwoDeadBallsIn.exists(6)
  @playerTwoSmallBallSevenDeadBall.visible = playerTwoDeadBallsIn.exists(7)
  @playerTwoSmallBallEightDeadBall.visible = playerTwoDeadBallsIn.exists(8)
  @playerTwoSmallBallNineDeadBall.visible = playerTwoDeadBallsIn.exists(9)
  @playerTwoSmallBallOneShadow.visible = playerTwoSmallBallsIn.exists(1)
  @playerTwoSmallBallTwoShadow.visible = playerTwoSmallBallsIn.exists(2)
  @playerTwoSmallBallThreeShadow.visible = playerTwoSmallBallsIn.exists(3)
  @playerTwoSmallBallFourShadow.visible = playerTwoSmallBallsIn.exists(4)
  @playerTwoSmallBallFiveShadow.visible = playerTwoSmallBallsIn.exists(5)
  @playerTwoSmallBallSixShadow.visible = playerTwoSmallBallsIn.exists(6)
  @playerTwoSmallBallSevenShadow.visible = playerTwoSmallBallsIn.exists(7)
  @playerTwoSmallBallEightShadow.visible = playerTwoSmallBallsIn.exists(8)
  @playerTwoSmallBallNineShadow.visible = playerTwoSmallBallsIn.exists(9)
  @playerTwoSmallBallOneGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 1)
  @playerTwoSmallBallTwoGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 2)
  @playerTwoSmallBallThreeGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 3)
  @playerTwoSmallBallFourGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 4)
  @playerTwoSmallBallFiveGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 5)
  @playerTwoSmallBallSixGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 6)
  @playerTwoSmallBallSevenGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 7)
  @playerTwoSmallBallEightGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 8)
  @playerTwoSmallBallNineGlow.visible = (@currentMatch.CurrentGame.PlayerTwoLastBall is 9)
me = this
@playerOneBallView = Ti.UI.createView(
  top: 135
  left: 0
  height: 235
  width: 36
)
@playerOneSmallBallOneButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/1ball-small.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallOneDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallOneBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/1ball-small-inactive.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallOneGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallOneShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallTwoButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/2ball-small.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallTwoDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallTwoBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/2ball-small-inactive.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallTwoGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallTwoShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallThreeButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/3ball-small.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallThreeDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallThreeBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/3ball-small-inactive.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallThreeGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallThreeShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallFourButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/4ball-small.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallFourDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallFourBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/4ball-small-inactive.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallFourGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallFourShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallFiveButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/5ball-small.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallFiveDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallFiveBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/5ball-small-inactive.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallFiveGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallFiveShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallSixButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/6ball-small.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallSixDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallSixBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/6ball-small-inactive.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallSixGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallSixShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallSevenButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/7ball-small.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallSevenDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallSevenBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/7ball-small-inactive.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallSevenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallSevenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallEightButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/8ball-small.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallEightDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallEightBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/8ball-small-inactive.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallEightGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 176
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallEightShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 176
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallNineButton = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/9ball-small.png"
  top: 210
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallNineDeadBall = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 210
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallNineBg = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/9ball-small-inactive.png"
  top: 210
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerOneSmallBallNineGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 201
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneSmallBallNineShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 201
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerOneBallView.add @playerOneSmallBallOneShadow
@playerOneBallView.add @playerOneSmallBallTwoShadow
@playerOneBallView.add @playerOneSmallBallThreeShadow
@playerOneBallView.add @playerOneSmallBallFourShadow
@playerOneBallView.add @playerOneSmallBallFiveShadow
@playerOneBallView.add @playerOneSmallBallSixShadow
@playerOneBallView.add @playerOneSmallBallSevenShadow
@playerOneBallView.add @playerOneSmallBallEightShadow
@playerOneBallView.add @playerOneSmallBallNineShadow
@playerOneBallView.add @playerOneSmallBallOneGlow
@playerOneBallView.add @playerOneSmallBallTwoGlow
@playerOneBallView.add @playerOneSmallBallThreeGlow
@playerOneBallView.add @playerOneSmallBallFourGlow
@playerOneBallView.add @playerOneSmallBallFiveGlow
@playerOneBallView.add @playerOneSmallBallSixGlow
@playerOneBallView.add @playerOneSmallBallSevenGlow
@playerOneBallView.add @playerOneSmallBallEightGlow
@playerOneBallView.add @playerOneSmallBallNineGlow
@playerOneBallView.add @playerOneSmallBallOneBg
@playerOneBallView.add @playerOneSmallBallTwoBg
@playerOneBallView.add @playerOneSmallBallThreeBg
@playerOneBallView.add @playerOneSmallBallFourBg
@playerOneBallView.add @playerOneSmallBallFiveBg
@playerOneBallView.add @playerOneSmallBallSixBg
@playerOneBallView.add @playerOneSmallBallSevenBg
@playerOneBallView.add @playerOneSmallBallEightBg
@playerOneBallView.add @playerOneSmallBallNineBg
@playerOneBallView.add @playerOneSmallBallOneButton
@playerOneBallView.add @playerOneSmallBallTwoButton
@playerOneBallView.add @playerOneSmallBallThreeButton
@playerOneBallView.add @playerOneSmallBallFourButton
@playerOneBallView.add @playerOneSmallBallFiveButton
@playerOneBallView.add @playerOneSmallBallSixButton
@playerOneBallView.add @playerOneSmallBallSevenButton
@playerOneBallView.add @playerOneSmallBallEightButton
@playerOneBallView.add @playerOneSmallBallNineButton
@playerOneBallView.add @playerOneSmallBallOneDeadBall
@playerOneBallView.add @playerOneSmallBallTwoDeadBall
@playerOneBallView.add @playerOneSmallBallThreeDeadBall
@playerOneBallView.add @playerOneSmallBallFourDeadBall
@playerOneBallView.add @playerOneSmallBallFiveDeadBall
@playerOneBallView.add @playerOneSmallBallSixDeadBall
@playerOneBallView.add @playerOneSmallBallSevenDeadBall
@playerOneBallView.add @playerOneSmallBallEightDeadBall
@playerOneBallView.add @playerOneSmallBallNineDeadBall
@view.add @playerOneBallView
@playerOneSmallBallOneDeadBall.visible = false
@playerOneSmallBallTwoDeadBall.visible = false
@playerOneSmallBallThreeDeadBall.visible = false
@playerOneSmallBallFourDeadBall.visible = false
@playerOneSmallBallFiveDeadBall.visible = false
@playerOneSmallBallSixDeadBall.visible = false
@playerOneSmallBallSevenDeadBall.visible = false
@playerOneSmallBallEightDeadBall.visible = false
@playerOneSmallBallNineDeadBall.visible = false
@playerOneSmallBallOneButton.visible = false
@playerOneSmallBallTwoButton.visible = false
@playerOneSmallBallThreeButton.visible = false
@playerOneSmallBallFourButton.visible = false
@playerOneSmallBallFiveButton.visible = false
@playerOneSmallBallSixButton.visible = false
@playerOneSmallBallSevenButton.visible = false
@playerOneSmallBallEightButton.visible = false
@playerOneSmallBallNineButton.visible = false
@playerOneSmallBallOneShadow.visible = false
@playerOneSmallBallTwoShadow.visible = false
@playerOneSmallBallThreeShadow.visible = false
@playerOneSmallBallFourShadow.visible = false
@playerOneSmallBallFiveShadow.visible = false
@playerOneSmallBallSixShadow.visible = false
@playerOneSmallBallSevenShadow.visible = false
@playerOneSmallBallEightShadow.visible = false
@playerOneSmallBallNineShadow.visible = false
@playerOneSmallBallOneGlow.visible = false
@playerOneSmallBallTwoGlow.visible = false
@playerOneSmallBallThreeGlow.visible = false
@playerOneSmallBallFourGlow.visible = false
@playerOneSmallBallFiveGlow.visible = false
@playerOneSmallBallSixGlow.visible = false
@playerOneSmallBallSevenGlow.visible = false
@playerOneSmallBallEightGlow.visible = false
@playerOneSmallBallNineGlow.visible = false
@playerTwoBallView = Ti.UI.createView(
  top: 135
  right: 0
  height: 235
  width: 36
)
@playerTwoSmallBallOneButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/1ball-small.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallOneDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallOneBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/1ball-small-inactive.png"
  top: 10
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallOneGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallOneShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 1
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallTwoButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/2ball-small.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallTwoDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallTwoBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/2ball-small-inactive.png"
  top: 35
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallTwoGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallTwoShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 26
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallThreeButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/3ball-small.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallThreeDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallThreeBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/3ball-small-inactive.png"
  top: 60
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallThreeGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallThreeShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 51
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallFourButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/4ball-small.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallFourDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallFourBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/4ball-small-inactive.png"
  top: 85
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallFourGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallFourShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 76
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallFiveButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/5ball-small.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallFiveDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallFiveBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/5ball-small-inactive.png"
  top: 110
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallFiveGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallFiveShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 101
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallSixButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/6ball-small.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallSixDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallSixBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/6ball-small-inactive.png"
  top: 135
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallSixGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallSixShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 126
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallSevenButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/7ball-small.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallSevenDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallSevenBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/7ball-small-inactive.png"
  top: 160
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallSevenGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallSevenShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 151
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallEightButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/8ball-small.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallEightDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallEightBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/8ball-small-inactive.png"
  top: 185
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallEightGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 176
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallEightShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 176
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallNineButton = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/9ball-small.png"
  top: 210
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallNineDeadBall = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/deadball-small-balls.png"
  top: 210
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallNineBg = Ti.UI.createImageView(
  color: "#FFF"
  backgroundImage: "images/match/smallballs/9ball-small-inactive.png"
  top: 210
  opacity: 1
  width: 21
  height: 21
  isNinePatch: false
)
@playerTwoSmallBallNineGlow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/glow-small-balls.png"
  top: 201
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoSmallBallNineShadow = Ti.UI.createImageView(
  backgroundImage: "images/match/smallballs/shadow-small-balls.png"
  top: 201
  opacity: 1
  width: 38
  height: 38
  isNinePatch: false
)
@playerTwoBallView.add @playerTwoSmallBallOneShadow
@playerTwoBallView.add @playerTwoSmallBallTwoShadow
@playerTwoBallView.add @playerTwoSmallBallThreeShadow
@playerTwoBallView.add @playerTwoSmallBallFourShadow
@playerTwoBallView.add @playerTwoSmallBallFiveShadow
@playerTwoBallView.add @playerTwoSmallBallSixShadow
@playerTwoBallView.add @playerTwoSmallBallSevenShadow
@playerTwoBallView.add @playerTwoSmallBallEightShadow
@playerTwoBallView.add @playerTwoSmallBallNineShadow
@playerTwoBallView.add @playerTwoSmallBallOneGlow
@playerTwoBallView.add @playerTwoSmallBallTwoGlow
@playerTwoBallView.add @playerTwoSmallBallThreeGlow
@playerTwoBallView.add @playerTwoSmallBallFourGlow
@playerTwoBallView.add @playerTwoSmallBallFiveGlow
@playerTwoBallView.add @playerTwoSmallBallSixGlow
@playerTwoBallView.add @playerTwoSmallBallSevenGlow
@playerTwoBallView.add @playerTwoSmallBallEightGlow
@playerTwoBallView.add @playerTwoSmallBallNineGlow
@playerTwoBallView.add @playerTwoSmallBallOneBg
@playerTwoBallView.add @playerTwoSmallBallTwoBg
@playerTwoBallView.add @playerTwoSmallBallThreeBg
@playerTwoBallView.add @playerTwoSmallBallFourBg
@playerTwoBallView.add @playerTwoSmallBallFiveBg
@playerTwoBallView.add @playerTwoSmallBallSixBg
@playerTwoBallView.add @playerTwoSmallBallSevenBg
@playerTwoBallView.add @playerTwoSmallBallEightBg
@playerTwoBallView.add @playerTwoSmallBallNineBg
@playerTwoBallView.add @playerTwoSmallBallOneButton
@playerTwoBallView.add @playerTwoSmallBallTwoButton
@playerTwoBallView.add @playerTwoSmallBallThreeButton
@playerTwoBallView.add @playerTwoSmallBallFourButton
@playerTwoBallView.add @playerTwoSmallBallFiveButton
@playerTwoBallView.add @playerTwoSmallBallSixButton
@playerTwoBallView.add @playerTwoSmallBallSevenButton
@playerTwoBallView.add @playerTwoSmallBallEightButton
@playerTwoBallView.add @playerTwoSmallBallNineButton
@playerTwoBallView.add @playerTwoSmallBallOneDeadBall
@playerTwoBallView.add @playerTwoSmallBallTwoDeadBall
@playerTwoBallView.add @playerTwoSmallBallThreeDeadBall
@playerTwoBallView.add @playerTwoSmallBallFourDeadBall
@playerTwoBallView.add @playerTwoSmallBallFiveDeadBall
@playerTwoBallView.add @playerTwoSmallBallSixDeadBall
@playerTwoBallView.add @playerTwoSmallBallSevenDeadBall
@playerTwoBallView.add @playerTwoSmallBallEightDeadBall
@playerTwoBallView.add @playerTwoSmallBallNineDeadBall
@view.add @playerTwoBallView
@playerTwoSmallBallOneButton.visible = false
@playerTwoSmallBallTwoButton.visible = false
@playerTwoSmallBallThreeButton.visible = false
@playerTwoSmallBallFourButton.visible = false
@playerTwoSmallBallFiveButton.visible = false
@playerTwoSmallBallSixButton.visible = false
@playerTwoSmallBallSevenButton.visible = false
@playerTwoSmallBallEightButton.visible = false
@playerTwoSmallBallNineButton.visible = false
@playerTwoSmallBallOneDeadBall.visible = false
@playerTwoSmallBallTwoDeadBall.visible = false
@playerTwoSmallBallThreeDeadBall.visible = false
@playerTwoSmallBallFourDeadBall.visible = false
@playerTwoSmallBallFiveDeadBall.visible = false
@playerTwoSmallBallSixDeadBall.visible = false
@playerTwoSmallBallSevenDeadBall.visible = false
@playerTwoSmallBallEightDeadBall.visible = false
@playerTwoSmallBallNineDeadBall.visible = false
@playerTwoSmallBallOneShadow.visible = false
@playerTwoSmallBallTwoShadow.visible = false
@playerTwoSmallBallThreeShadow.visible = false
@playerTwoSmallBallFourShadow.visible = false
@playerTwoSmallBallFiveShadow.visible = false
@playerTwoSmallBallSixShadow.visible = false
@playerTwoSmallBallSevenShadow.visible = false
@playerTwoSmallBallEightShadow.visible = false
@playerTwoSmallBallNineShadow.visible = false
@playerTwoSmallBallOneGlow.visible = false
@playerTwoSmallBallTwoGlow.visible = false
@playerTwoSmallBallThreeGlow.visible = false
@playerTwoSmallBallFourGlow.visible = false
@playerTwoSmallBallFiveGlow.visible = false
@playerTwoSmallBallSixGlow.visible = false
@playerTwoSmallBallSevenGlow.visible = false
@playerTwoSmallBallEightGlow.visible = false
@playerTwoSmallBallNineGlow.visible = false