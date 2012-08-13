// Generated by CoffeeScript 1.3.1
(function() {
  var ActivityView,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  ActivityView = (function(_super) {

    __extends(ActivityView, _super);

    ActivityView.name = 'ActivityView';

    ActivityView.prototype.defaults = {};

    function ActivityView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    ActivityView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.activityWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.activityContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.activityScrollView = Ti.UI.createScrollView({
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
      this.activityView = Ti.UI.createView({
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
      this.activityLabel = Ti.UI.createLabel({
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
      this.activityView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Activity",
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
      this.activityContainer.add(toolsMenuContainer);
      this.activityContainer.add(titleBar);
      this.activityContainer.add(this.activityView);
      this.activityWindow.add(this.activityContainer);
      this.dashboardButton.addEventListener("click", function() {
        _this.activityWindow.close();
        return _this.dashboardWindow.show();
      });
      ({
        showActivity: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.activityWindow.open({
              fullscreen: false
            });
          } else {
            return _this.activityWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showActivity();
    };

    return ActivityView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.ActivityView = ActivityView;

}).call(this);