// Generated by CoffeeScript 1.3.3
(function() {
  var live;

  live = function() {
    var me, toolbarLabel;
    me = this;
    try {
      Ti.include("/js/Common.js");
      Ti.include("/js/pages/toolViews/toolsMenuView.js");
    } catch (_error) {}
    this.liveWindow = Ti.UI.createWindow({
      orientationModes: [Ti.UI.PORTRAIT]
    });
    this.liveContainer = Ti.UI.createView({
      backgroundColor: "#000000",
      top: 0,
      left: 0,
      height: this.getPlatformHeight(),
      width: this.getPlatformWidth()
    });
    this.liveScrollView = Ti.UI.createScrollView({
      contentWidth: "auto",
      contentHeight: "auto",
      minZoomScale: 0,
      maxZoomScale: 10,
      backgroundColor: "transparent",
      top: 12,
      left: 12,
      height: 390,
      width: 295,
      showPagingControl: true
    });
    this.liveView = Ti.UI.createView({
      height: 243,
      width: 243,
      font: {
        fontSize: 13,
        fontWeight: "bold",
        fontFamily: "HelveticaNeue-Bold"
      }
    });
    this.comingSoon = Ti.UI.createView({
      backgroundImage: "images/match/layout/overlay-comingsoon.png",
      backgroundColor: "transparent",
      top: 20,
      height: 243,
      width: 243
    });
    this.liveLabel = Ti.UI.createLabel({
      text: "test test test test ",
      top: 0,
      left: 0,
      color: "#ffffff",
      height: 1500,
      width: 285,
      font: {
        fontSize: 13,
        fontWeight: "bold",
        fontFamily: "HelveticaNeue-Bold"
      }
    });
    this.liveView.add(this.comingSoon);
    toolbarLabel = Ti.UI.createLabel({
      text: "Live",
      color: "#ffffff",
      shadowColor: "#000000",
      textAlign: "center",
      font: {
        fontSize: 20,
        fontWeight: "bold",
        fontFamily: "HelveticaNeue-Bold"
      }
    });
    titleBar.add(dashboardButton);
    titleBar.add(toolbarLabel);
    this.liveContainer.add(toolsMenuContainer);
    this.liveContainer.add(titleBar);
    this.liveContainer.add(this.liveView);
    this.liveWindow.add(this.liveContainer);
    this.dashboardButton.addEventListener("click", function() {
      me.liveWindow.close();
      return me.dashboardWindow.show();
    });
    this.showLive = function() {
      if (Ti.Platform.name !== "android") {
        Ti.UI.iPhone.showStatusBar();
        return this.liveWindow.open({
          fullscreen: false
        });
      } else {
        return this.liveWindow.open({
          fullscreen: true
        });
      }
    };
    showLive();
    return this;
  };

}).call(this);
