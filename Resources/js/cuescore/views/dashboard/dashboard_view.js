// Generated by CoffeeScript 1.3.3
(function() {
  var DashboardView,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  DashboardView = (function(_super) {

    __extends(DashboardView, _super);

    DashboardView.prototype.defaults = {};

    function DashboardView(displayType) {
      this.showList = __bind(this.showList, this);

      this.showGrid = __bind(this.showGrid, this);

      this.isList = __bind(this.isList, this);

      this.isGrid = __bind(this.isGrid, this);

      this.handle_btn_click = __bind(this.handle_btn_click, this);
      _.extend(this, this.defaults);
      this.displayType = displayType;
      Ti.UI.setBackgroundColor("#000000");
      $CS.Views.Dashboard.createMainWindow = this.createMainWindow;
      $CS.Views.Dashboard.createMainView = this.createMainView;
      $CS.Views.Dashboard.showGrid = this.showGrid;
      $CS.Views.Dashboard.showList = this.showList;
      $CS.Views.Dashboard.isGrid = this.isGrid;
      $CS.Views.Dashboard.isList = this.isList;
      this.setUp();
    }

    DashboardView.prototype.setUp = function() {
      this.titleBar = this.getTitleBar();
      this.viewType = this.getDisplayType(this.displayType);
      this.dashboardWindow = $.Window({
        title: 'Dashboard',
        id: 'dashboardWindow',
        orientationModes: $CS.Helpers.Application.createOrientiationModes
      });
      this.dashboardView = $.View({
        id: 'dashboardView'
      });
      this.dashboardContainer = $.View({
        backgroundImage: (Ti.Platform.name !== "android" ? "images/match/layout/bg-menus-iphone.png" : "images/match/layout/bg-menus-android.png"),
        backgroundColor: "transparent",
        top: 44,
        left: 0,
        height: $CS.Utilities.getPlatformHeight() - 44,
        width: $CS.Utilities.getPlatformWidth()
      });
      this.dashboardContainer.add(this.viewType);
      this.dashboardView.add(this.dashboardContainer);
      this.dashboardView.add(this.titleBar);
      this.dashboardWindow.add(this.dashboardView);
      return this.bindEvents();
    };

    DashboardView.prototype.bindEvents = function() {
      return this.dashboardWindow.addEventListener('click', this.handle_btn_click);
    };

    DashboardView.prototype.handle_btn_click = function(e) {
      return console.warn("button clicked: " + (JSON.stringify(e)));
    };

    DashboardView.prototype.getTitleBar = function() {
      var titleBar, titleBarClass;
      titleBarClass = new $CS.Views.Dashboard.TitleBarView(this.displayType);
      titleBar = titleBarClass.titleBar;
      return titleBar;
    };

    DashboardView.prototype.createMainWindow = function(options) {
      var window;
      if (options == null) {
        options = {};
      }
      window = Ti.UI.createWindow(options);
      return window;
    };

    DashboardView.prototype.createMainView = function(options) {
      var view;
      if (options == null) {
        options = {};
      }
      view = Ti.UI.createView(options);
      return view;
    };

    DashboardView.prototype.getDisplayType = function(type) {
      var gridViewClass, listViewClass;
      if (this.isGrid()) {
        gridViewClass = new $CS.Views.Dashboard.GridView();
        this.gridView = gridViewClass.gridView;
        return this.gridView;
      } else if (this.isList()) {
        listViewClass = new $CS.Views.Dashboard.ListView();
        this.listView = listViewClass.listView;
        return this.listView;
      }
    };

    DashboardView.prototype.open = function() {
      if (Ti.Platform.name !== "android") {
        Ti.UI.iPhone.showStatusBar();
        return this.dashboardWindow.open({
          fullscreen: false
        });
      } else {
        return this.dashboardWindow.open({
          fullscreen: true
        });
      }
    };

    DashboardView.prototype.isGrid = function() {
      return this.displayType === "grid";
    };

    DashboardView.prototype.isList = function() {
      return this.displayType === "list";
    };

    DashboardView.prototype.showGrid = function() {
      this.displayType = "grid";
      this.gridView.visible = true;
      return this.listView.visible = false;
    };

    DashboardView.prototype.showList = function() {
      this.displayType = "list";
      this.gridView.visible = false;
      return this.listView.visible = true;
    };

    return DashboardView;

  })(Template);

  $CS.Views.Dashboard = DashboardView;

}).call(this);
