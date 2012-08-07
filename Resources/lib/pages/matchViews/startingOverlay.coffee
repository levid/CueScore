@startMatchOverlayContainer = Ti.UI.createView(
  backgroundColor: "#ffffff"
  top: 44
  left: 0
  height: (@getPlatformHeight() - 44)
  width: @getPlatformWidth()
)
@startMatchOverlayContainer.visible = true
@view.add @startMatchOverlayContainer
@showStartMatchOverlay = ->