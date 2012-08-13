// Generated by CoffeeScript 1.3.1
(function() {
  var DashboardController;

  DashboardController = (function() {

    DashboardController.name = 'DashboardController';

    DashboardController.prototype.opts = {};

    function DashboardController(options) {
      this.options = options;
      this.options = _.extend({}, this.opts, this.options);
      this.displayType = "grid";
      this.createWindows();
    }

    DashboardController.prototype.createWindows = function() {
      return this.dashboard = new $CS.Views.Dashboard(this.displayType);
    };

    DashboardController.prototype.open = function() {
      return this.dashboard.open();
    };

    return DashboardController;

  })();

  $CS.Controllers.DashboardController = DashboardController;

}).call(this);