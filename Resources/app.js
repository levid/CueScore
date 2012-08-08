var CueScore, console, root;

root = {};

console = {
  log: function(str) {
    return Ti.API.info(str);
  }
};

CueScore = {
  Models: {},
  Helpers: {},
  Views: {
    Settings: {},
    Sample: {},
    Play: {},
    Teams: {},
    Activity: {},
    Profile: {},
    News: {},
    Events: {},
    Live: {},
    Rules: {}
  }
};

Ti.include('cuescore.js');

Ti.include('js/pages/dashboard.js');

CueScore.App.initTabGroup();
