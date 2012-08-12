class EventsView extends $CS.Views.Dashboard
  defaults: {}
  
  constructor: () ->
    _.extend @, @defaults
    
    try
      Ti.include "/js/Common.js"
      Ti.include "/js/pages/toolViews/toolsMenuView.js"
      
    @setUp()
      
  setUp: ->
    @eventsWindow = Ti.UI.createWindow(orientationModes: [ Ti.UI.PORTRAIT ])
    @eventsContainer = Ti.UI.createView(
      backgroundColor: "#000000"
      top: 0
      left: 0
      height: @getPlatformHeight()
      width: @getPlatformWidth()
    )
    @eventsScrollView = Ti.UI.createScrollView(
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
    @eventsView = Ti.UI.createView(
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
    @eventsLabel = Ti.UI.createLabel(
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
    @eventsView.add @comingSoon
    toolbarLabel = Ti.UI.createLabel(
      text: "Events"
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
    @eventsContainer.add toolsMenuContainer
    @eventsContainer.add titleBar
    @eventsContainer.add @eventsView
    @eventsWindow.add @eventsContainer
    
    @dashboardButton.addEventListener "click", ->
      @eventsWindow.close()
      @dashboardWindow.show()
  
    showEvents: =>
      unless Ti.Platform.name is "android"
        Ti.UI.iPhone.showStatusBar()
        @eventsWindow.open fullscreen: false
      else
        @eventsWindow.open fullscreen: true
  
    showEvents()
      
$CS.Views.Dashboard.EventsView = EventsView