me = this
@statusOverlayContainer = Ti.UI.createImageView(
  backgroundImage: "/images/match/layout/bg-endgame.png"
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (@getPlatformHeight() - 44)
  width: @getPlatformWidth()
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
  text: "test"
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