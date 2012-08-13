// Generated by CoffeeScript 1.3.1
(function() {
  var EventsView,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  EventsView = (function(_super) {

    __extends(EventsView, _super);

    EventsView.name = 'EventsView';

    EventsView.prototype.defaults = {};

    function EventsView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    EventsView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.eventsWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.eventsContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.eventsScrollView = Ti.UI.createScrollView({
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
      this.eventsView = Ti.UI.createView({
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
      this.eventsLabel = Ti.UI.createLabel({
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
      this.eventsView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Events",
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
      this.eventsContainer.add(toolsMenuContainer);
      this.eventsContainer.add(titleBar);
      this.eventsContainer.add(this.eventsView);
      this.eventsWindow.add(this.eventsContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.eventsWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showEvents: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.eventsWindow.open({
              fullscreen: false
            });
          } else {
            return _this.eventsWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showEvents();
    };

    return EventsView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.EventsView = EventsView;

}).call(this);
