var $CS, CueScore, root, _base;

root = this;

CueScore = root.CueScore = {
  API: {},
  App: {},
  Controllers: {
    DashboardController: {}
  },
  Models: {
    EightBall: {
      Player: {},
      Game: {},
      Match: {},
      Ranks: {},
      League: {},
      LeagueMatch: {},
      PracticeMatch: {},
      TournamentMatch: {}
    },
    NineBall: {
      Player: {},
      Game: {},
      Match: {},
      Ranks: {},
      League: {},
      LeagueMatch: {},
      PracticeMatch: {},
      TournamentMatch: {}
    },
    League: {
      Doubles: {},
      MixedDoubles: {},
      DoubleJeopardy: {},
      Womens: {},
      Masters: {},
      EightBall: {},
      NineBall: {}
    },
    Team: {}
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

if (typeof Ti !== "undefined" && Ti !== null) {
  Ti.include('vendor/tiquery/tiquery.js');
}

if (typeof Ti !== "undefined" && Ti !== null) {
  Ti.include('vendor/underscore/underscore-min.js');
}

if (typeof Ti !== "undefined" && Ti !== null) {
  Ti.include('vendor/backbone/backbone-min.js');
}

if (typeof Ti !== "undefined" && Ti !== null) {
  Ti.include('vendor/backbone/backbone.sync.js');
}

if (typeof Ti !== "undefined" && Ti !== null) {
  Ti.include('js/cuescore/utils/query_string_builder.js');
}

if (typeof Ti !== "undefined" && Ti !== null) {
  Ti.include('cuescore.js');
}

if (typeof (_base = $CS.App).init === "function") {
  _base.init();
}
