class DashboardController
  opts: {}
  
  constructor: (@options) ->
    @options = _.extend({}, @opts, @options)
    Ti.UI.setBackgroundColor "#000000"
    
    @displayType = "grid"
    @loadDependencies()
    @createWindows()

  createWindows: () ->
    @dashboardWindow = $CS.Views.Dashboard.createMainWindow
      title:            'Dashboard'
      id:               'dashboardWindow'
      orientationModes: $CS.Helpers.Application.createOrientiationModes
      # exitOnClose: true

    @dashboardView = $CS.Views.Dashboard.createMainView
      id: 'dashboardView'
      
    # event handlers
    @dashboardWindow.addEventListener 'click', @handle_btn_click

    @dashboardContainerClass  = new root.DashboardContainer
    @dashboardContainer       = @dashboardContainerClass.dashboardContainer
    @gridViewClass            = new root.GridView
    @gridView                 = @gridViewClass.gridView

    @dashboardContainer.add   @gridView
    @dashboardView.add        @dashboardContainer
    @dashboardView.add        @dashboardContainerClass.titleBar
    @dashboardWindow.add      @dashboardView
    
  open: () ->
    unless Ti.Platform.name is "android"
      Ti.UI.iPhone.showStatusBar()
      @dashboardWindow.open 
        fullscreen: false
    else
      @dashboardWindow.open 
        fullscreen: true
    
  handle_btn_click: (e) =>
    console.warn "button clicked: #{JSON.stringify e}"
      
  loadDependencies: () ->
    # Ti.include "/js/Common.js"
    # Ti.include "/js/pages/matchSetup.js"
    # Ti.include "/js/pages/match.js"
    # Ti.include "/js/pages/toolViews/teams.js"
    # Ti.include "/js/pages/toolViews/activity.js"
    # Ti.include "/js/pages/toolViews/profile.js"
    # Ti.include "/js/pages/toolViews/news.js"
    # Ti.include "/js/pages/toolViews/events.js"
    # Ti.include "/js/pages/toolViews/live.js"
    # Ti.include "/js/pages/toolViews/rules.js"
    # Ti.include "/js/pages/toolViews/settings.js"
    # Ti.include "/js/pages/dashboardViews/dashboardCommonView.js"
    # Ti.include "/js/pages/dashboardViews/gridView.js"
    # Ti.include "/js/pages/dashboardViews/listView.js"

  isGrid = =>
    @displayType is "grid"
    
  isList = =>
    @displayType is "list"
    
  showGrid = =>
    @displayType = "grid"
    @gridView.visible = true
    listView.visible = false
    
  showList = =>
    @displayType = "list"
    @gridView.visible = false
    listView.visible = true
  
$CS.Controllers.DashboardController = DashboardController