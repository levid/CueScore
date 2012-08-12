class DashboardView extends Template
  defaults:
    displayType: null
  
  constructor: (displayType) ->
    _.extend @, @defaults
    
    @displayType = displayType
    
    Ti.UI.setBackgroundColor "#000000"
    
    $CS.Views.Dashboard.createMainWindow  = @createMainWindow
    $CS.Views.Dashboard.createMainView    = @createMainView
    $CS.Views.Dashboard.showGrid          = @showGrid
    $CS.Views.Dashboard.showList          = @showList
    
    @setUp()

  setUp: () ->
    @dashboardContainer = @getDashboardContainer()
    @titleBar           = @getTitleBar()
    @viewType           = @getDisplayType(@displayType)
    
    @dashboardWindow = $.Window
      title: 'Dashboard'
      id: 'dashboardWindow'
      orientationModes: $CS.Helpers.Application.createOrientiationModes
      
    @dashboardView = $.View
      id: 'dashboardView'
      
    @dashboardContainer.add   @viewType
    @dashboardView.add        @dashboardContainer
    @dashboardView.add        @titleBar
    @dashboardWindow.add      @dashboardView

    @dashboardWindow.addEventListener 'click', @handle_btn_click
    
  getTitleBar: () ->
    titleBarClass = new $CS.Views.Dashboard.TitleBarView(@displayType)
    titleBar = titleBarClass.titleBar
    titleBar
    
  getDashboardContainer: () ->
    @createDashboardContainer()

  createMainWindow: (options={}) ->
    window = Ti.UI.createWindow(options)
    window
    
  createMainView: (options={}) ->
    view = Ti.UI.createView(options)
    view
    
  getDisplayType: (type) ->
    if type == "grid"
      gridViewClass = new $CS.Views.Dashboard.GridView()
      @gridView      = gridViewClass.gridView
      @gridView
    else if type == "list"
      listViewClass = new $CS.Views.Dashboard.ListView()
      @listView      = listViewClass.listView
      @listView
    
  createDashboardContainer: ->
    dashboardContainer = Titanium.UI.createView(
      backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
      backgroundColor: "transparent"
      top: 44
      left: 0
      height: ($CS.Utilities.getPlatformHeight() - 44)
      width: $CS.Utilities.getPlatformWidth()
    )
    dashboardContainer
    
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

  isGrid: () =>
    @displayType is "grid"
    
  isList: () =>
    @displayType is "list"
    
  showGrid: () =>
    @displayType = "grid"
    @gridView.visible = true
    @listView.visible = false
    
  showList: () =>
    @displayType = "list"
    @gridView.visible = false
    @listView.visible = true

$CS.Views.Dashboard = DashboardView