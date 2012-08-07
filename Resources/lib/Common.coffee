getScoreRatio = (playerScore, playerBallCount) ->
  playerScore / playerBallCount
Array::exists = (search) ->
  i = 0

  while i < @length
    return true  if this[i] is search
    i++
  false

root.getPlatformWidth = ->
  Ti.Platform.displayCaps.platformWidth

root.getPlatformHeight = ->
  Ti.Platform.displayCaps.platformHeight - 22