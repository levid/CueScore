CueScore.App =

  init: ->
    console "test"

  initTabGroup: ->
    CueScore.App.tabGroup = Ti.UI.createTabGroup()

    # Sample Tab
    sampleWindow = CueScore.Views.Sample.createMainWindow
      title:            'Sample'
      id:               'sampleWindow'
      orientationModes: CueScore.Helpers.Application.createOrientiationModes
    CueScore.App.sampleTab = Ti.UI.createTab
      id:               'sampleTab'
      className:        'tabElement'
      title:            'Sample'
      window:           sampleWindow

    # Bottom Tab Loader
    CueScore.App.tabGroup.addTab CueScore.App.sampleTab

    # Settings Tab
    settingsWindow = CueScore.Views.Settings.createMainWindow
      title:            'Settings'
      id:               'settingsWindow'
      orientationModes: CueScore.Helpers.Application.createOrientiationModes

    CueScore.App.settingsTab = Ti.UI.createTab
      id:               'settingsTab'
      className:        'tabElement'
      title:            'Settings'
      window:           settingsWindow

    # Bottom Tab Loader
    CueScore.App.tabGroup.addTab CueScore.App.settingsTab

    CueScore.App.tabGroup.addEventListener 'focus', (e) ->
      CueScore.App.currentTab = e.tab
      Ti.API.info(CueScore.App.currentTab)

    # Open Tabs
    CueScore.App.tabGroup.open()
