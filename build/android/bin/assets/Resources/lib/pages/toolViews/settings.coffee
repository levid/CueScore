settings = ->
  me = this
  try
    Ti.include "/js/Common.js"
    Ti.include "/js/pages/toolViews/toolsMenuView.js"
  @settingsWindow = Ti.UI.createWindow(orientationModes: [ Ti.UI.PORTRAIT ])
  @settingsContainer = Ti.UI.createView(
    backgroundColor: "#000000"
    top: 0
    left: 0
    height: @getPlatformHeight()
    width: @getPlatformWidth()
  )
  @settingsScrollView = Ti.UI.createScrollView(
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
  @settingsView = Ti.UI.createView(
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
  @settingsLabel = Ti.UI.createLabel(
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
  @settingsView.add @comingSoon
  toolbarLabel = Ti.UI.createLabel(
    text: "Settings"
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
  @settingsContainer.add toolsMenuContainer
  @settingsContainer.add titleBar
  @settingsContainer.add @settingsView
  @settingsWindow.add @settingsContainer
  @dashboardButton.addEventListener "click", ->
    me.settingsWindow.close()
    me.dashboardWindow.show()

  @showSettings = ->
    unless Ti.Platform.name is "android"
      Ti.UI.iPhone.showStatusBar()
      @settingsWindow.open fullscreen: false
    else
      @settingsWindow.open fullscreen: true

  showSettings()
  this