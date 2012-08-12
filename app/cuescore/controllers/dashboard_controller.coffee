class DashboardController
  opts: {}
  
  constructor: (@options) ->
    @options = _.extend({}, @opts, @options)
    
    @displayType = "grid"
    @createWindows()

  createWindows: () ->
    @dashboard = new $CS.Views.Dashboard(@displayType)
    
  open: () ->
    @dashboard.open()  
    
$CS.Controllers.DashboardController = DashboardController