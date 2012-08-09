var $CS, CueScore, after, console, every, root, say;

root = {};

console = {
  log: function(str) {
    return Ti.API.info(str);
  },
  warn: function(str) {
    return Ti.API.warn(str);
  },
  error: function(str) {
    return Ti.API.error(str);
  }
};

say = function(msg) {
  return alert(msg);
};

after = function(ms, cb) {
  return setTimeout(cb, ms);
};

every = function(ms, cb) {
  return setInterval(cb, ms);
};

CueScore = {
  Controllers: {
    DashboardController: {}
  },
  Models: {
    Game: {}
  },
  Helpers: {},
  Views: {
    Dashboard: {},
    Settings: {},
    Sample: {},
    Play: {},
    Teams: {},
    Activity: {},
    Profile: {},
    News: {},
    Events: {},
    Login: {},
    Live: {},
    Rules: {},
    PostView: {},
    PostsView: {}
  },
  Utils: {
    QueryStringBuilder: {}
  }
};

$CS = CueScore;

Ti.include('vendor/underscore/underscore-min.js');

Ti.include('vendor/backbone/backbone-min.js');

Ti.include('vendor/backbone/backbone.sync.js');

Ti.include('js/utils/query_string_builder.js');

Ti.include('cuescore.js');

$CS.App.init();
