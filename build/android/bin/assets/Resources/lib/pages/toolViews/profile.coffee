profile = ->
  me = this
  try
    Ti.include "/js/Common.js"
    Ti.include "/js/pages/toolViews/toolsMenuView.js"
  @profileWindow = Ti.UI.createWindow(orientationModes: [ Ti.UI.PORTRAIT ])
  @profileContainer = Ti.UI.createView(
    backgroundColor: "#000000"
    top: 0
    left: 0
    height: @getPlatformHeight()
    width: @getPlatformWidth()
  )
  @profileScrollView = Ti.UI.createScrollView(
    contentWidth: "auto"
    contentHeight: "auto"
    minZoomScale: 0
    maxZoomScale: 10
    backgroundColor: "transparent"
    top: 12
    left: 12
    height: 390
    width: 295
    showPagingControl: true
  )
  @profileView = Ti.UI.createView(
    height: 243
    width: 243
    font:
      fontSize: 13
      fontWeight: "bold"
      fontFamily: "HelveticaNeue-Bold"
  )
  @comingSoon = Ti.UI.createView(
    backgroundImage: "images/match/layout/overlay-comingsoon.png"
    backgroundColor: "transparent"
    top: 20
    height: 243
    width: 243
  )
  @profileLabel = Ti.UI.createLabel(
    text: "test test test test "
    top: 0
    left: 0
    color: "#ffffff"
    height: 1500
    width: 285
    font:
      fontSize: 13
      fontWeight: "bold"
      fontFamily: "HelveticaNeue-Bold"
  )
  @profileView.add @comingSoon
  toolbarLabel = Ti.UI.createLabel(
    text: "Profile"
    color: "#ffffff"
    shadowColor: "#000000"
    textAlign: "center"
    font:
      fontSize: 20
      fontWeight: "bold"
      fontFamily: "HelveticaNeue-Bold"
  )
  titleBar.add dashboardButton
  titleBar.add toolbarLabel
  @profileContainer.add toolsMenuContainer
  @profileContainer.add titleBar
  @profileContainer.add @profileView
  @profileWindow.add @profileContainer
  @dashboardButton.addEventListener "click", ->
    me.profileWindow.close()
    me.dashboardWindow.show()

  @showProfile = ->
    unless Ti.Platform.name is "android"
      Ti.UI.iPhone.showStatusBar()
      @profileWindow.open fullscreen: false
    else
      @profileWindow.open fullscreen: true

  showProfile()
  this