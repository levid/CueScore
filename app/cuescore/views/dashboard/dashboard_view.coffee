class Dashboard extends Template
  defaults: {}
  
  constructor: () ->
    _.extend @, @defaults
    
    dashboardContainer = Titanium.UI.createView(
      backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
      backgroundColor: "transparent"
      top: 44
      left: 0
      height: (@getPlatformHeight() - 44)
      width: @getPlatformWidth()
    )
    titleBar = Titanium.UI.createView(
      backgroundColor: "transparent"
      backgroundImage: "images/match/layout/titlebar-matches.png"
      top: 0
      left: 0
      width: @getPlatformWidth()
      height: 44
      isNinePatch: false
    )
    dashboardLabel = Titanium.UI.createLabel(
      text: "Dashboard"
      color: "#ffffff"
      shadowColor: "#000000"
      textAlign: "center"
      font:
        fontSize: 20
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    gridButton = Titanium.UI.createView(
      backgroundColor: "transparent"
      backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
      top: 7
      left: 8
      width: 80
      height: 30
    )
    gridButtonLabel = Titanium.UI.createLabel(
      text: "Grid View"
      color: "#ffffff"
      shadowColor: "#000000"
      left: 11
      font:
        fontSize: 13
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    gridButton.add gridButtonLabel
    listButton = Titanium.UI.createView(
      backgroundColor: "transparent"
      backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
      top: 7
      right: 8
      width: 80
      height: 30
    )
    listButtonLabel = Titanium.UI.createLabel(
      text: "List View"
      color: "#ffffff"
      shadowColor: "#000000"
      left: 11
      font:
        fontSize: 13
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    listButton.add listButtonLabel
    gridButton.addEventListener "click", ->
      showGrid()
      gridButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
      listButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
      gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png"
      listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png"
    
    listButton.addEventListener "click", ->
      showList()
      gridButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
      listButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
      gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png"
      listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png"
    
    titleBar.add gridButton
    titleBar.add listButton
    titleBar.add dashboardLabel

$CS.Views.Dashboard = Dashboard