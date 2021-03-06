// Generated by CoffeeScript 1.3.3
(function() {
  var DashboardContainer;

  DashboardContainer = (function() {

    function DashboardContainer() {
      var dashboardLabel, gridButton, gridButtonLabel, listButton, listButtonLabel;
      this.dashboardContainer = Ti.UI.createView({
        backgroundImage: (Ti.Platform.name !== "android" ? "images/match/layout/bg-menus-iphone.png" : "images/match/layout/bg-menus-android.png"),
        backgroundColor: "transparent",
        top: 44,
        left: 0,
        height: root.getPlatformHeight() - 44,
        width: root.getPlatformWidth()
      });
      this.titleBar = Ti.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/layout/titlebar-matches.png",
        top: 0,
        left: 0,
        width: root.getPlatformWidth(),
        height: 44,
        isNinePatch: false
      });
      dashboardLabel = Ti.UI.createLabel({
        text: "Dashboard",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      gridButton = Ti.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png",
        top: 7,
        left: 8,
        width: 80,
        height: 30
      });
      gridButtonLabel = Ti.UI.createLabel({
        text: "Grid View",
        color: "#ffffff",
        shadowColor: "#000000",
        left: 11,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      gridButton.add(gridButtonLabel);
      listButton = Ti.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png",
        top: 7,
        right: 8,
        width: 80,
        height: 30
      });
      listButtonLabel = Ti.UI.createLabel({
        text: "List View",
        color: "#ffffff",
        shadowColor: "#000000",
        left: 11,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      listButton.add(listButtonLabel);
      gridButton.addEventListener("click", function() {
        showGrid();
        gridButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
        });
        listButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
        });
        gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png";
        return listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png";
      });
      listButton.addEventListener("click", function() {
        showList();
        gridButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
        });
        listButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
        });
        gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png";
        return listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png";
      });
      this.titleBar.add(gridButton);
      this.titleBar.add(listButton);
      this.titleBar.add(dashboardLabel);
    }

    return DashboardContainer;

  })();

  root.DashboardContainer = DashboardContainer;

}).call(this);
