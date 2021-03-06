// Generated by CoffeeScript 1.3.3
(function() {
  var MenuView,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  MenuView = (function(_super) {

    __extends(MenuView, _super);

    MenuView.prototype.defaults = {};

    function MenuView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    MenuView.prototype.setUp = function() {
      var titleBar, toolsMenuContainer;
      toolsMenuContainer = Ti.UI.createView({
        backgroundImage: (Ti.Platform.name !== "android" ? "images/match/layout/bg-menus-iphone.png" : "images/match/layout/bg-menus-android.png"),
        backgroundColor: "transparent",
        top: 44,
        left: 0,
        height: this.getPlatformHeight() - 44,
        width: this.getPlatformWidth()
      });
      titleBar = Ti.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/layout/titlebar-matches.png",
        top: 0,
        left: 0,
        width: this.getPlatformWidth(),
        height: 44,
        isNinePatch: false
      });
      this.dashboardButton = Ti.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/buttons/btn-tabmenu-backto-dashboard.png",
        top: 7,
        left: 8,
        width: 93,
        height: 30,
        isNinePatch: false
      });
      this.dashboardButtonLabel = Ti.UI.createLabel({
        text: "Dashboard",
        color: "#ffffff",
        shadowColor: "#000000",
        left: 13,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      return this.dashboardButton.add(this.dashboardButtonLabel);
    };

    return MenuView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.MenuView = MenuView;

}).call(this);
