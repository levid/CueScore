class TitleBarView extends $CS.Views.Dashboard
  defaults: {}
  
  constructor: (displayType) ->
    _.extend @, @defaults

    @setUp(displayType)

  setUp: (displayType) ->
    @titleBar = Titanium.UI.createView(
      backgroundColor: "transparent"
      backgroundImage: "images/match/layout/titlebar-matches.png"
      top: 0
      left: 0
      width: $CS.Utilities.getPlatformWidth()
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
      backgroundImage: if $CS.Views.Dashboard.isGrid() then "images/match/buttons/btn-dashboard-viewtype-selected.png" else "images/match/buttons/btn-dashboard-viewtype.png"
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
      backgroundImage: if $CS.Views.Dashboard.isList() then "images/match/buttons/btn-dashboard-viewtype-selected.png" else "images/match/buttons/btn-dashboard-viewtype.png"
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
      $CS.Views.Dashboard.showGrid()
      gridButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
      listButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
      gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png"
      listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png"
    
    listButton.addEventListener "click", ->
      $CS.Views.Dashboard.showList()
      gridButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
      listButton.animate backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
      gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png"
      listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png"
    
    @titleBar.add gridButton
    @titleBar.add listButton
    @titleBar.add dashboardLabel
    @titleBar
   
$CS.Views.Dashboard.TitleBarView = TitleBarView