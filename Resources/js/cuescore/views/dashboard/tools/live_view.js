// Generated by CoffeeScript 1.3.3
(function() {
  var LiveView,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  LiveView = (function(_super) {

    __extends(LiveView, _super);

    LiveView.prototype.defaults = {};

    function LiveView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    LiveView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
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
        this.liveWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showLive: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.liveWindow.open({
              fullscreen: false
            });
          } else {
            return _this.liveWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showLive();
    };

    return LiveView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.LiveView = LiveView;

}).call(this);
