class LiveView extends $CS.Views.Dashboard
  defaults: {}
  
  constructor: () ->
    _.extend @, @defaults
      
    @setUp()
      
  setUp: ->
    @liveWindow = Ti.UI.createWindow(orientationModes: [ Ti.UI.PORTRAIT ])
    @liveContainer = Ti.UI.createView(
      backgroundColor: "#000000"
      top: 0
      left: 0
      height: @getPlatformHeight()
      width: @getPlatformWidth()
    )
    @liveScrollView = Ti.UI.createScrollView(
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
    @liveView = Ti.UI.createView(
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
    @liveLabel = Ti.UI.createLabel(
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
    @liveView.add @comingSoon
    toolbarLabel = Ti.UI.createLabel(
      text: "Live"
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
    @liveContainer.add toolsMenuContainer
    @liveContainer.add titleBar
    @liveContainer.add @liveView
    @liveWindow.add @liveContainer
    
    @dashboardButton.addEventListener "click", ->
      @liveWindow.close()
      @dashboardWindow.show()
  
    showLive: =>
      unless Ti.Platform.name is "android"
        Ti.UI.iPhone.showStatusBar()
        @liveWindow.open fullscreen: false
      else
        @liveWindow.open fullscreen: true
  
    showLive()
      
$CS.Views.Dashboard.LiveView = LiveView