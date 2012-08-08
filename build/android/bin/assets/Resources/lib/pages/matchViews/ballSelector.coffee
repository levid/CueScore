me = this
@currentlySelectedBallNumber = null
@ballSelectorGrayImage = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/overlay.png"
  width: 156
  height: 148
  anchorPoint:
    x: 0
    y: 0

  isNinePatch: false
)
@ballSelectorGrayImage.visible = false
@ballSelectorGrayImageSmall = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/overlay-small.png"
  width: 156
  height: 108
  anchorPoint:
    x: 0
    y: 0

  isNinePatch: false
  visible: false
)
@ballSelectorScoreItImageForSmall = Ti.UI.createButton(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/overlay-scoreit-add.png"
  top: 6
  left: 8
  width: 140
  height: 36
  color: "#ffffff"
  shadowColor: "#000000"
  title: "Score It"
  font:
    fontSize: 16
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
)
@ballSelectorCancelImageForSmall = Ti.UI.createButton(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/overlay-cancel.png"
  bottom: 23
  left: 8
  width: 140
  height: 36
  color: "#ffffff"
  shadowColor: "#000000"
  title: "Cancel"
  font:
    fontSize: 16
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
)
@ballSelectorScoreItImage = Ti.UI.createButton(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/overlay-scoreit-add.png"
  top: 6
  left: 8
  width: 140
  height: 36
  color: "#ffffff"
  shadowColor: "#000000"
  title: "Score It"
  font:
    fontSize: 16
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
)
@ballSelectorDeadBallImage = Ti.UI.createButton(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/overlay-deadball-add.png"
  bottom: 66
  left: 8
  width: 140
  height: 36
  color: "#ffffff"
  shadowColor: "#000000"
  title: (if (@leagueMatch.GameType is "NineBall") then "Dead Ball" else "Scratch")
  font:
    fontSize: 16
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
)
@ballSelectorCancelImage = Ti.UI.createButton(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/overlay-cancel.png"
  bottom: 23
  left: 8
  width: 140
  height: 36
  color: "#ffffff"
  shadowColor: "#000000"
  title: "Cancel"
  font:
    fontSize: 16
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"

  isNinePatch: false
)
@ballSelectorDeadBallImage.visible = true
@showEightBallSelector = (centerTop, centerWidth, ballNumber) ->
  unless @currentlySelectedBallNumber is 8
    if @ballSelectorGrayImageSmall.visible is true
      eightShowingTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80 - @ballSelectorGrayImageSmall.left), (centerTop - 100 - @ballSelectorGrayImageSmall.top))
      @ballSelectorGrayImageSmall.animate
        opacity: 1
        transform: eightShowingTransformation
        duration: 300
      , ->
        if Ti.Platform.name is "android"
          me.ballSelectorGrayImageSmall.left = centerWidth - 80
          me.ballSelectorGrayImageSmall.top = centerTop - 100
    else
      @ballSelectorGrayImageSmall.left = centerWidth - 80
      @ballSelectorGrayImageSmall.top = centerTop - 100
      @ballSelectorGrayImageSmall.visible = true
      unless Ti.Platform.name is "android"
        @ballSelectorGrayImageSmall.opacity = 0
      else
        @ballSelectorGrayImageSmall.visible = true
      eightTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - @ballSelectorGrayImageSmall.left, (centerTop - 100) - @ballSelectorGrayImageSmall.top)
      @ballSelectorGrayImageSmall.animate
        opacity: 1
        transform: eightTransformation
        duration: 300
      , ->
        unless Ti.Platform.name is "android"
          me.ballSelectorGrayImageSmall.visible = true
          me.ballSelectorGrayImageSmall.opacity = 1
        else
          me.ballSelectorGrayImageSmall.left = centerWidth - 80
          me.ballSelectorGrayImageSmall.top = centerTop - 100
  else
    @closeSmallOverlay()
    @ballSelectorContainer.visible = true
    @ballSelectorGrayImage.left = centerWidth - 80
    @ballSelectorGrayImage.top = centerTop - 140
    unless Ti.Platform.name is "android"
      @ballSelectorGrayImage.opacity = 0
    else
      @ballSelectorGrayImage.visible = true
    t2 = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - @ballSelectorGrayImage.left, (centerTop - 140) - @ballSelectorGrayImage.top)
    @ballSelectorGrayImage.animate
      opacity: 1
      transform: t2
      duration: 300
    , ->
      if Ti.Platform.name is "android"
        me.ballSelectorGrayImage.left = centerWidth - 80
        me.ballSelectorGrayImage.top = centerTop - 140

    @ballSelectorGrayImage.visible = true  unless Ti.Platform.name is "android"

@showNineBallSelector = (centerTop, centerWidth, ballNumber) ->
  if @currentlySelectedBallNumber is 9
    @closeOverlay()
    @ballSelectorContainer.visible = true
    @ballSelectorGrayImageSmall.left = centerWidth - 80
    @ballSelectorGrayImageSmall.top = centerTop - 100
    if @ballSelectorGrayImageSmall.visible is false
      @ballSelectorGrayImageSmall.visible = true
      @ballSelectorGrayImageSmall.opacity = 0  unless Ti.Platform.name is "android"
      @ballSelectorGrayImageSmall.animate
        opacity: 1
        duration: 300
      , ->
        unless Ti.Platform.name is "android"
          me.ballSelectorGrayImageSmall.visible = true
          me.ballSelectorGrayImageSmall.opacity = 1
  else
    if @ballSelectorGrayImage.visible is true
      t = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - @ballSelectorGrayImage.left, (centerTop - 140) - @ballSelectorGrayImage.top)
      @ballSelectorGrayImage.animate
        opacity: 1
        transform: t
        duration: 300
      , ->
        if Ti.Platform.name is "android"
          me.ballSelectorGrayImage.left = centerWidth - 80
          me.ballSelectorGrayImage.top = centerTop - 140
    else
      @closeSmallOverlay()
      @ballSelectorContainer.visible = true
      @ballSelectorGrayImage.left = centerWidth - 80
      @ballSelectorGrayImage.top = centerTop - 140
      unless Ti.Platform.name is "android"
        @ballSelectorGrayImage.opacity = 0
      else
        @ballSelectorGrayImage.visible = true
      t2 = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - @ballSelectorGrayImage.left, (centerTop - 140) - @ballSelectorGrayImage.top)
      @ballSelectorGrayImage.animate
        opacity: 1
        transform: t2
        duration: 300
      , ->
        if Ti.Platform.name is "android"
          me.ballSelectorGrayImage.left = centerWidth - 80
          me.ballSelectorGrayImage.top = centerTop - 140
    @ballSelectorGrayImage.visible = true  unless Ti.Platform.name is "android"

@centerBallSelector = (centerTop, centerWidth, ballNumber) ->
  @currentlySelectedBallNumber = ballNumber
  @ballSelectorContainer.visible = true
  if @leagueMatch.GameType is "EightBall"
    @showEightBallSelector centerTop, centerWidth, ballNumber
  else @showNineBallSelector centerTop, centerWidth, ballNumber  if @leagueMatch.GameType is "NineBall"

@closeOverlay = ->
  if me.ballSelectorGrayImage.visible is true
    me.ballSelectorGrayImage.animate
      opacity: 0
      duration: 300
    , ->
      me.ballSelectorGrayImage.visible = false
  me.ballSelectorContainer.visible = false

@closeSmallOverlay = ->
  if me.ballSelectorGrayImageSmall.visible is true
    me.ballSelectorGrayImageSmall.animate
      opacity: 0
      duration: 300
    , ->
      me.ballSelectorGrayImageSmall.visible = false

@showScoreIt = (turnOn) ->
  me.ballSelectorScoreItImage.visible = turnOn
  me.ballSelectorGrayImage.visible = not turnOn

@showDeadBall = (turnOn) ->
  me.ballSelectorDeadBallImage.visible = turnOn
  me.ballSelectorGrayImage.visible = not turnOn

@scoreItClick = ->
  me.closeOverlay()
  me.closeSmallOverlay()
  me.currentMatch.scoreNumberedBall me.currentlySelectedBallNumber
  me.saveAndUpdateUI()

@ballSelectorScoreItImageForSmall.addEventListener "click", @scoreItClick
@ballSelectorCancelImageForSmall.addEventListener "click", ->
  me.closeSmallOverlay()

@ballSelectorScoreItImage.addEventListener "click", @scoreItClick
@ballSelectorDeadBallImage.addEventListener "click", ->
  me.closeOverlay()
  me.closeSmallOverlay()
  if me.leagueMatch.GameType is "NineBall"
    me.currentMatch.hitDeadBall me.currentlySelectedBallNumber
  else me.currentMatch.CurrentGame.hitScratchOnEight()  if me.leagueMatch.GameType is "EightBall"
  me.saveAndUpdateUI()

@ballSelectorCancelImage.addEventListener "click", @closeOverlay
@ballSelectorGrayImage.add @ballSelectorScoreItImage
@ballSelectorGrayImage.add @ballSelectorDeadBallImage
@ballSelectorGrayImage.add @ballSelectorCancelImage
@ballSelectorGrayImageSmall.add @ballSelectorScoreItImageForSmall
@ballSelectorGrayImageSmall.add @ballSelectorCancelImageForSmall
@view.add @ballSelectorGrayImage
@view.add @ballSelectorGrayImageSmall