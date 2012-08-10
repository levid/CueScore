var $CS, CueScore, root;

root = this;

CueScore = root.CueScore = {
  API: {},
  App: {},
  Controllers: {
    DashboardController: {}
  },
  Models: {
    Format: {
      EightBall: {
        Game: {},
        Match: {}
      }
    },
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
  },
  Window: {}
};

$CS = CueScore;

Ti.include('vendor/tiquery/tiquery.js');

Ti.include('vendor/underscore/underscore-min.js');

Ti.include('vendor/backbone/backbone-min.js');

Ti.include('vendor/backbone/backbone.sync.js');

Ti.include('js/utils/query_string_builder.js');

Ti.include('cuescore.js');

$CS.App.init();
