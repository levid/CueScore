(function() {

  CueScore.App = {
    init: function() {
      return console("test");
    },
    initTabGroup: function() {
      var sampleWindow, settingsWindow;
      CueScore.App.tabGroup = Ti.UI.createTabGroup();
      sampleWindow = CueScore.Views.Sample.createMainWindow({
        title: 'Sample',
        id: 'sampleWindow',
        orientationModes: CueScore.Helpers.Application.createOrientiationModes
      });
      CueScore.App.sampleTab = Ti.UI.createTab({
        id: 'sampleTab',
        className: 'tabElement',
        title: 'Sample',
        window: sampleWindow
      });
      CueScore.App.tabGroup.addTab(CueScore.App.sampleTab);
      settingsWindow = CueScore.Views.Settings.createMainWindow({
        title: 'Settings',
        id: 'settingsWindow',
        orientationModes: CueScore.Helpers.Application.createOrientiationModes
      });
      CueScore.App.settingsTab = Ti.UI.createTab({
        id: 'settingsTab',
        className: 'tabElement',
        title: 'Settings',
        window: settingsWindow
      });
      CueScore.App.tabGroup.addTab(CueScore.App.settingsTab);
      CueScore.App.tabGroup.addEventListener('focus', function(e) {
        CueScore.App.currentTab = e.tab;
        return Ti.API.info(CueScore.App.currentTab);
      });
      return CueScore.App.tabGroup.open();
    }
  };

  CueScore.Helpers.Application = {
    createOrientiationModes: function() {
      var modes;
      modes = [Titanium.UI.PORTRAIT, Titanium.UI.UPSIDE_PORTRAIT, Titanium.UI.LANDSCAPE_LEFT, Titanium.UI.LANDSCAPE_RIGHT];
      return modes;
    }
  };

  CueScore.Views.Play.create9BallGameView = function(options) {
    var view;
    view = Ti.UI.createView(options);
    return view;
  };

  CueScore.Views.Sample.createMainWindow = function(options) {
    var window;
    window = Ti.UI.createWindow(options);
    return window;
  };

  CueScore.Views.Settings.createMainWindow = function(options) {
    var window;
    window = Ti.UI.createWindow(options);
    return window;
  };

}).call(this);
