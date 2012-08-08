class Dashboard
  constructor: () ->
    @displayType = "grid"
    @loadDependencies()
    @createWindows()
      
  createWindows: () =>
    @dashboardWindow = Ti.UI.createWindow
      orientationModes: [ Ti.UI.PORTRAIT ]
      exitOnClose: true

    @dashboardView = Ti.UI.createView
      backgroundColor: "transparent"
      top: 0
      isNinePatch: false

    @dashboardContainerClass  = new root.DashboardContainer
    @dashboardContainer       = @dashboardContainerClass.dashboardContainer
    @gridViewClass            = new root.GridView
    @gridView                 = @gridViewClass.gridView

    @dashboardContainer.add   @gridView
    @dashboardView.add        @dashboardContainer
    @dashboardView.add        @dashboardContainerClass.titleBar
    @dashboardWindow.add      @dashboardView
    
    Ti.UI.setBackgroundColor "#000000"
    unless Ti.Platform.name is "android"
      Ti.UI.iPhone.showStatusBar()
      @dashboardWindow.open fullscreen: false
    else
      @dashboardWindow.open fullscreen: true
      
  loadDependencies: () ->
    Ti.include "/js/Common.js"
    Ti.include "/js/pages/matchSetup.js"
    Ti.include "/js/pages/match.js"
    Ti.include "/js/pages/toolViews/teams.js"
    Ti.include "/js/pages/toolViews/activity.js"
    Ti.include "/js/pages/toolViews/profile.js"
    Ti.include "/js/pages/toolViews/news.js"
    Ti.include "/js/pages/toolViews/events.js"
    Ti.include "/js/pages/toolViews/live.js"
    Ti.include "/js/pages/toolViews/rules.js"
    Ti.include "/js/pages/toolViews/settings.js"
    Ti.include "/js/pages/dashboardViews/dashboardCommonView.js"
    Ti.include "/js/pages/dashboardViews/gridView.js"
    Ti.include "/js/pages/dashboardViews/listView.js"

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
  
root.Dashboard = new Dashboard
