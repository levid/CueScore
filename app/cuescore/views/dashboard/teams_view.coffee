class TeamsView extends $CS.Views.Dashboard
  defaults: {}
  
  constructor: () ->
    _.extend @, @defaults
    
    try
      Ti.include "/js/Common.js"
      Ti.include "/js/pages/toolViews/toolsMenuView.js"
      
    @setUp()
      
  setUp: ->
    @teamsWindow = Ti.UI.createWindow(orientationModes: [ Ti.UI.PORTRAIT ])
    @teamsContainer = Ti.UI.createView(
      backgroundColor: "#000000"
      top: 0
      left: 0
      height: @getPlatformHeight()
      width: @getPlatformWidth()
    )
    @teamsScrollView = Ti.UI.createScrollView(
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
    @teamsView = Ti.UI.createView(
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
    @teamsLabel = Ti.UI.createLabel(
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
    @teamsView.add @comingSoon
    toolbarLabel = Ti.UI.createLabel(
      text: "Teams"
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
    @teamsContainer.add toolsMenuContainer
    @teamsContainer.add titleBar
    @teamsContainer.add @teamsView
    @teamsWindow.add @teamsContainer
    
    @dashboardButton.addEventListener "click", ->
      @teamsWindow.close()
      @dashboardWindow.show()
  
    showTeams: =>
      unless Ti.Platform.name is "android"
        Ti.UI.iPhone.showStatusBar()
        @teamsWindow.open fullscreen: false
      else
        @teamsWindow.open fullscreen: true
  
    showTeams()
    
$CS.Views.Dashboard.TeamsView = TeamsView