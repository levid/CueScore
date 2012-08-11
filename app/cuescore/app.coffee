$CS.App =

  init: ->
    console.log "test"
    
    gameModel = new $CS.Models.Game
    
    dashboardController = new $CS.Controllers.DashboardController
    dashboardController.open()
    
    # main = new $CS.Window.Main().render()
    # main.open()

    # postsController = new $CS.Controllers.PostsController
    
  initTabGroup: ->
    $CS.App.tabGroup = Ti.UI.createTabGroup()

    # Sample Tab
    sampleWindow = $CS.Views.Sample.createMainWindow
      title:            'Sample'
      id:               'sampleWindow'
      orientationModes: $CS.Helpers.Application.createOrientiationModes

    $CS.App.sampleTab = Ti.UI.createTab
      id:               'sampleTab'
      className:        'tabElement'
      title:            'Sample'
      window:           sampleWindow

    # Bottom Tab Loader
    $CS.App.tabGroup.addTab $CS.App.sampleTab

    # Settings Tab
    settingsWindow = $CS.Views.Settings.createMainWindow
      title:            'Settings'
      id:               'settingsWindow'
      orientationModes: $CS.Helpers.Application.createOrientiationModes

    $CS.App.settingsTab = Ti.UI.createTab
      id:               'settingsTab'
      className:        'tabElement'
      title:            'Settings'
      window:           settingsWindow

    # Login Window
    loginWindow = $CS.Views.Login.createLoginWindow
      title:            'Login'
      id:               'loginWindow'
      orientationModes: $CS.Helpers.Application.createOrientiationModes
      
    $CS.App.loginWindow = loginWindow
    

    # Bottom Tab Loader
    $CS.App.tabGroup.addTab $CS.App.settingsTab

    $CS.App.tabGroup.addEventListener 'focus', (e) ->
      $CS.App.currentTab = e.tab
      Ti.API.info($CS.App.currentTab)

    # Open Tabs
    $CS.App.tabGroup.open()
    # $CS.App.loginWindow.open()
    