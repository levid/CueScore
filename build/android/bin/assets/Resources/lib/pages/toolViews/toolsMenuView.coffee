toolsMenuContainer = Ti.UI.createView(
  backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (@getPlatformHeight() - 44)
  width: @getPlatformWidth()
)
titleBar = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/layout/titlebar-matches.png"
  top: 0
  left: 0
  width: @getPlatformWidth()
  height: 44
  isNinePatch: false
)
@dashboardButton = Ti.UI.createView(
  backgroundColor: "transparent"
  backgroundImage: "images/match/buttons/btn-tabmenu-backto-dashboard.png"
  top: 7
  left: 8
  width: 93
  height: 30
  isNinePatch: false
)
@dashboardButtonLabel = Ti.UI.createLabel(
  text: "Dashboard"
  color: "#ffffff"
  shadowColor: "#000000"
  left: 13
  font:
    fontSize: 13
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@dashboardButton.add @dashboardButtonLabel