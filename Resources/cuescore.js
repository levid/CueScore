(function() {
  var API, ActivityView, AppSync, DashboardController, DashboardView, DoubleJeopardy, Doubles, EventsView, Game, GridView, League, LeagueMatch, ListView, LiveView, Masters, Match, MenuView, MixedDoubles, NewsView, Player, Post, PostViewController, Posts, PostsController, PostsViewController, PracticeMatch, ProfileView, QueryStringBuilder, Rank, Ranks, RulesView, SettingsView, Team, TeamsView, Template, TitleBarView, TournamentMatch, Utilities, Womens, after, console, every, say,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $CS.App = {
    init: function() {
      var dashboardController, gameModel;
      gameModel = new $CS.Models.Game;
      dashboardController = new $CS.Controllers.DashboardController;
      return dashboardController.open();
    },
    initTabGroup: function() {
      var loginWindow, sampleWindow, settingsWindow;
      $CS.App.tabGroup = Ti.UI.createTabGroup();
      sampleWindow = $CS.Views.Sample.createMainWindow({
        title: 'Sample',
        id: 'sampleWindow',
        orientationModes: $CS.Helpers.Application.createOrientiationModes
      });
      $CS.App.sampleTab = Ti.UI.createTab({
        id: 'sampleTab',
        className: 'tabElement',
        title: 'Sample',
        window: sampleWindow
      });
      $CS.App.tabGroup.addTab($CS.App.sampleTab);
      settingsWindow = $CS.Views.Settings.createMainWindow({
        title: 'Settings',
        id: 'settingsWindow',
        orientationModes: $CS.Helpers.Application.createOrientiationModes
      });
      $CS.App.settingsTab = Ti.UI.createTab({
        id: 'settingsTab',
        className: 'tabElement',
        title: 'Settings',
        window: settingsWindow
      });
      loginWindow = $CS.Views.Login.createLoginWindow({
        title: 'Login',
        id: 'loginWindow',
        orientationModes: $CS.Helpers.Application.createOrientiationModes
      });
      $CS.App.loginWindow = loginWindow;
      $CS.App.tabGroup.addTab($CS.App.settingsTab);
      $CS.App.tabGroup.addEventListener('focus', function(e) {
        $CS.App.currentTab = e.tab;
        return Ti.API.info($CS.App.currentTab);
      });
      return $CS.App.tabGroup.open();
    }
  };

  API = (function() {

    API.name = 'API';

    function API(login, password) {
      this.login = login;
      this.password = password;
      $CS.API_ENDPOINT = "http://localhost:3009";
    }

    API.prototype.requestURI = function(path, query) {
      var key, uri, value;
      if (query == null) {
        query = {};
      }
      uri = "" + $CS.API_ENDPOINT + path + ".json?";
      for (key in query) {
        if (!__hasProp.call(query, key)) continue;
        value = query[key];
        uri += "" + key + "=" + (escape(value)) + "&";
      }
      return uri;
    };

    API.prototype.request = function(path, options, authenticated) {
      var data, message, uri, xhr;
      if (authenticated == null) {
        authenticated = true;
      }
      if (options.method == null) {
        options.method = 'GET';
      }
      if (options.query == null) {
        options.query = {};
      }
      if (options.success == null) {
        options.success = function() {
          return Ti.API.info;
        };
      }
      if (options.error == null) {
        options.error = function() {
          return Ti.API.error;
        };
      }
      xhr = Ti.Network.createHTTPClient();
      xhr.onreadystatechange = function(e) {
        var data;
        if (this.readyState === 4) {
          try {
            data = JSON.parse(this.responseText);
            if (data.error != null) {
              return options.error(data);
            } else {
              return options.success(data);
            }
          } catch (exception) {
            return options.error(exception);
          }
        }
      };
      uri = this.requestURI(path, options.query);
      xhr.open(options.method, uri);
      if (authenticated) {
        xhr.setRequestHeader('Authorization', 'Basic ' + Ti.Utils.base64encode(this.login + ':' + this.password));
      }
      message = "Executing ";
      message += authenticated ? "Authenticated " : "Unauthenticated ";
      message += "" + options.method + " " + uri;
      if (options.debug) {
        Ti.API.debug(message);
      }
      if (options.body != null) {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
        data = JSON.stringify(options.body);
        if (options.debug) {
          Ti.API.debug(data);
        }
        return xhr.send(data);
      } else {
        return xhr.send();
      }
    };

    API.prototype.get = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'GET';
      return this.request(path, options, authenticated);
    };

    API.prototype.post = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'POST';
      return this.request(path, options, authenticated);
    };

    API.prototype.put = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'PUT';
      return this.request(path, options, authenticated);
    };

    API.prototype["delete"] = function(path, options, authenticated) {
      if (authenticated == null) {
        authenticated = true;
      }
      options.method = 'DELETE';
      return this.request(path, options, authenticated);
    };

    API.prototype.authenticate = function(options) {
      Ti.API.debug("$CS.API.authenticate");
      return this.get('/me', options);
    };

    API.prototype.logout = function(options) {
      Ti.API.debug("$CS.API.logout");
      return this["delete"]('/logout', options);
    };

    API.prototype.forgotPassword = function(email, options) {
      Ti.API.debug("$CS.API.forgotPassword");
      options.query = {};
      options.query.email = email;
      return this.post('/passwords', options, false);
    };

    API.prototype.me = function(options) {
      Ti.API.debug("$CS.API.me");
      return this.authenticate(options);
    };

    return API;

  })();

  $CS.API = new API;

  AppSync = (function() {

    AppSync.name = 'AppSync';

    function AppSync(ip, port) {
      this.ip = ip != null ? ip : 'localhost';
      this.port = port != null ? port : 3000;
      this.current = void 0;
      this.code = null;
    }

    AppSync.prototype.wait = function() {
      var _this = this;
      return setTimeout((function() {
        return _this.sync();
      }), 3000);
    };

    AppSync.prototype.sync = function() {
      var appsync, self, xhr;
      self = this;
      appsync = Tiapp.AppSync;
      xhr = Ti.Network.createHTTPClient();
      xhr.setTimeout(40000);
      xhr.onload = function() {
        var error_message, result;
        xhr.abort();
        result = JSON.parse(this.responseText);
        if (!result) {
          this.onerror();
        }
        try {
          if (result.success) {
            if (this.current && this.current.close !== undefined) {
              this.current.close();
            }
            if (self.code !== result.code) {
              self.code = result.code;
              this.current = eval(result.code);
              $.log("Deployed");
            }
          }
          return self.wait();
        } catch (e) {
          error_message = void 0;
          if (e.line === undefined) {
            error_message = e.toString();
          } else {
            error_message = "Line " + e.line + ": " + e.message;
          }
          return $.debug(error_message);
        }
      };
      xhr.onerror = function() {
        alert("HttpRequest ERROR, Please check if server started!");
        if (this.current && this.current.close !== undefined) {
          return this.current.close();
        }
      };
      xhr.open("GET", "http://" + this.ip + ":" + this.port);
      return xhr.send();
    };

    return AppSync;

  })();

  Array.prototype.contains = function(obj) {
    var i;
    i = this.length;
    if ((function() {
      var _results;
      _results = [];
      while (i--) {
        _results.push(this[i] === obj);
      }
      return _results;
    }).call(this)) {
      return true;
    }
    return false;
  };

  Ti.UI.createActivityIndicator;

  Ti.UI.createButton;

  Ti.UI.createEmailDialog;

  Ti.UI.createImageView;

  Ti.UI.createLabel;

  Ti.UI.createOptionDialog;

  Ti.UI.createPicker;

  Ti.UI.createProgressBar;

  Ti.UI.createScrollView;

  Ti.UI.createTab;

  Ti.UI.createTabGroup;

  Ti.UI.createTableView;

  Ti.UI.createTableViewRow;

  Ti.UI.createToolbar;

  Ti.UI.createView;

  Ti.UI.createWebView;

  Ti.UI.createWindow;

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

  QueryStringBuilder = (function() {

    QueryStringBuilder.name = 'QueryStringBuilder';

    function QueryStringBuilder() {}

    QueryStringBuilder.prototype.stringify = function(obj, prefix, accum) {
      if (accum == null) {
        accum = {};
      }
      if (_.isArray(obj)) {
        this.stringifyArray(obj, prefix, accum);
      } else if (_.isString(obj) || _.isNumber(obj) || _.isDate(obj) || ("" + obj) === "[object TiBlob]") {
        this.stringifyString(obj, prefix, accum);
      } else if (_.isBoolean(obj)) {
        this.stringifyBoolean(obj, prefix, accum);
      } else if (obj != null) {
        if (obj.attributes != null) {
          this.stringifyObject(obj.attributes, prefix, accum);
        } else {
          this.stringifyObject(obj, prefix, accum);
        }
      } else {
        return prefix;
      }
      return accum;
    };

    QueryStringBuilder.prototype.stringifyBoolean = function(bool, prefix, accum) {
      if (!prefix) {
        throw new TypeError("Stringify expects an object");
      }
      return accum[prefix] = bool ? 1 : 0;
    };

    QueryStringBuilder.prototype.stringifyString = function(str, prefix, accum) {
      if (!prefix) {
        throw new TypeError("Stringify expects an object");
      }
      return accum[prefix] = str;
    };

    QueryStringBuilder.prototype.stringifyArray = function(arr, prefix, accum) {
      var i, item, _i, _len, _results;
      if (!prefix) {
        throw new TypeError("Stringify expects an object");
      }
      i = 0;
      _results = [];
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        item = arr[_i];
        _results.push(this.stringify(item, "" + prefix + "[" + (i++) + "]", accum));
      }
      return _results;
    };

    QueryStringBuilder.prototype.stringifyObject = function(obj, prefix, accum) {
      var key, new_key, new_prefix, value, _results;
      _results = [];
      for (key in obj) {
        value = obj[key];
        if (key.match(/_preview$/)) {
          continue;
        }
        new_key = key;
        if (_.isArray(value)) {
          new_key = "" + key + "_attributes";
        }
        new_prefix = '';
        if (prefix) {
          new_prefix = "" + prefix + "[" + (encodeURIComponent(new_key)) + "]";
        } else {
          new_prefix = encodeURIComponent(new_key);
        }
        _results.push(this.stringify(value, new_prefix, accum));
      }
      return _results;
    };

    return QueryStringBuilder;

  })();

  $CS.Utilities.QueryStringBuilder = QueryStringBuilder;

  Backbone.setDomLibrary(TiQuery);

  Template = (function(_super) {

    __extends(Template, _super);

    Template.name = 'Template';

    function Template(options) {
      this._configure(options || {});
      this.initialize.apply(this, arguments);
      this.delegateEvents();
    }

    Template.prototype.delegateEvents = function() {};

    return Template;

  })(Backbone.View);

  Utilities = (function() {
    var getScoreRatio;

    Utilities.name = 'Utilities';

    Utilities.prototype.defaults = {};

    function Utilities(options) {
      var i;
      if (options == null) {
        options = {};
      }
      _.extend(this, this.defaults);
      Array.prototype.exists = function(search) {};
      i = 0;
      while (i < this.length) {
        if (this[i] === search) {
          return true;
        }
        i++;
      }
      false;

    }

    getScoreRatio = function(playerScore, playerBallCount) {
      return playerScore / playerBallCount;
    };

    Utilities.prototype.getPlatformWidth = function() {
      return Ti.Platform.displayCaps.platformWidth;
    };

    Utilities.prototype.getPlatformHeight = function() {
      return Ti.Platform.displayCaps.platformHeight - 22;
    };

    return Utilities;

  })();

  $CS.Utilities = new Utilities;

  $CS.Window.Main = (function(_super) {

    __extends(Main, _super);

    Main.name = 'Main';

    function Main() {
      return Main.__super__.constructor.apply(this, arguments);
    }

    Main.prototype.initialize = function() {
      this.main_window = $.Window({
        backgroundColor: "#1798cc"
      });
      this.content_window = $.Window({
        backgroundColor: "#1798cc",
        navBarHidden: false,
        title: 'Main Window'
      });
      this.nav_group = Ti.UI.iPhone.createNavigationGroup({
        window: this.content_window
      });
      this.label1 = $.Label({
        text: 'Test Window',
        top: 100,
        height: 150,
        color: '#fff',
        font: {
          fontSize: 50
        },
        textAlign: 'center'
      });
      this.button = $.Button({
        title: 'click to show window 2',
        top: 250,
        width: 200,
        height: 50,
        color: '#000'
      });
      return this.bind();
    };

    Main.prototype.open_second_window = function() {
      return this.nav_group.open(new $CS.Window.Second().render());
    };

    Main.prototype.bind = function() {
      var _this = this;
      $(this.button).click(function() {
        return _this.open_second_window();
      });
      return this.main_window.addEventListener('close', function(e) {
        return _this.destroy();
      });
    };

    Main.prototype.render = function() {
      this.content_window.add(this.label1);
      this.content_window.add(this.button);
      this.main_window.add(this.nav_group);
      return this.main_window;
    };

    Main.prototype.destroy = function() {
      this.label1 = null;
      this.button = null;
      this.nav_group = null;
      return this.main_window.close();
    };

    return Main;

  })(Template);

  $CS.Window.Second = (function(_super) {

    __extends(Second, _super);

    Second.name = 'Second';

    function Second() {
      return Second.__super__.constructor.apply(this, arguments);
    }

    Second.prototype.initialize = function() {
      this.label1 = $.Label({
        text: 'Hello, world!',
        top: 100,
        height: 150,
        color: '#fff',
        font: {
          fontSize: 50
        },
        textAlign: 'center'
      });
      this.label2 = $.Label({
        text: 'This is the Second Window',
        top: 50,
        height: 100,
        color: '#1798cc',
        font: {
          fontSize: 20
        },
        textAlign: 'center'
      });
      this.button = $.Button({
        title: 'say hello!',
        top: 250,
        width: 100,
        height: 50,
        color: '#000'
      });
      this.window = $.Window({
        backgroundColor: '#333',
        title: 'Second Window',
        backButtonTitle: 'Back'
      });
      return this.bind();
    };

    Second.prototype.bind = function() {
      var _this = this;
      $(this.button).click(function(e) {
        return alert('hello!');
      });
      return this.window.addEventListener('close', function(e) {
        return _this.destroy();
      });
    };

    Second.prototype.render = function() {
      this.window.add(this.label1);
      this.window.add(this.label2);
      this.window.add(this.button);
      return this.window;
    };

    Second.prototype.destroy = function() {
      this.label1 = null;
      this.label2 = null;
      this.button = null;
      return this.window.close();
    };

    return Second;

  })(Template);

  Game = (function(_super) {

    __extends(Game, _super);

    Game.name = 'Game';

    Game.prototype.defaults = {
      stripes: 1,
      solids: 2,
      innings: 0,
      match_ended_callback: function() {},
      number_of_innings: 0,
      ended: false,
      balls_hit_in: {
        stripes: [],
        solids: []
      },
      last_ball_hit_in: null,
      on_break: true,
      breaking_player_still_shooting: true,
      scratch_on_eight: false,
      early_eight: false,
      player: {
        one: {
          eight_ball: [],
          eight_on_snap: false,
          break_and_run: false,
          timeouts_taken: 0,
          callback: function() {},
          ball_type: null,
          has_won: false
        },
        two: {
          eight_ball: [],
          eight_on_snap: false,
          break_and_run: false,
          timeouts_taken: 0,
          callback: function() {},
          ball_type: null,
          has_won: false
        }
      }
    };

    function Game(options) {
      _.extend(this, this.defaults);
      this.player.one.callback = options.addToPlayerOne;
      this.player.two.callback = options.addToPlayerTwo;
      this.match_ended_callback = options.callback;
      this.player.one.callback().timeouts_taken = 0;
      this.player.two.callback().timeouts_taken = 0;
    }

    Game.prototype.getCurrentlyUpPlayer = function() {
      if (this.player.one.callback().currently_up === true) {
        return this.player.one.callback();
      }
      return this.player.two.callback();
    };

    Game.prototype.getWinningPlayer = function() {
      if (this.player.one.has_won === true) {
        return this.player.one;
      } else if (this.player.two.has_won === true) {
        return this.player.two;
      }
    };

    Game.prototype.getWinningPlayerName = function() {
      return this.getWinningPlayer().callback().getFirstNameWithInitials();
    };

    Game.prototype.getBallsHitInByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player.one.ball_type === this.stripes) {
          return this.balls_hit_in.stripes.concat(this.player.one.eight_ball);
        } else {
          if (this.player.one.ball_type === this.solids) {
            return this.balls_hit_in.solids.concat(this.player.one.eight_ball);
          }
          return [];
        }
      }
      if (playerNum === 2) {
        if (this.player.two.ball_type === this.stripes) {
          return this.balls_hit_in.stripes.concat(this.player.two.eight_ball);
        } else {
          if (this.player.two.ball_type === this.solids) {
            return this.balls_hit_in.solids.concat(this.player.two.eight_ball);
          }
          return [];
        }
      }
    };

    Game.prototype.getGameScore = function() {
      return this.getBallsHitInByPlayer(1).length + "-" + this.getBallsHitInByPlayer(2).length;
    };

    Game.prototype.getBallsHitIn = function() {
      return this.balls_hit_in.solids.concat(this.balls_hit_in.stripes.concat(this.player.two.eight_ball.concat(this.player.one.eight_ball)));
    };

    Game.prototype.getCurrentPlayerRemainingTimeouts = function() {
      if (this.player.one.callback().currently_up === true) {
        return this.player.one.callback().timeouts_allowed - this.player.one.timeouts_taken;
      } else {
        return this.player.two.callback().timeouts_allowed - this.player.two.timeouts_taken;
      }
    };

    Game.prototype.setPlayerWon = function(playerNum) {
      if (playerNum === 1) {
        this.player.one.has_won = true;
        return this.player.one.callback().games_won += 1;
      } else if (playerNum === 2) {
        this.player.two.has_won = true;
        return this.player.two.callback().games_won += 1;
      }
    };

    Game.prototype.setEightOnSnapByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player.one.eight_on_snap !== true) {
          this.player.one.callback().addToEightOnSnaps(1);
        }
        return this.player.one.eight_on_snap = true;
      } else if (playerNum === 2) {
        if (this.player.two.eight_on_snap !== true) {
          this.player.two.callback().addToEightOnSnaps(1);
        }
        return this.player.two.eight_on_snap = true;
      }
    };

    Game.prototype.setBreakAndRunByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player.one.break_and_run !== true) {
          this.player.one.callback().addToBreakAndRuns(1);
        }
        return this.player.one.break_and_run = true;
      } else if (playerNum === 2) {
        if (this.player.two.break_and_run !== true) {
          this.player.two.callback().addToBreakAndRuns(1);
        }
        return this.player.two.break_and_run = true;
      }
    };

    Game.prototype.setBallTypeByPlayer = function(playerNum, type) {
      if (playerNum === 1 && type === "stripes") {
        this.player.one.ball_type = this.stripes;
        this.player.two.ball_type = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "stripes") {
        this.player.two.ball_type = this.stripes;
        this.player.one.ball_type = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 1 && type === "solids") {
        this.player.one.ball_type = this.solids;
        this.player.two.ball_type = this.stripes;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "solids") {
        this.player.two.ball_type = this.solids;
        this.player.one.ball_type = this.stripes;
        return this.checkForWinner();
      }
    };

    Game.prototype.hitSafety = function() {
      this.getCurrentlyUpPlayer().addToSafeties(1);
      return this.nextPlayerIsUp();
    };

    Game.prototype.hitScratchOnEight = function() {
      this.scratch_on_eight = true;
      this.ended = true;
      if (this.player.one.callback().currently_up === true) {
        this.player.two.has_won = true;
        this.player.one.callback().currently_up = false;
        this.player.two.callback().currently_up = true;
      } else {
        this.player.one.has_won = true;
        this.player.two.callback().currently_up = false;
        this.player.one.callback().currently_up = true;
      }
      return this.match_ended_callback();
    };

    Game.prototype.shotMissed = function() {
      return this.nextPlayerIsUp();
    };

    Game.prototype.addToNumberOfInnings = function(num) {
      return this.number_of_innings += num;
    };

    Game.prototype.takeTimeout = function() {
      if (this.getCurrentPlayerRemainingTimeouts() > 0) {
        if (this.player.one.callback().currently_up === true) {
          return this.player.one.timeouts_taken += 1;
        } else {
          return this.player.two.timeouts_taken += 1;
        }
      }
    };

    Game.prototype.breakIsOver = function() {
      return this.on_break = false;
    };

    Game.prototype.end = function() {
      return this.ended = true;
    };

    Game.prototype.scoreBall = function(ballNumber) {
      if (!(this.getBallsHitIn().indexOf(ballNumber) >= 0)) {
        this.last_ball_hit_in = ballNumber;
        if (ballNumber > 0 && ballNumber < 8) {
          this.balls_hit_in.solids.push(ballNumber);
        } else if (ballNumber > 8 && ballNumber < 16) {
          this.balls_hit_in.stripes.push(ballNumber);
        } else {
          if (this.player.one.callback().currently_up === true) {
            this.player.one.eight_ball.push(ballNumber);
          } else {
            if (this.player.two.callback().currently_up === true) {
              this.player.two.eight_ball.push(ballNumber);
            }
          }
          if (this.on_break === true) {
            if (this.balls_hit_in.solids.length !== 7 && this.balls_hit_in.stripes.length !== 7) {
              if (this.player.one.callback().currently_up === true) {
                this.setEightOnSnapByPlayer(1);
              } else {
                if (this.player.two.callback().currently_up === true) {
                  this.setEightOnSnapByPlayer(2);
                }
              }
            }
          } else {
            if (this.balls_hit_in.solids.length !== 7 && this.balls_hit_in.stripes.length !== 7) {
              this.early_eight = true;
              if (this.player.one.callback().currently_up === true) {
                this.player.one.callback().currently_up = false;
                this.player.two.callback().currently_up = true;
              } else if (this.player.two.callback().currently_up === true) {
                this.player.one.callback().currently_up = true;
                this.player.two.callback().currently_up = false;
              }
            }
          }
        }
        return this.checkForWinner();
      }
    };

    Game.prototype.checkForWinner = function() {
      if (this.getBallsHitIn().indexOf(8) >= 0) {
        this.ended = true;
      }
      if (this.ended === true) {
        if (this.breaking_player_still_shooting === true && (this.balls_hit_in.solids.length === 7 || this.balls_hit_in.stripes.length === 7)) {
          if (this.player.one.callback().currently_up === true) {
            this.setBreakAndRunByPlayer(1);
            this.player.one.ball_type = this.solids;
            this.player.two.ball_type = this.stripes;
          } else if (this.player.two.callback().currently_up === true) {
            this.setBreakAndRunByPlayer(2);
            this.player.two.ball_type = this.solids;
            this.player.one.ball_type = this.stripes;
          }
        }
        if (this.player.one.eight_ball.indexOf(8) >= 0 && this.on_break === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8 && this.getBallsHitInByPlayer(2).length !== 8) {
            this.setPlayerWon(2);
          } else if (this.getBallsHitInByPlayer(1).length === 8) {
            this.setPlayerWon(1);
          }
        } else if (this.player.two.eight_ball.indexOf(8) >= 0 && this.on_break === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8 && this.getBallsHitInByPlayer(2).length !== 8) {
            this.setPlayerWon(1);
          } else if (this.getBallsHitInByPlayer(2).length === 8) {
            this.setPlayerWon(2);
          }
        } else {
          if (this.player.one.callback().currently_up === true) {
            this.setPlayerWon(1);
          } else if (this.player.two.callback().currently_up === true) {
            this.setPlayerWon(2);
          }
        }
        return this.match_ended_callback();
      }
    };

    Game.prototype.nextPlayerIsUp = function() {
      if (this.on_break !== true || ((this.player.two.callback().currently_up === true || this.player.one.callback().currently_up === true) && this.getBallsHitIn().length === 0)) {
        if (this.player.one.callback().currently_up === true) {
          this.player.two.callback().currently_up = true;
          this.player.one.callback().currently_up = false;
          if (this.player.one.ball_type == null) {
            if (this.balls_hit_in.solids.length > 0 && this.balls_hit_in.stripes.length === 0) {
              this.player.one.ball_type = this.solids;
              this.player.two.ball_type = this.stripes;
            } else if (this.balls_hit_in.solids.length === 0 && this.balls_hit_in.stripes.length > 0) {
              this.player.one.ball_type = this.stripes;
              this.player.two.ball_type = this.solids;
            }
          }
        } else if (this.player.two.callback().currently_up === true) {
          this.player.two.callback().currently_up = false;
          this.player.one.callback().currently_up = true;
          this.addToNumberOfInnings(1);
          if (this.player.two.ball_type == null) {
            if (this.balls_hit_in.solids.length === 0 && this.balls_hit_in.stripes.length > 0) {
              this.player.one.ball_type = this.solids;
              this.player.two.ball_type = this.stripes;
            } else if (this.balls_hit_in.solids.length > 0 && this.balls_hit_in.stripes.length === 0) {
              this.player.one.ball_type = this.stripes;
              this.player.two.ball_type = this.solids;
            }
          }
        } else {
          this.player.one.callback().currently_up = true;
        }
        this.breaking_player_still_shooting = false;
      }
      return this.on_break = false;
    };

    Game.prototype.toJSON = function() {
      return {
        player_one_timeouts_taken: this.player.one.timeouts_taken,
        player_two_timeouts_taken: this.player.two.timeouts_taken,
        player_one_eight_on_snap: this.player.one.eight_on_snap,
        player_one_break_and_run: this.player.one.break_and_run,
        player_two_eight_on_snap: this.player.two.eight_on_snap,
        player_two_break_and_run: this.player.two.break_and_run,
        player_one_ball_type: this.player.one.ball_type,
        player_two_ball_type: this.player.two.ball_type,
        player_one_eight_ball: this.player.one.eight_ball,
        player_two_eight_ball: this.player.two.eight_ball,
        player_one_won: this.player.one.has_won,
        player_two_won: this.player.two.has_won,
        number_of_innings: this.number_of_innings,
        early_eight: this.early_eight,
        scratch_on_eight: this.scratch_on_eight,
        breaking_player_still_shooting: this.breaking_player_still_shooting,
        striped_balls_hit_in: this.balls_hit_in.stripes,
        solid_balls_hit_in: this.balls_hit_in.solids,
        last_ball_hit_in: this.last_ball_hit_in,
        on_break: this.on_break,
        ended: this.ended
      };
    };

    Game.prototype.fromJSON = function(gameJSON) {
      this.player.one.timeouts_taken = gameJSON.player_one_timeouts_taken;
      this.player.two.timeouts_taken = gameJSON.player_two_timeouts_taken;
      this.player.one.eight_on_snap = gameJSON.player_one_eight_on_snap;
      this.player.one.break_and_run = gameJSON.player_one_break_and_run;
      this.player.two.eight_on_snap = gameJSON.player_two_eight_on_snap;
      this.player.two.break_and_run = gameJSON.player_two_break_and_run;
      this.player.one.ball_type = gameJSON.player_one_ball_type;
      this.player.two.ball_type = gameJSON.player_two_ball_type;
      this.player.one.eight_ball = gameJSON.player_one_eight_ball;
      this.player.two.eight_ball = gameJSON.player_two_eight_ball;
      this.player.one.has_won = gameJSON.player_one_won;
      this.player.two.has_won = gameJSON.player_two_won;
      this.number_of_innings = gameJSON.number_of_innings;
      this.breaking_player_still_shooting = gameJSON.breaking_player_still_shooting;
      this.balls_hit_in.solids = gameJSON.solid_balls_hit_in;
      this.balls_hit_in.stripes = gameJSON.striped_balls_hit_in;
      this.last_ball_hit_in = gameJSON.last_ball_hit_in;
      this.on_break = gameJSON.on_break;
      return this.ended = gameJSON.ended;
    };

    return Game;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.Game = Game;

  League = (function(_super) {

    __extends(League, _super);

    League.name = 'League';

    League.prototype.defaults = {};

    function League(options) {
      if (options == null) {
        options = {};
      }
      _.extend(this, this.defaults);
    }

    return League;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.League = League;

  LeagueMatch = (function(_super) {

    __extends(LeagueMatch, _super);

    LeagueMatch.name = 'LeagueMatch';

    LeagueMatch.prototype.defaults = {
      game_type: null,
      match: [
        {
          one: null,
          two: null,
          three: null,
          four: null,
          five: null
        }
      ],
      team_number: "",
      home_team: {
        number: null,
        name: null,
        signed: false
      },
      away_team: {
        number: null,
        name: null,
        signed: false
      },
      start_time: null,
      end_time: "",
      table_type: null,
      small_json: false,
      league_match_id: 0
    };

    function LeagueMatch(GameType, HomeTeamNumber, AwayTeamNumber, HomeTeamName, AwayTeamName, StartTime, TableType) {
      _.extend(this, this.defaults);
      this.game_type = "EightBall";
      this.home_team.number = HomeTeamNumber || null;
      this.home_team.name = HomeTeamName || "";
      this.away_team.number = AwayTeamNumber || null;
      this.away_team.name = AwayTeamName || "";
      this.start_time = StartTime || "";
      this.table_type = TableType || "";
      DataService.saveLeagueMatch(this, function(id) {
        return this.league_match_id = id;
      });
    }

    LeagueMatch.prototype.getHomeTeamScore = function() {
      var totalScore;
      totalScore = 0;
      totalScore = this.match['one'].getMatchPointsByTeamNumber(this.home_team.number);
      totalScore += this.match['two'].getMatchPointsByTeamNumber(this.home_team.number);
      totalScore += this.match['three'].getMatchPointsByTeamNumber(this.home_team.number);
      totalScore += this.match['four'].getMatchPointsByTeamNumber(this.home_team.number);
      totalScore += this.match['five'].getMatchPointsByTeamNumber(this.home_team.number);
      return totalScore;
    };

    LeagueMatch.prototype.getAwayTeamScore = function() {
      var totalScore;
      totalScore = this.match['one'].getMatchPointsByTeamNumber(this.away_team.number);
      totalScore += this.match['two'].getMatchPointsByTeamNumber(this.away_team.number);
      totalScore += this.match['three'].getMatchPointsByTeamNumber(this.away_team.number);
      totalScore += this.match['four'].getMatchPointsByTeamNumber(this.away_team.number);
      totalScore += this.match['five'].getMatchPointsByTeamNumber(this.away_team.number);
      return totalScore;
    };

    LeagueMatch.prototype.setMatch = function(matchData, matchNum) {
      var matchNumString;
      matchNumString = null;
      if (matchNum === 1) {
        matchNumString = "one";
      } else if (matchNum === 2) {
        matchNumString = "two";
      } else if (matchNum === 3) {
        matchNumString = "three";
      } else if (matchNum === 4) {
        matchNumString = "four";
      } else if (matchNum === 5) {
        matchNumString = "five";
      }
      this.match[matchNumString] = match;
      this.match[matchNumString].league_match_id = this.league_match_id;
      if (!(this.match[matchNumString].original_id != null) || this.match[matchNumString].original_id === 0) {
        return DataService.saveMatch(this.match[matchNumString], function(id) {
          return this.match[matchNumString].original_id = id;
        });
      }
    };

    LeagueMatch.prototype.getMatchPointsByTeam = function(team) {
      var awayScore, homeScore, name, names, _fn, _fn1, _i, _j, _len, _len1,
        _this = this;
      if (team === "home") {
        homeScore = 0;
        names = ['one', 'two', 'three', 'four', 'five'];
        _fn = function(name) {
          if (_this.match[name].player_one.team_number = _this.home_team.number) {
            return homeScore += _this.match[name].getMatchPointsByPlayer(1);
          } else {
            return homeScore += _this.match[name].getMatchPointsByPlayer(2);
          }
        };
        for (_i = 0, _len = names.length; _i < _len; _i++) {
          name = names[_i];
          _fn(name);
        }
        return homeScore;
      } else if (team === "away") {
        awayScore = 0;
        names = ['one', 'two', 'three', 'four', 'five'];
        _fn1 = function(name) {
          if (_this.match[name].player_one.team_number === _this.away_team.number) {
            return awayScore += _this.match[name].getMatchPointsByPlayer(1);
          } else {
            return awayScore += _this.match[name].getMatchPointsByPlayer(2);
          }
        };
        for (_j = 0, _len1 = names.length; _j < _len1; _j++) {
          name = names[_j];
          _fn1(name);
        }
        return awayScore;
      }
    };

    LeagueMatch.prototype.isHomeTeamWinning = function() {
      if (this.getMatchPointsByTeam('home') > this.getMatchPointsByTeam('away')) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.isAwayTeamWinning = function() {
      if (this.getMatchPointsByTeam('home') < this.getMatchPointsByTeam('away')) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.getWinningTeamNumber = function() {
      if (this.getMatchPointsByTeam('home') < this.getMatchPointsByTeam('away')) {
        return this.away_team.number;
      }
      return this.home_team.number;
    };

    LeagueMatch.prototype.toJSON = function() {
      if (this.small_json === true) {
        return this.toSmallJSON();
      }
      return {
        match_one: this.match['one'].toJSON(),
        match_two: this.match['two'].toJSON(),
        match_three: this.match['three'].toJSON(),
        match_four: this.match['four'].toJSON(),
        match_five: this.match['five'].toJSON(),
        team_number: this.team_number,
        home_team_number: this.home_team.number,
        away_team_number: this.away_team.number,
        start_time: this.start_time,
        end_time: this.end_time,
        table_type: this.table_type,
        league_match_id: this.league_match_id
      };
    };

    LeagueMatch.prototype.fromJSON = function(jsonLeagueMatch) {
      var matchFive, matchFour, matchOne, matchThree, matchTwo;
      matchOne = new $CS.Models.Match.Type.LeagueMatch('EightBall');
      matchTwo = new $CS.Models.Match.Type.LeagueMatch('EightBall');
      matchThree = new $CS.Models.Match.Type.LeagueMatch('EightBall');
      matchFour = new $CS.Models.Match.Type.LeagueMatch('EightBall');
      matchFive = new $CS.Models.Match.Type.LeagueMatch('EightBall');
      matchOne.fromJSON(jsonLeagueMatch.match_one);
      matchTwo.fromJSON(jsonLeagueMatch.match_two);
      matchThree.fromJSON(jsonLeagueMatch.match_three);
      matchFour.fromJSON(jsonLeagueMatch.match_four);
      matchFive.fromJSON(jsonLeagueMatch.match_five);
      this.match['one'] = matchOne;
      this.match['two'] = matchTwo;
      this.match['three'] = matchThree;
      this.match['four'] = matchFour;
      this.match['five'] = matchFive;
      this.team_number = jsonLeagueMatch.TeamNumber;
      this.home_team.number = jsonLeagueMatch.HomeTeamNumber;
      this.away_team.number = jsonLeagueMatch.AwayTeamNumber;
      this.start_time = jsonLeagueMatch.StartTime;
      this.end_time = jsonLeagueMatch.EndTime;
      this.table_type = jsonLeagueMatch.TableType;
      return this.league_match_id = jsonLeagueMatch.LeagueMatchId;
    };

    LeagueMatch.prototype.toSmallJSON = function() {
      return {
        team_number: this.team_number,
        home_team_number: this.home_team.number,
        away_team_number: this.away_team.number,
        start_time: this.start_time,
        end_time: this.end_time,
        table_type: this.table_type,
        league_match_id: this.league_match_id
      };
    };

    LeagueMatch.prototype.fromSmallJSON = function(jsonLeagueMatch) {
      this.team_number = jsonLeagueMatch.team_number;
      this.home_team.number = jsonLeagueMatch.home_team_number;
      this.away_team.number = jsonLeagueMatch.away_team_number;
      this.start_time = jsonLeagueMatch.start_time;
      this.end_time = jsonLeagueMatch.end_time;
      this.table_type = jsonLeagueMatch.table_type;
      return this.league_match_id = jsonLeagueMatch.league_match_id;
    };

    LeagueMatch.prototype.ended = function() {
      return this.match['one'].ended && this.match['two'].ended && this.match['three'].ended && this.match['four'].ended && this.match['five'].ended;
    };

    return LeagueMatch;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.LeagueMatch = LeagueMatch;

  Match = (function(_super) {

    __extends(Match, _super);

    Match.name = 'Match';

    Match.prototype.defaults = {
      player: {
        one: {},
        two: {}
      },
      completed_games: [],
      ended: false,
      original_id: 0,
      league_match_id: 0,
      player_number_winning: 0,
      player_one_won: false,
      player_two_won: false,
      are_players_switching: false,
      sudden_death: false,
      forfeit: false,
      current_game: null
    };

    function Match(options) {
      var player_one_name, player_one_number, player_one_rank, player_one_team_number, player_two_name, player_two_number, player_two_rank, player_two_team_number;
      _.extend(this, this.defaults);
      player_one_name = options.playerOneName;
      player_two_name = options.playerTwoName;
      player_one_rank = options.playerOneRank;
      player_two_rank = options.playerTwoRank;
      player_one_number = options.playerOneNumber;
      player_two_number = options.playerTwoNumber;
      player_one_team_number = options.playerOneTeamNumber;
      player_two_team_number = options.playerTwoTeamNumber;
      this.player.one = new $CS.Models.EightBall.Player(options = {
        name: player_one_name,
        rank: player_one_rank,
        playerNumber: player_one_number,
        teamNumber: player_one_team_number
      });
      this.player.two = new $CS.Models.EightBall.Player(options = {
        name: player_two_name,
        rank: player_two_rank,
        playerNumber: player_two_number,
        teamNumber: player_two_team_number
      });
      if ((this.player.one.rank != null) && (this.player.two.rank != null)) {
        this.player.one.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(player_one_rank, player_two_rank);
        this.player.two.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(player_two_rank, player_one_rank);
      }
      this.current_game = this.getNewGame();
    }

    Match.prototype.getNewGame = function() {
      var options,
        _this = this;
      return new $CS.Models.EightBall.Game(options = {
        addToPlayerOne: function() {
          return _this.player.one;
        },
        addToPlayerTwo: function() {
          return _this.player.two;
        },
        callback: function() {
          if (_this.getRemainingGamesNeededToWinByPlayer(1) === 0) {
            _this.player_one_won = true;
            return _this.ended = true;
          } else if (_this.getRemainingGamesNeededToWinByPlayer(2) === 0) {
            _this.player_two_won = true;
            return _this.ended = true;
          }
        }
      });
    };

    Match.prototype.getTotalInnings = function() {
      var i, totalInnings;
      totalInnings = this.current_game.number_of_innings;
      if (this.completed_games.length > 0) {
        i = 0;
        while (i <= (this.completed_games.length - 1)) {
          totalInnings += this.completed_games[i].number_of_innings;
          i++;
        }
      }
      return totalInnings.toString();
    };

    Match.prototype.getTotalSafeties = function() {
      return this.player.one.getSafeties() + "to" + this.player.two.getSafeties();
    };

    Match.prototype.getCurrentGameNumber = function() {
      return this.completed_games.length + 1;
    };

    Match.prototype.getMatchPointsByTeamNumber = function(teamNumber) {
      if (this.player.one.team_number === teamNumber) {
        return this.getMatchPointsByPlayer(1);
      } else {
        if (this.player.two.team_number === teamNumber) {
          return this.getMatchPointsByPlayer(2);
        }
      }
      return 0;
    };

    Match.prototype.getWinningPlayer = function() {
      if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
        return this.player.one;
      }
      return this.player.two;
    };

    Match.prototype.getRemainingGamesNeededToWinByPlayer = function(playerNum) {
      if (playerNum === 1) {
        return this.player.one.games_needed_to_win - this.getGamesWonByPlayer(1);
      } else if (playerNum === 2) {
        return this.player.two.games_needed_to_win - this.getGamesWonByPlayer(2);
      }
    };

    Match.prototype.getGamesWonByPlayer = function(playerNum) {
      var gamesWon, i;
      i = 0;
      if (playerNum === 1) {
        gamesWon = (this.current_game.player['one'].has_won === true ? 1 : 0);
        while (i <= (this.completed_games.length - 1)) {
          if (this.completed_games[i].player['one'].has_won === true) {
            gamesWon = gamesWon + 1;
          }
          i++;
        }
      } else if (playerNum === 2) {
        gamesWon = (this.current_game.player['two'].has_won === true ? 1 : 0);
        while (i <= (this.completed_games.length - 1)) {
          if (this.completed_games[i].player['two'].has_won === true) {
            gamesWon = gamesWon + 1;
          }
          i++;
        }
      }
      return gamesWon;
    };

    Match.prototype.getMatchPointsByPlayer = function(playerNum) {
      if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
        return 1;
      }
      return 0;
    };

    Match.prototype.getMatchPoints = function() {
      if (this.getMatchPointsByPlayer(1) === this.getMatchPointsByPlayer(2)) {
        return "TIE";
      } else {
        return this.getMatchPointsByPlayer(1) + "-" + this.getMatchPointsByPlayer(2);
      }
    };

    Match.prototype.setSuddenDeathMode = function() {
      this.sudden_death = true;
      this.player.one.games_needed_to_win = 1;
      return this.player.two.games_needed_to_win = 1;
    };

    Match.prototype.scoreNumberedBall = function(ballNumber) {
      this.are_players_switching = false;
      this.current_game.scoreBall(ballNumber);
      if (this.isPlayerWinning(1) === true) {
        this.player_number_winning = 1;
      } else {
        this.player_number_winning = 2;
      }
      return this.checkForWin();
    };

    Match.prototype.shotMissed = function() {
      this.current_game.nextPlayerIsUp();
      if (this.current_game.breaking_player_still_shooting === false) {
        return this.are_players_switching = true;
      }
    };

    Match.prototype.hitSafety = function() {
      return this.current_game.hitSafety();
    };

    Match.prototype.checkForWin = function() {};

    Match.prototype.startNewGame = function() {
      if (this.current_game.ended === true) {
        this.completed_games.push(this.current_game);
        return this.current_game = this.getNewGame();
      }
    };

    Match.prototype.resetPlayerRankStats = function() {
      this.player.one.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(this.player.one.rank, this.player.two.rank);
      this.player.two.games_needed_to_win = new $CS.Models.EightBall.Ranks().getGamesNeedToWin(this.player.two.rank, this.player.one.rank);
      this.player.one.resetPlayerRankStats();
      return this.player.two.resetPlayerRankStats();
    };

    Match.prototype.isPlayerWinning = function(playerNum) {
      if (playerNum === 1) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
          return true;
        }
        return false;
      } else if (playerNum === 2) {
        if ((this.getGamesWonByPlayer(1) / this.player.one.games_needed_to_win) < (this.getGamesWonByPlayer(2) / this.player.two.games_needed_to_win)) {
          return true;
        }
        return false;
      }
    };

    Match.prototype.toJSON = function() {
      return {
        player: {
          one: this.player.one.toJSON(),
          two: this.player.two.toJSON()
        },
        player_one_won: this.getGamesWonByPlayer(1),
        player_two_won: this.getGamesWonByPlayer(2),
        current_game: this.current_game.toJSON(),
        completed_games: this.completedGamesToJSON(),
        sudden_death: this.sudden_death,
        forfeit: this.forfeit,
        ended: this.ended,
        original_id: this.original_id,
        league_match_id: this.league_match_id
      };
    };

    Match.prototype.completedGamesToJSON = function() {
      var arrayToReturn, i;
      arrayToReturn = [];
      i = 0;
      while (i <= this.completed_games.length - 1) {
        arrayToReturn[i] = this.completed_games[i].toJSON();
        i++;
      }
      return arrayToReturn;
    };

    Match.prototype.fromJSON = function(json) {
      var currentGame;
      this.player.one = this.playerFromJSON(json.player.one);
      this.player.two = this.playerFromJSON(json.player.two);
      this.resetPlayerRankStats();
      this.completed_games = this.completedGamesFromJSON(json.completed_games);
      this.sudden_death = json.sudden_death;
      this.forfeit = json.forfeit;
      this.ended = json.ended;
      this.original_id = json.original_id;
      this.league_match_id = json.league_match_id;
      currentGame = this.getNewGame();
      currentGame.fromJSON(new function() {
        return json.current_game;
      });
      return this.current_game = currentGame;
    };

    Match.prototype.playerFromJSON = function(json) {
      var player;
      player = new $CS.Models.EightBall.Player();
      player.fromJSON(new function() {
        return json;
      });
      return player;
    };

    Match.prototype.completedGamesFromJSON = function(json) {
      var arrayToReturn, completedGame, i;
      arrayToReturn = [];
      i = 0;
      while (i <= json.length - 1) {
        completedGame = this.getNewGame();
        completedGame.fromJSON(new function() {
          return json[i];
        });
        arrayToReturn.push(completedGame);
        i++;
      }
      return arrayToReturn;
    };

    return Match;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.Match = Match;

  Player = (function(_super) {

    __extends(Player, _super);

    Player.name = 'Player';

    Player.prototype.defaults = {
      name: null,
      rank: null,
      number: null,
      team_number: null,
      games_won: 0,
      safeties: 0,
      currently_up: false,
      eight_on_snaps: 0,
      break_and_runs: 0,
      timeouts_allowed: null,
      games_needed_to_win: 0,
      is_captain: false
    };

    function Player(options) {
      var _ref, _ref1, _ref2, _ref3;
      _.extend(this, this.defaults);
      this.name = (_ref = options.name) != null ? _ref : options.name = null;
      this.rank = (_ref1 = options.rank) != null ? _ref1 : options.rank = null;
      this.number = (_ref2 = options.playerNumber) != null ? _ref2 : options.playerNumber = null;
      this.team_number = (_ref3 = options.teamNumber) != null ? _ref3 : options.teamNumber = null;
      this.timeouts_allowed = new $CS.Models.EightBall.Ranks().getTimeouts(this.rank);
    }

    Player.prototype.getGamesNeededToWin = function() {
      return this.games_needed_to_win.toString();
    };

    Player.prototype.getFirstNameWithInitials = function() {
      var nameToReturn, spaceIndex;
      spaceIndex = this.name.indexOf(" ");
      if (spaceIndex === -1) {
        return this.name;
      }
      nameToReturn = this.name.substr(0, spaceIndex);
      return nameToReturn + " " + this.name[spaceIndex + 1] + ".";
    };

    Player.prototype.getSafeties = function() {
      return this.safeties;
    };

    Player.prototype.getGamesWon = function() {
      return this.games_won.toString();
    };

    Player.prototype.getEightOnSnaps = function() {
      return this.eight_on_snaps.toString();
    };

    Player.prototype.getBreakAndRuns = function() {
      return this.break_and_runs.toString();
    };

    Player.prototype.resetPlayerRankStats = function() {
      return this.timeouts_allowed = new $CS.Models.EightBall.Ranks().getTimeouts(this.rank);
    };

    Player.prototype.addToGamesWon = function(num) {
      return this.games_won += num;
    };

    Player.prototype.addToSafeties = function(num) {
      return this.safeties += num;
    };

    Player.prototype.addToEightOnSnaps = function(num) {
      return this.eight_on_snaps += num;
    };

    Player.prototype.addToBreakAndRuns = function(num) {
      return this.break_and_runs += num;
    };

    Player.prototype.toJSON = function() {
      return {
        name: this.name,
        rank: this.rank,
        games_needed_to_win: this.games_needed_to_win,
        number: this.number,
        team_number: this.team_number,
        games_won: this.games_won,
        safeties: this.safeties,
        eight_on_snaps: this.eight_on_snaps,
        break_and_runs: this.break_and_runs,
        currently_up: this.currently_up
      };
    };

    Player.prototype.fromJSON = function(playerJSON) {
      this.name = playerJSON.name;
      this.rank = playerJSON.rank;
      this.number = playerJSON.number;
      this.team_number = playerJSON.team_number;
      this.games_won = playerJSON.games_won;
      this.safeties = playerJSON.safeties;
      this.eight_on_snaps = playerJSON.eight_on_snaps;
      this.break_and_runs = playerJSON.break_and_runs;
      this.currently_up = playerJSON.currently_up;
      return this.resetPlayerRankStats();
    };

    return Player;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.Player = Player;

  PracticeMatch = (function(_super) {

    __extends(PracticeMatch, _super);

    PracticeMatch.name = 'PracticeMatch';

    PracticeMatch.prototype.defaults = {};

    function PracticeMatch() {
      _.extend(this, this.defaults);
      console.log(this);
    }

    return PracticeMatch;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.PracticeMatch = PracticeMatch;

  Ranks = (function(_super) {

    __extends(Ranks, _super);

    Ranks.name = 'Ranks';

    Ranks.prototype.defaults = {
      games_to_win: []
    };

    function Ranks() {
      _.extend(this, this.defaults);
      this.setRanks();
    }

    Ranks.prototype.getGamesNeedToWin = function(myRank, opponentRank) {
      var gamesNeeded;
      if (myRank > 1 && myRank < 8 && opponentRank > 1 && opponentRank < 8) {
        gamesNeeded = this.games_to_win[myRank][opponentRank];
        return gamesNeeded;
      } else {
        return 0;
      }
    };

    Ranks.prototype.getTimeouts = function(rank) {
      if (rank < 4) {
        return 2;
      } else if (rank >= 4 && rank <= 9) {
        return 1;
      } else {
        return 0;
      }
    };

    Ranks.prototype.setRanks = function() {
      this.games_to_win[2] = [];
      this.games_to_win[2][2] = 2;
      this.games_to_win[2][3] = 2;
      this.games_to_win[2][4] = 2;
      this.games_to_win[2][5] = 2;
      this.games_to_win[2][6] = 2;
      this.games_to_win[2][7] = 2;
      this.games_to_win[3] = [];
      this.games_to_win[3][2] = 3;
      this.games_to_win[3][3] = 2;
      this.games_to_win[3][4] = 2;
      this.games_to_win[3][5] = 2;
      this.games_to_win[3][6] = 2;
      this.games_to_win[3][7] = 2;
      this.games_to_win[4] = [];
      this.games_to_win[4][2] = 4;
      this.games_to_win[4][3] = 3;
      this.games_to_win[4][4] = 3;
      this.games_to_win[4][5] = 3;
      this.games_to_win[4][6] = 3;
      this.games_to_win[4][7] = 2;
      this.games_to_win[5] = [];
      this.games_to_win[5][2] = 5;
      this.games_to_win[5][3] = 4;
      this.games_to_win[5][4] = 4;
      this.games_to_win[5][5] = 4;
      this.games_to_win[5][6] = 4;
      this.games_to_win[5][7] = 3;
      this.games_to_win[6] = [];
      this.games_to_win[6][2] = 6;
      this.games_to_win[6][3] = 5;
      this.games_to_win[6][4] = 5;
      this.games_to_win[6][5] = 5;
      this.games_to_win[6][6] = 5;
      this.games_to_win[6][7] = 4;
      this.games_to_win[7] = [];
      this.games_to_win[7][2] = 7;
      this.games_to_win[7][3] = 6;
      this.games_to_win[7][4] = 5;
      this.games_to_win[7][5] = 5;
      this.games_to_win[7][6] = 5;
      return this.games_to_win[7][7] = 5;
    };

    return Ranks;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.Ranks = Ranks;

  TournamentMatch = (function(_super) {

    __extends(TournamentMatch, _super);

    TournamentMatch.name = 'TournamentMatch';

    TournamentMatch.prototype.defaults = {};

    function TournamentMatch() {
      _.extend(this, this.defaults);
      console.log(this);
    }

    return TournamentMatch;

  })($CS.Models.EightBall);

  $CS.Models.EightBall.TournamentMatch = TournamentMatch;

  Game = (function(_super) {

    __extends(Game, _super);

    Game.name = 'Game';

    Game.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    function Game(options) {
      if (options == null) {
        options = {};
      }
      _.extend(this, this.defaults);
      this.name = options.name;
      this.age = options.age;
      this.children = options.children;
      this.bind("change:name", function() {
        var name;
        return name = this.get("name");
      });
    }

    Game.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Game;

  })(Backbone.Model);

  $CS.Models.Game = Game;

  League = (function(_super) {

    __extends(League, _super);

    League.name = 'League';

    League.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    function League(options) {
      if (options == null) {
        options = {};
      }
      _.extend(this, this.defaults);
      this.name = options.name;
      this.age = options.age;
      this.children = options.children;
      this.bind("change:name", function() {
        var name;
        return name = this.get("name");
      });
    }

    League.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return League;

  })(Backbone.Model);

  $CS.Models.League = League;

  DoubleJeopardy = (function(_super) {

    __extends(DoubleJeopardy, _super);

    DoubleJeopardy.name = 'DoubleJeopardy';

    function DoubleJeopardy() {
      return DoubleJeopardy.__super__.constructor.apply(this, arguments);
    }

    DoubleJeopardy.prototype.defaults = {};

    DoubleJeopardy.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      return _.extend(this, this.defaults);
    };

    return DoubleJeopardy;

  })($CS.Models.League);

  $CS.Models.League.DoubleJeopardy = DoubleJeopardy;

  Doubles = (function(_super) {

    __extends(Doubles, _super);

    Doubles.name = 'Doubles';

    function Doubles() {
      return Doubles.__super__.constructor.apply(this, arguments);
    }

    Doubles.prototype.defaults = {};

    Doubles.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      return _.extend(this, this.defaults);
    };

    return Doubles;

  })($CS.Models.League);

  $CS.Models.League.Doubles = Doubles;

  Masters = (function(_super) {

    __extends(Masters, _super);

    Masters.name = 'Masters';

    function Masters() {
      return Masters.__super__.constructor.apply(this, arguments);
    }

    Masters.prototype.defaults = {};

    Masters.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      return _.extend(this, this.defaults);
    };

    return Masters;

  })($CS.Models.League);

  $CS.Models.League.Masters = Masters;

  MixedDoubles = (function(_super) {

    __extends(MixedDoubles, _super);

    MixedDoubles.name = 'MixedDoubles';

    function MixedDoubles() {
      return MixedDoubles.__super__.constructor.apply(this, arguments);
    }

    MixedDoubles.prototype.defaults = {};

    MixedDoubles.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      return _.extend(this, this.defaults);
    };

    return MixedDoubles;

  })($CS.Models.League);

  $CS.Models.League.MixedDoubles = MixedDoubles;

  Womens = (function(_super) {

    __extends(Womens, _super);

    Womens.name = 'Womens';

    function Womens() {
      return Womens.__super__.constructor.apply(this, arguments);
    }

    Womens.prototype.defaults = {};

    Womens.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      return _.extend(this, this.defaults);
    };

    return Womens;

  })($CS.Models.League);

  $CS.Models.League.Womens = Womens;

  Match = (function(_super) {

    __extends(Match, _super);

    Match.name = 'Match';

    Match.prototype.defaults = {};

    function Match() {
      _.extend(this, this.defaults);
    }

    return Match;

  })(Backbone.Model);

  $CS.Models.Match = Match;

  Game = (function(_super) {

    __extends(Game, _super);

    Game.name = 'Game';

    Game.prototype.defaults = {};

    function Game(addToPlayerOne, addToPlayerTwo, callback) {
      _.extend(this, this.defaults);
      this.PlayerOneCallback = addToPlayerOne;
      this.PlayerTwoCallback = addToPlayerTwo;
      this.PlayerOneCallback().TimeoutsTaken = 0;
      this.PlayerTwoCallback().TimeoutsTaken = 0;
      this.MatchEndedCallback = callback;
      this.PlayerOneScore = 0;
      this.PlayerTwoScore = 0;
      this.NumberOfInnings = 0;
      this.PlayerOneNineOnSnap = false;
      this.PlayerOneBreakAndRun = false;
      this.PlayerTwoNineOnSnap = false;
      this.PlayerTwoBreakAndRun = false;
      this.Ended = false;
      this.PlayerOneBallsHitIn = [];
      this.PlayerTwoBallsHitIn = [];
      this.PlayerOneDeadBalls = [];
      this.PlayerTwoDeadBalls = [];
      this.PlayerOneLastBall = null;
      this.PlayerTwoLastBall = null;
      this.OnBreak = true;
      this.BreakingPlayerStillHitting = true;
      this.PlayerOneTimeoutsTaken = 0;
      this.PlayerTwoTimeoutsTaken = 0;
      this.getCurrentlyUpPlayer = function() {
        if (this.PlayerOneCallback().CurrentlyUp === true) {
          return this.PlayerOneCallback();
        }
        return this.PlayerTwoCallback();
      };
    }

    Game.prototype.hitSafety = function() {
      this.getCurrentlyUpPlayer().addOneToSafeties();
      return this.nextPlayerIsUp();
    };

    Game.prototype.getDeadBalls = function() {
      return this.PlayerOneDeadBalls.length + this.PlayerTwoDeadBalls.length;
    };

    Game.prototype.hitDeadBall = function(ballNumber) {
      if (ballNumber !== 9 && !this.getBallsHitIn().exists(ballNumber)) {
        this.DeadBalls += 1;
        if (this.PlayerOneCallback().CurrentlyUp === true) {
          this.PlayerOneDeadBalls.push(ballNumber);
        } else {
          this.PlayerTwoDeadBalls.push(ballNumber);
        }
        return this.checkIfAllBallsAreHitIn();
      }
    };

    Game.prototype.checkIfAllBallsAreHitIn = function() {
      var allBallsHitIn, i;
      allBallsHitIn = this.getBallsHitIn();
      this.Ended = allBallsHitIn.length === 9;
      if (this.Ended === false) {
        if (allBallsHitIn.exists(9)) {
          i = 1;
          while (i < 9) {
            if (allBallsHitIn.exists(i) !== true) {
              if (this.PlayerOneCallback().CurrentlyUp === true) {
                this.PlayerOneDeadBalls.push(i);
              } else {
                this.PlayerTwoDeadBalls.push(i);
              }
            }
            i++;
          }
          this.Ended = true;
        }
      }
      if (this.Ended === true && this.getBallsScored().length === 9) {
        if (this.PlayerOneCallback().CurrentlyUp === true && this.BreakingPlayerStillHitting === true) {
          return this.setPlayerOneBreakAndRun();
        } else {
          if (this.PlayerTwoCallback().CurrentlyUp === true && this.BreakingPlayerStillHitting === true) {
            return this.setPlayerTwoBreakAndRun();
          }
        }
      }
    };

    Game.prototype.scoreBall = function(ballNumber) {
      if (!this.getBallsHitIn().exists(ballNumber)) {
        if (this.PlayerOneCallback().CurrentlyUp === true) {
          if (ballNumber > 0 && ballNumber < 9) {
            this.PlayerOneScore += 1;
            this.PlayerOneCallback().addToScore(1);
          } else {
            this.PlayerOneScore += 2;
            this.PlayerOneCallback().addToScore(2);
            if (this.OnBreak === true && this.getBallsScored().length !== 8) {
              this.setPlayerOneNineOnSnap();
            }
          }
          this.PlayerOneLastBall = ballNumber;
          this.PlayerTwoLastBall = null;
          this.PlayerOneBallsHitIn.push(ballNumber);
        } else {
          if (ballNumber > 0 && ballNumber < 9) {
            this.PlayerTwoScore += 1;
            this.PlayerTwoCallback().addToScore(1);
          } else {
            this.PlayerTwoScore += 2;
            this.PlayerTwoCallback().addToScore(2);
            if (this.OnBreak === true && this.getBallsScored().length !== 8) {
              this.setPlayerTwoNineOnSnap();
            }
          }
          this.PlayerTwoLastBall = ballNumber;
          this.PlayerOneLastBall = null;
          this.PlayerTwoBallsHitIn.push(ballNumber);
        }
        this.checkIfAllBallsAreHitIn();
        return this.checkForWinner();
      }
    };

    Game.prototype.checkForWinner = function() {
      if (this.PlayerOneCallback().hasWon() === true || this.PlayerTwoCallback().hasWon() === true) {
        this.End();
        return this.MatchEndedCallback();
      }
    };

    Game.prototype.addOneToNumberOfInnings = function() {
      return this.NumberOfInnings += 1;
    };

    Game.prototype.nextPlayerIsUp = function() {
      if (this.OnBreak !== true || ((this.PlayerTwoCallback().CurrentlyUp === true && this.PlayerTwoBallsHitIn.length === 0) || (this.PlayerOneCallback().CurrentlyUp === true && this.PlayerOneBallsHitIn.length === 0))) {
        if (this.PlayerOneCallback().CurrentlyUp === true) {
          this.PlayerTwoCallback().CurrentlyUp = true;
          this.PlayerOneCallback().CurrentlyUp = false;
        } else if (this.PlayerTwoCallback().CurrentlyUp === true) {
          this.PlayerTwoCallback().CurrentlyUp = false;
          this.PlayerOneCallback().CurrentlyUp = true;
          this.addOneToNumberOfInnings();
        } else {
          this.PlayerOneCallback().CurrentlyUp = true;
        }
        this.BreakingPlayerStillHitting = false;
      }
      return this.OnBreak = false;
    };

    Game.prototype.setPlayerOneNineOnSnap = function() {
      if (this.PlayerOneNineOnSnap !== true) {
        this.PlayerOneCallback().addOneToNineOnSnaps();
      }
      return this.PlayerOneNineOnSnap = true;
    };

    Game.prototype.setPlayerTwoNineOnSnap = function() {
      if (this.PlayerTwoNineOnSnap !== true) {
        this.PlayerTwoCallback().addOneToNineOnSnaps();
      }
      return this.PlayerTwoNineOnSnap = true;
    };

    Game.prototype.setPlayerOneBreakAndRun = function() {
      if (this.PlayerOneBreakAndRun !== true) {
        this.PlayerOneCallback().addOneToBreakAndRuns();
      }
      return this.PlayerOneBreakAndRun = true;
    };

    Game.prototype.setPlayerTwoBreakAndRun = function() {
      if (this.PlayerTwoBreakAndRun !== true) {
        this.PlayerTwoCallback().addOneToBreakAndRuns();
      }
      return this.PlayerTwoBreakAndRun = true;
    };

    Game.prototype.getWinningPlayerName = function() {
      if (getScoreRatio(this.PlayerOneScore, this.PlayerOneCallback().BallCount) > getScoreRatio(this.PlayerTwoScore, this.PlayerTwoCallback().BallCount)) {
        return this.PlayerOneCallback().getFirstNameWithInitials();
      } else {
        if (getScoreRatio(this.PlayerOneScore, this.PlayerOneCallback().BallCount) < getScoreRatio(this.PlayerTwoScore, this.PlayerTwoCallback().BallCount)) {
          return this.PlayerTwoCallback().getFirstNameWithInitials();
        }
      }
      return "Tie";
    };

    Game.prototype.getGameScore = function() {
      return this.PlayerOneScore + "-" + this.PlayerTwoScore;
    };

    Game.prototype.getPlayerOneBallsHitIn = function() {
      return this.PlayerOneBallsHitIn.concat(this.PlayerOneDeadBalls);
    };

    Game.prototype.getPlayerTwoBallsHitIn = function() {
      return this.PlayerTwoBallsHitIn.concat(this.PlayerTwoDeadBalls);
    };

    Game.prototype.getBallsHitIn = function() {
      return this.PlayerOneBallsHitIn.concat(this.PlayerTwoBallsHitIn).concat(this.PlayerOneDeadBalls).concat(this.PlayerTwoDeadBalls);
    };

    Game.prototype.getBallsScored = function() {
      return this.PlayerOneBallsHitIn.concat(this.PlayerTwoBallsHitIn);
    };

    Game.prototype.getCurrentPlayerRemainingTimeouts = function() {
      if (this.PlayerOneCallback().CurrentlyUp === true) {
        return (this.PlayerOneCallback().TimeoutsAllowed - this.PlayerOneTimeoutsTaken).toString();
      }
      return (this.PlayerTwoCallback().TimeoutsAllowed - this.PlayerTwoTimeoutsTaken).toString();
    };

    Game.prototype.takeTimeout = function() {
      if (this.getCurrentPlayerRemainingTimeouts() > 0) {
        if (this.PlayerOneCallback().CurrentlyUp === true) {
          return this.PlayerOneTimeoutsTaken += 1;
        } else {
          return this.PlayerTwoTimeoutsTaken += 1;
        }
      }
    };

    Game.prototype.breakIsOver = function() {
      return this.OnBreak = false;
    };

    Game.prototype.End = function() {
      return this.Ended = true;
    };

    Game.prototype.toJSON = function() {
      return {
        PlayerOneScore: this.PlayerOneScore,
        PlayerTwoScore: this.PlayerTwoScore,
        PlayerOneTimeoutsTaken: this.PlayerOneTimeoutsTaken,
        PlayerTwoTimeoutsTaken: this.PlayerTwoTimeoutsTaken,
        NumberOfInnings: this.NumberOfInnings,
        PlayerOneNineOnSnap: this.PlayerOneNineOnSnap,
        PlayerOneBreakAndRun: this.PlayerOneBreakAndRun,
        PlayerTwoNineOnSnap: this.PlayerTwoNineOnSnap,
        PlayerTwoBreakAndRun: this.PlayerTwoBreakAndRun,
        Ended: this.Ended,
        PlayerOneBallsHitIn: this.PlayerOneBallsHitIn,
        PlayerTwoBallsHitIn: this.PlayerTwoBallsHitIn,
        PlayerOneDeadBalls: this.PlayerOneDeadBalls,
        PlayerTwoDeadBalls: this.PlayerTwoDeadBalls,
        PlayerOneLastBall: this.PlayerOneLastBall,
        PlayerTwoLastBall: this.PlayerTwoLastBall,
        OnBreak: this.OnBreak,
        BreakingPlayerStillHitting: this.BreakingPlayerStillHitting
      };
    };

    Game.prototype.fromJSON = function(gameJSON) {
      this.PlayerOneScore = gameJSON.PlayerOneScore;
      this.PlayerTwoScore = gameJSON.PlayerTwoScore;
      this.NumberOfInnings = gameJSON.NumberOfInnings;
      this.PlayerOneTimeoutsTaken = gameJSON.PlayerOneTimeoutsTaken;
      this.PlayerTwoTimeoutsTaken = gameJSON.PlayerTwoTimeoutsTaken;
      this.PlayerOneNineOnSnap = gameJSON.PlayerOneNineOnSnap;
      this.PlayerOneBreakAndRun = gameJSON.PlayerOneBreakAndRun;
      this.PlayerTwoNineOnSnap = gameJSON.PlayerTwoNineOnSnap;
      this.PlayerTwoBreakAndRun = gameJSON.PlayerTwoBreakAndRun;
      this.Ended = gameJSON.Ended;
      this.PlayerOneBallsHitIn = gameJSON.PlayerOneBallsHitIn;
      this.PlayerTwoBallsHitIn = gameJSON.PlayerTwoBallsHitIn;
      this.PlayerOneDeadBalls = gameJSON.PlayerOneDeadBalls;
      this.PlayerTwoDeadBalls = gameJSON.PlayerTwoDeadBalls;
      this.PlayerOneLastBall = gameJSON.PlayerOneLastBall;
      this.PlayerTwoLastBall = gameJSON.PlayerTwoLastBall;
      this.OnBreak = gameJSON.OnBreak;
      return this.BreakingPlayerStillHitting = gameJSON.BreakingPlayerStillHitting;
    };

    return Game;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.Game = Game;

  League = (function(_super) {

    __extends(League, _super);

    League.name = 'League';

    League.prototype.defaults = {};

    function League(options) {
      if (options == null) {
        options = {};
      }
      _.extend(this, this.defaults);
    }

    return League;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.League = League;

  LeagueMatch = (function(_super) {

    __extends(LeagueMatch, _super);

    LeagueMatch.name = 'LeagueMatch';

    LeagueMatch.prototype.defaults = {};

    function LeagueMatch(HomeTeamNumber, AwayTeamNumber, HomeTeamName, AwayTeamName, StartTime, TableType) {
      var me;
      _.extend(this, this.defaults);
      this.GameType = "NineBall";
      this.MatchOne = null;
      this.MatchTwo = null;
      this.MatchThree = null;
      this.MatchFour = null;
      this.MatchFive = null;
      this.TeamNumber = "";
      this.HomeTeamNumber = HomeTeamNumber;
      this.AwayTeamNumber = AwayTeamNumber;
      this.HomeTeamName = HomeTeamName;
      this.AwayTeamName = AwayTeamName;
      this.HomeTeamSigned = false;
      this.AwayTeamSigned = false;
      this.StartTime = StartTime;
      this.EndTime = "";
      this.TableType = TableType;
      this.SmallJSON = false;
      this.LeagueMatchId = 0;
      me = this;
      DataService.saveLeagueMatch(this, function(id) {
        return me.LeagueMatchId = id;
      });
    }

    LeagueMatch.prototype.getHomeTeamMatchPoints = function() {
      var totalScore;
      totalScore = 0;
      totalScore = this.MatchOne.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchTwo.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchThree.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchFour.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      totalScore += this.MatchFive.getMatchPointsByTeamNumber(this.HomeTeamNumber);
      return totalScore;
    };

    LeagueMatch.prototype.getAwayTeamMatchPoints = function() {
      var totalScore;
      totalScore = this.MatchOne.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchTwo.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchThree.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchFour.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      totalScore += this.MatchFive.getMatchPointsByTeamNumber(this.AwayTeamNumber);
      return totalScore;
    };

    LeagueMatch.prototype.isHomeTeamWinning = function() {
      if (this.getHomeTeamMatchPoints() > this.getAwayTeamMatchPoints()) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.isAwayTeamWinning = function() {
      if (this.getHomeTeamMatchPoints() < this.getAwayTeamMatchPoints()) {
        return true;
      }
      return false;
    };

    LeagueMatch.prototype.getWinningTeamNumber = function() {
      if (this.getHomeTeamMatchPoints() < this.getAwayTeamMatchPoints()) {
        return this.AwayTeamNumber;
      }
      return this.HomeTeamNumber;
    };

    LeagueMatch.prototype.setMatchOne = function(match) {
      this.MatchOne = match;
      this.MatchOne.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchOne.OriginalId != null) || this.MatchOne.OriginalId === 0) {
        return DataService.saveMatch(this.MatchOne, function(id) {
          return me.MatchOne.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchTwo = function(match) {
      this.MatchTwo = match;
      this.MatchTwo.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchTwo.OriginalId != null) || this.MatchTwo.OriginalId === 0) {
        return DataService.saveMatch(this.MatchTwo, function(id) {
          return me.MatchTwo.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchThree = function(match) {
      this.MatchThree = match;
      this.MatchThree.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchThree.OriginalId != null) || this.MatchThree.OriginalId === 0) {
        return DataService.saveMatch(this.MatchThree, function(id) {
          return me.MatchThree.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchFour = function(match) {
      this.MatchFour = match;
      this.MatchFour.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchFour.OriginalId != null) || this.MatchFour.OriginalId === 0) {
        return DataService.saveMatch(this.MatchFour, function(id) {
          return me.MatchFour.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.setMatchFive = function(match) {
      this.MatchFive = match;
      this.MatchFive.LeagueMatchId = this.LeagueMatchId;
      if (!(this.MatchFive.OriginalId != null) || this.MatchFive.OriginalId === 0) {
        return DataService.saveMatch(this.MatchFive, function(id) {
          return me.MatchFive.OriginalId = id;
        });
      }
    };

    LeagueMatch.prototype.toJSON = function() {
      if (this.SmallJSON === true) {
        return this.toSmallJSON();
      }
      return {
        MatchOne: this.MatchOne.toJSON(),
        MatchTwo: this.MatchTwo.toJSON(),
        MatchThree: this.MatchThree.toJSON(),
        MatchFour: this.MatchFour.toJSON(),
        MatchFive: this.MatchFive.toJSON(),
        TeamNumber: this.TeamNumber,
        HomeTeamNumber: this.HomeTeamNumber,
        AwayTeamNumber: this.AwayTeamNumber,
        StartTime: this.StartTime,
        EndTime: this.EndTime,
        TableType: this.TableType,
        LeagueMatchId: this.LeagueMatchId
      };
    };

    LeagueMatch.prototype.toSmallJSON = function() {
      return {
        TeamNumber: this.TeamNumber,
        HomeTeamNumber: this.HomeTeamNumber,
        AwayTeamNumber: this.AwayTeamNumber,
        StartTime: this.StartTime,
        EndTime: this.EndTime,
        TableType: this.TableType,
        LeagueMatchId: this.LeagueMatchId
      };
    };

    LeagueMatch.prototype.fromJSON = function(jsonLeagueMatch) {
      var matchFive, matchFour, matchOne, matchThree, matchTwo;
      matchOne = new NineBallMatch();
      matchOne.fromJSON(jsonLeagueMatch.MatchOne);
      matchTwo = new NineBallMatch();
      matchTwo.fromJSON(jsonLeagueMatch.MatchTwo);
      matchThree = new NineBallMatch();
      matchThree.fromJSON(jsonLeagueMatch.MatchThree);
      matchFour = new NineBallMatch();
      matchFour.fromJSON(jsonLeagueMatch.MatchFour);
      matchFive = new NineBallMatch();
      matchFive.fromJSON(jsonLeagueMatch.MatchFive);
      this.MatchOne = matchOne;
      this.MatchTwo = matchTwo;
      this.MatchThree = matchThree;
      this.MatchFour = matchFour;
      this.MatchFive = matchFive;
      this.TeamNumber = jsonLeagueMatch.TeamNumber;
      this.HomeTeamNumber = jsonLeagueMatch.HomeTeamNumber;
      this.AwayTeamNumber = jsonLeagueMatch.AwayTeamNumber;
      this.StartTime = jsonLeagueMatch.StartTime;
      this.EndTime = jsonLeagueMatch.EndTime;
      this.TableType = jsonLeagueMatch.TableType;
      return this.LeagueMatchId = jsonLeagueMatch.LeagueMatchId;
    };

    LeagueMatch.prototype.fromSmallJSON = function(jsonLeagueMatch) {
      this.TeamNumber = jsonLeagueMatch.TeamNumber;
      this.HomeTeamNumber = jsonLeagueMatch.HomeTeamNumber;
      this.AwayTeamNumber = jsonLeagueMatch.AwayTeamNumber;
      this.StartTime = jsonLeagueMatch.StartTime;
      this.EndTime = jsonLeagueMatch.EndTime;
      this.TableType = jsonLeagueMatch.TableType;
      return this.LeagueMatchId = jsonLeagueMatch.LeagueMatchId;
    };

    LeagueMatch.prototype.Ended = function() {
      return this.MatchOne.Ended && this.MatchTwo.Ended && this.MatchThree.Ended && this.MatchFour.Ended && this.MatchFive.Ended;
    };

    return LeagueMatch;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.LeagueMatch = LeagueMatch;

  Match = (function(_super) {

    __extends(Match, _super);

    Match.name = 'Match';

    Match.prototype.defaults = {};

    function Match(player1, player2, player1Rank, player2Rank, player1Number, player2Number, player1TeamNumber, player2TeamNumber) {
      var getNewGame, me;
      _.extend(this, this.defaults);
      this.PlayerOne = new NineBallPlayer(player1, player1Rank, player1Number, player1TeamNumber);
      this.PlayerTwo = new NineBallPlayer(player2, player2Rank, player2Number, player2TeamNumber);
      this.CompletedGames = [];
      this.Ended = false;
      this.OriginalId = 0;
      this.LeagueMatchId = 0;
      this.PlayerNumberWinning = 0;
      this.SuddenDeath = false;
      this.Forfeit = false;
      me = this;
      getNewGame = function() {
        return new NineBallGame(function() {
          return me.PlayerOne;
        }, function() {
          return me.PlayerTwo;
        }, function() {
          return me.Ended = true;
        });
      };
      this.CurrentGame = this.getNewGame();
    }

    Match.prototype.scoreNumberedBall = function(ballNumber) {
      this.CurrentGame.scoreBall(ballNumber);
      if (this.isPlayerOneWinning() === true) {
        this.PlayerNumberWinning = 1;
      } else {
        this.PlayerNumberWinning = 2;
      }
      return this.checkForWin();
    };

    Match.prototype.shotMissed = function() {
      return this.CurrentGame.nextPlayerIsUp();
    };

    Match.prototype.hitDeadBall = function(ballNumber) {
      this.CurrentGame.hitDeadBall(ballNumber);
      return this.checkForWin();
    };

    Match.prototype.hitSafety = function() {
      return this.CurrentGame.hitSafety();
    };

    Match.prototype.checkForWin = function() {};

    Match.prototype.startNewGame = function() {
      if (this.CurrentGame.Ended === true) {
        this.CompletedGames.push(me.CurrentGame);
        return this.CurrentGame = me.getNewGame();
      }
    };

    Match.prototype.setSuddenDeathMode = function() {
      this.SuddenDeath = true;
      this.PlayerOne.GamesNeededToWin = 1;
      return this.PlayerTwo.GamesNeededToWin = 1;
    };

    Match.prototype.getPlayerOneScore = function() {
      return this.PlayerOne.Score;
    };

    Match.prototype.getLosingPlayer = function() {
      if (this.isPlayerOneWinning() === true) {
        return this.PlayerTwo;
      } else {
        return this.PlayerOne;
      }
    };

    Match.prototype.getWinningPlayer = function() {
      if (this.isPlayerOneWinning() === true) {
        return this.PlayerOne;
      } else {
        return this.PlayerTwo;
      }
    };

    Match.prototype.getLosingPlayersMatchPoints = function() {
      var losingScore;
      losingScore = new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      return losingScore;
    };

    Match.prototype.getWinningPlayersMatchPoints = function() {
      var winningScore;
      winningScore = new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      return winningScore;
    };

    Match.prototype.getPlayerOneMatchPoints = function() {
      if (this.isPlayerOneWinning() === true && this.isPlayerTwoWinning() === false) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      }
      return new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
    };

    Match.prototype.getPlayerTwoMatchPoints = function() {
      if (this.isPlayerOneWinning() === false && this.isPlayerTwoWinning() === true) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
      }
      return new NineBallRanks().getLosingPlayersMatchPoints(this.getLosingPlayer().Rank, this.getLosingPlayer().Score);
    };

    Match.prototype.getMatchPoints = function() {
      if (this.isPlayerOneWinning() === true) {
        return new NineBallRanks().getWinningPlayersMatchPoints(this.PlayerTwo.Rank, this.PlayerTwo.Score) + "-" + new NineBallRanks().getLosingPlayersMatchPoints(this.PlayerTwo.Rank, this.PlayerTwo.Score);
      } else {
        if (this.isPlayerTwoWinning() === true) {
          return new NineBallRanks().getLosingPlayersMatchPoints(this.PlayerOne.Rank, this.PlayerOne.Score) + "-" + new NineBallRanks().getWinningPlayersMatchPoints(this.PlayerOne.Rank, this.PlayerOne.Score);
        }
      }
      return "Tied";
    };

    Match.prototype.isPlayerOneWinning = function() {
      if ((this.PlayerOne.getRatioScore() > this.PlayerTwo.getRatioScore()) || (this.PlayerOne.getRatioScore() === this.PlayerTwo.getRatioScore() && this.PlayerNumberWinning === 1)) {
        return true;
      }
      return false;
    };

    Match.prototype.isPlayerTwoWinning = function() {
      if ((this.PlayerOne.getRatioScore() < this.PlayerTwo.getRatioScore()) || (this.PlayerOne.getRatioScore() === this.PlayerTwo.getRatioScore() && this.PlayerNumberWinning === 2)) {
        return true;
      }
      return false;
    };

    Match.prototype.getMatchPointsByTeamNumber = function(teamNumber) {
      if (this.PlayerOne.TeamNumber === teamNumber) {
        return this.getPlayerOneMatchPoints();
      } else {
        if (this.PlayerTwo.TeamNumber === teamNumber) {
          return this.getPlayerTwoMatchPoints();
        }
      }
      return 0;
    };

    Match.prototype.getTotalInnings = function() {
      var i, totalInnings;
      totalInnings = this.CurrentGame.NumberOfInnings;
      if (this.CompletedGames.length > 0) {
        i = 0;
        while (i <= (this.CompletedGames.length - 1)) {
          totalInnings += this.CompletedGames[i].NumberOfInnings;
          i++;
        }
      }
      return totalInnings.toString();
    };

    Match.prototype.getTotalDeadBalls = function() {
      var i, totalDeadBalls;
      totalDeadBalls = this.CurrentGame.getDeadBalls();
      if (this.CompletedGames.length > 0) {
        i = 0;
        while (i <= (this.CompletedGames.length - 1)) {
          totalDeadBalls += this.CompletedGames[i].getDeadBalls();
          i++;
        }
      }
      return totalDeadBalls.toString();
    };

    Match.prototype.getTotalSafeties = function() {
      return this.PlayerOne.getSafeties() + " to " + this.PlayerTwo.getSafeties();
    };

    Match.prototype.getCurrentGameNumber = function() {
      return (this.CompletedGames.length + 1).toString();
    };

    Match.prototype.toJSON = function() {
      return {
        PlayerOne: this.PlayerOne.toJSON(),
        PlayerTwo: this.PlayerTwo.toJSON(),
        PlayerOneMatchPointsEarned: this.getPlayerOneMatchPoints(),
        PlayerTwoMatchPointsEarned: this.getPlayerTwoMatchPoints(),
        CurrentGame: this.CurrentGame.toJSON(),
        CompletedGames: this.completedGamesToJSON(),
        SuddenDeath: this.SuddenDeath,
        Forfeit: this.Forfeit,
        Ended: this.Ended,
        OriginalId: this.OriginalId,
        LeagueMatchId: this.LeagueMatchId
      };
    };

    Match.prototype.completedGamesToJSON = function() {
      var arrayToReturn, i;
      arrayToReturn = [];
      i = 0;
      while (i <= this.CompletedGames.length - 1) {
        arrayToReturn[i] = this.CompletedGames[i].toJSON();
        i++;
      }
      return arrayToReturn;
    };

    Match.prototype.fromJSON = function(json) {
      var currentGame;
      this.PlayerOneMatchPointsEarned = json.PlayerOneMatchPointsEarned;
      this.PlayerTwoMatchPointsEarned = json.PlayerTwoMatchPointsEarned;
      this.PlayerOne = this.playerFromJSON(json.PlayerOne);
      this.PlayerTwo = this.playerFromJSON(json.PlayerTwo);
      this.CompletedGames = this.completedGamesFromJSON(json.CompletedGames);
      this.SuddenDeath = json.SuddenDeath;
      this.Forfeit = json.Forfeit;
      this.Ended = json.Ended;
      this.OriginalId = json.OriginalId;
      this.LeagueMatchId = json.LeagueMatchId;
      currentGame = this.getNewGame();
      currentGame.fromJSON(new function() {
        return json.CurrentGame;
      });
      return this.CurrentGame = currentGame;
    };

    Match.prototype.playerFromJSON = function(json) {
      var player;
      player = new NineBallPlayer();
      player.fromJSON(new function() {
        return json;
      });
      return player;
    };

    Match.prototype.completedGamesFromJSON = function(json) {
      var arrayToReturn, completedGame, i;
      arrayToReturn = [];
      i = 0;
      while (i <= json.length - 1) {
        completedGame = this.getNewGame();
        completedGame.fromJSON(new function() {
          return json[i];
        });
        arrayToReturn.push(completedGame);
        i++;
      }
      return arrayToReturn;
    };

    return Match;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.Match = Match;

  Player = (function(_super) {

    __extends(Player, _super);

    Player.name = 'Player';

    Player.prototype.defaults = {};

    function Player(name, rank, number, teamNumber) {
      _.extend(this, this.defaults);
      this.Name = name;
      this.Rank = rank;
      this.Number = number;
      this.TeamNumber = teamNumber;
      this.BallCount = new NineBallRanks().getBallCount(rank).toString();
      this.Score = 0;
      this.Safeties = 0;
      this.CurrentlyUp = false;
      this.NineOnSnaps = 0;
      this.BreakAndRuns = 0;
      this.TimeoutsTaken = 0;
      this.TimeoutsAllowed = new NineBallRanks().getTimeouts(rank);
      this.IsCaptain = false;
    }

    Player.prototype.resetPlayerRankStats = function() {
      this.BallCount = new NineBallRanks().getBallCount(this.Rank).toString();
      return this.TimeoutsAllowed = new NineBallRanks().getTimeouts(this.Rank);
    };

    Player.prototype.addToScore = function(addToScore) {
      return this.Score += addToScore;
    };

    Player.prototype.addOneToSafeties = function() {
      return this.Safeties += 1;
    };

    Player.prototype.hasWon = function() {
      return this.Score >= this.BallCount;
    };

    Player.prototype.addOneToNineOnSnaps = function() {
      return this.NineOnSnaps += 1;
    };

    Player.prototype.addOneToBreakAndRuns = function() {
      return this.BreakAndRuns += 1;
    };

    Player.prototype.getRemainingBallCount = function() {
      return (this.BallCount - this.Score).toString();
    };

    Player.prototype.getFirstNameWithInitials = function() {
      var nameToReturn, spaceIndex;
      spaceIndex = this.Name.indexOf(" ");
      if (spaceIndex === -1) {
        return this.Name;
      }
      nameToReturn = this.Name.substr(0, spaceIndex);
      return nameToReturn + " " + this.Name[spaceIndex + 1] + ".";
    };

    Player.prototype.getSafeties = function() {
      return this.Safeties.toString();
    };

    Player.prototype.getScore = function() {
      return this.Score.toString();
    };

    Player.prototype.getRatioScore = function() {
      return this.Score / this.BallCount;
    };

    Player.prototype.getNineOnSnaps = function() {
      return this.NineOnSnaps.toString();
    };

    Player.prototype.getBreakAndRuns = function() {
      return this.BreakAndRuns.toString();
    };

    Player.prototype.toJSON = function() {
      return {
        Name: this.Name,
        Rank: this.Rank,
        BallCount: this.BallCount,
        Number: this.Number,
        TeamNumber: this.TeamNumber,
        Score: this.Score,
        Safeties: this.Safeties,
        NineOnSnaps: this.NineOnSnaps,
        BreakAndRuns: this.BreakAndRuns,
        CurrentlyUp: this.CurrentlyUp
      };
    };

    Player.prototype.fromJSON = function(playerJSON) {
      this.Name = playerJSON.Name;
      this.Rank = playerJSON.Rank;
      this.BallCount = playerJSON.BallCount;
      this.Number = playerJSON.Number;
      this.TeamNumber = playerJSON.TeamNumber;
      this.Score = playerJSON.Score;
      this.Safeties = playerJSON.Safeties;
      this.NineOnSnaps = playerJSON.NineOnSnaps;
      this.BreakAndRuns = playerJSON.BreakAndRuns;
      this.CurrentlyUp = playerJSON.CurrentlyUp;
      return this.resetPlayerRankStats();
    };

    return Player;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.Player = Player;

  Ranks = (function(_super) {

    __extends(Ranks, _super);

    Ranks.name = 'Ranks';

    Ranks.prototype.defaults = {
      ball_counts: {
        1: 14,
        2: 19,
        3: 25,
        4: 31,
        5: 38,
        6: 46,
        7: 55,
        8: 65,
        9: 75
      }
    };

    function Ranks() {
      _.extend(this, this.defaults);
      this.setRanks();
    }

    Ranks.prototype.getBallCount = function(rank) {
      return parseInt(this.ball_counts[rank], 10);
    };

    Ranks.prototype.getLosingPlayersMatchPoints = function(loserRank, loserScore) {
      var losingMatchPoints;
      losingMatchPoints = this.losersMatchPoints[loserRank][loserScore];
      return losingMatchPoints;
    };

    Ranks.prototype.getWinningPlayersMatchPoints = function(loserRank, loserScore) {
      var losingMatchPoints, winningMatchPoints;
      losingMatchPoints = this.losersMatchPoints[loserRank][loserScore];
      winningMatchPoints = 20 - this.losersMatchPoints[loserRank][loserScore];
      return winningMatchPoints;
    };

    Ranks.prototype.getTimeouts = function(rank) {
      if (rank < 4) {
        return 2;
      } else if (rank >= 4 && rank <= 9) {
        return 1;
      } else {
        return 0;
      }
    };

    Ranks.prototype.setRanks = function() {
      this.losersMatchPoints = [];
      this.losersMatchPoints[1] = [];
      this.losersMatchPoints[1][0] = 0;
      this.losersMatchPoints[1][1] = 0;
      this.losersMatchPoints[1][2] = 0;
      this.losersMatchPoints[1][3] = 1;
      this.losersMatchPoints[1][4] = 2;
      this.losersMatchPoints[1][5] = 3;
      this.losersMatchPoints[1][6] = 3;
      this.losersMatchPoints[1][7] = 4;
      this.losersMatchPoints[1][8] = 5;
      this.losersMatchPoints[1][9] = 6;
      this.losersMatchPoints[1][10] = 6;
      this.losersMatchPoints[1][11] = 7;
      this.losersMatchPoints[1][12] = 8;
      this.losersMatchPoints[1][13] = 8;
      this.losersMatchPoints[2] = [];
      this.losersMatchPoints[2][0] = 0;
      this.losersMatchPoints[2][1] = 0;
      this.losersMatchPoints[2][2] = 0;
      this.losersMatchPoints[2][3] = 0;
      this.losersMatchPoints[2][4] = 1;
      this.losersMatchPoints[2][5] = 1;
      this.losersMatchPoints[2][6] = 2;
      this.losersMatchPoints[2][7] = 2;
      this.losersMatchPoints[2][8] = 3;
      this.losersMatchPoints[2][9] = 4;
      this.losersMatchPoints[2][10] = 4;
      this.losersMatchPoints[2][11] = 5;
      this.losersMatchPoints[2][12] = 5;
      this.losersMatchPoints[2][13] = 6;
      this.losersMatchPoints[2][14] = 6;
      this.losersMatchPoints[2][15] = 7;
      this.losersMatchPoints[2][16] = 7;
      this.losersMatchPoints[2][17] = 8;
      this.losersMatchPoints[2][18] = 8;
      this.losersMatchPoints[3] = [];
      this.losersMatchPoints[3][0] = 0;
      this.losersMatchPoints[3][1] = 0;
      this.losersMatchPoints[3][2] = 0;
      this.losersMatchPoints[3][3] = 0;
      this.losersMatchPoints[3][4] = 0;
      this.losersMatchPoints[3][5] = 1;
      this.losersMatchPoints[3][6] = 1;
      this.losersMatchPoints[3][7] = 2;
      this.losersMatchPoints[3][8] = 2;
      this.losersMatchPoints[3][9] = 2;
      this.losersMatchPoints[3][10] = 3;
      this.losersMatchPoints[3][11] = 3;
      this.losersMatchPoints[3][12] = 4;
      this.losersMatchPoints[3][13] = 4;
      this.losersMatchPoints[3][14] = 4;
      this.losersMatchPoints[3][15] = 5;
      this.losersMatchPoints[3][16] = 5;
      this.losersMatchPoints[3][17] = 6;
      this.losersMatchPoints[3][18] = 6;
      this.losersMatchPoints[3][19] = 6;
      this.losersMatchPoints[3][20] = 7;
      this.losersMatchPoints[3][21] = 7;
      this.losersMatchPoints[3][22] = 8;
      this.losersMatchPoints[3][23] = 8;
      this.losersMatchPoints[3][24] = 8;
      this.losersMatchPoints[4] = [];
      this.losersMatchPoints[4][0] = 0;
      this.losersMatchPoints[4][1] = 0;
      this.losersMatchPoints[4][2] = 0;
      this.losersMatchPoints[4][3] = 0;
      this.losersMatchPoints[4][4] = 0;
      this.losersMatchPoints[4][5] = 0;
      this.losersMatchPoints[4][6] = 1;
      this.losersMatchPoints[4][7] = 1;
      this.losersMatchPoints[4][8] = 1;
      this.losersMatchPoints[4][9] = 2;
      this.losersMatchPoints[4][10] = 2;
      this.losersMatchPoints[4][11] = 2;
      this.losersMatchPoints[4][12] = 3;
      this.losersMatchPoints[4][13] = 3;
      this.losersMatchPoints[4][14] = 3;
      this.losersMatchPoints[4][15] = 4;
      this.losersMatchPoints[4][16] = 4;
      this.losersMatchPoints[4][17] = 4;
      this.losersMatchPoints[4][18] = 4;
      this.losersMatchPoints[4][19] = 5;
      this.losersMatchPoints[4][20] = 5;
      this.losersMatchPoints[4][21] = 5;
      this.losersMatchPoints[4][22] = 6;
      this.losersMatchPoints[4][23] = 6;
      this.losersMatchPoints[4][24] = 6;
      this.losersMatchPoints[4][25] = 7;
      this.losersMatchPoints[4][26] = 7;
      this.losersMatchPoints[4][27] = 7;
      this.losersMatchPoints[4][28] = 8;
      this.losersMatchPoints[4][29] = 8;
      this.losersMatchPoints[4][30] = 8;
      this.losersMatchPoints[5] = [];
      this.losersMatchPoints[5][0] = 0;
      this.losersMatchPoints[5][1] = 0;
      this.losersMatchPoints[5][2] = 0;
      this.losersMatchPoints[5][3] = 0;
      this.losersMatchPoints[5][4] = 0;
      this.losersMatchPoints[5][5] = 0;
      this.losersMatchPoints[5][6] = 0;
      this.losersMatchPoints[5][7] = 1;
      this.losersMatchPoints[5][8] = 1;
      this.losersMatchPoints[5][9] = 1;
      this.losersMatchPoints[5][10] = 1;
      this.losersMatchPoints[5][11] = 2;
      this.losersMatchPoints[5][12] = 2;
      this.losersMatchPoints[5][13] = 2;
      this.losersMatchPoints[5][14] = 2;
      this.losersMatchPoints[5][15] = 3;
      this.losersMatchPoints[5][16] = 3;
      this.losersMatchPoints[5][17] = 3;
      this.losersMatchPoints[5][18] = 3;
      this.losersMatchPoints[5][19] = 4;
      this.losersMatchPoints[5][20] = 4;
      this.losersMatchPoints[5][21] = 4;
      this.losersMatchPoints[5][22] = 4;
      this.losersMatchPoints[5][23] = 5;
      this.losersMatchPoints[5][24] = 5;
      this.losersMatchPoints[5][25] = 5;
      this.losersMatchPoints[5][26] = 5;
      this.losersMatchPoints[5][27] = 6;
      this.losersMatchPoints[5][28] = 6;
      this.losersMatchPoints[5][29] = 6;
      this.losersMatchPoints[5][30] = 7;
      this.losersMatchPoints[5][31] = 7;
      this.losersMatchPoints[5][32] = 7;
      this.losersMatchPoints[5][33] = 7;
      this.losersMatchPoints[5][34] = 8;
      this.losersMatchPoints[5][35] = 8;
      this.losersMatchPoints[5][36] = 8;
      this.losersMatchPoints[5][37] = 8;
      this.losersMatchPoints[6] = [];
      this.losersMatchPoints[6][0] = 0;
      this.losersMatchPoints[6][1] = 0;
      this.losersMatchPoints[6][2] = 0;
      this.losersMatchPoints[6][3] = 0;
      this.losersMatchPoints[6][4] = 0;
      this.losersMatchPoints[6][5] = 0;
      this.losersMatchPoints[6][6] = 0;
      this.losersMatchPoints[6][7] = 0;
      this.losersMatchPoints[6][8] = 0;
      this.losersMatchPoints[6][9] = 1;
      this.losersMatchPoints[6][10] = 1;
      this.losersMatchPoints[6][11] = 1;
      this.losersMatchPoints[6][12] = 1;
      this.losersMatchPoints[6][13] = 2;
      this.losersMatchPoints[6][14] = 2;
      this.losersMatchPoints[6][15] = 2;
      this.losersMatchPoints[6][16] = 2;
      this.losersMatchPoints[6][17] = 2;
      this.losersMatchPoints[6][18] = 3;
      this.losersMatchPoints[6][19] = 3;
      this.losersMatchPoints[6][20] = 3;
      this.losersMatchPoints[6][21] = 3;
      this.losersMatchPoints[6][22] = 3;
      this.losersMatchPoints[6][23] = 4;
      this.losersMatchPoints[6][24] = 4;
      this.losersMatchPoints[6][25] = 4;
      this.losersMatchPoints[6][26] = 4;
      this.losersMatchPoints[6][27] = 4;
      this.losersMatchPoints[6][28] = 5;
      this.losersMatchPoints[6][29] = 5;
      this.losersMatchPoints[6][30] = 5;
      this.losersMatchPoints[6][31] = 5;
      this.losersMatchPoints[6][32] = 6;
      this.losersMatchPoints[6][33] = 6;
      this.losersMatchPoints[6][34] = 6;
      this.losersMatchPoints[6][35] = 6;
      this.losersMatchPoints[6][36] = 6;
      this.losersMatchPoints[6][37] = 7;
      this.losersMatchPoints[6][38] = 7;
      this.losersMatchPoints[6][39] = 7;
      this.losersMatchPoints[6][40] = 7;
      this.losersMatchPoints[6][41] = 8;
      this.losersMatchPoints[6][42] = 8;
      this.losersMatchPoints[6][43] = 8;
      this.losersMatchPoints[6][44] = 8;
      this.losersMatchPoints[6][45] = 8;
      this.losersMatchPoints[7] = [];
      this.losersMatchPoints[7][0] = 0;
      this.losersMatchPoints[7][1] = 0;
      this.losersMatchPoints[7][2] = 0;
      this.losersMatchPoints[7][3] = 0;
      this.losersMatchPoints[7][4] = 0;
      this.losersMatchPoints[7][5] = 0;
      this.losersMatchPoints[7][6] = 0;
      this.losersMatchPoints[7][7] = 0;
      this.losersMatchPoints[7][8] = 0;
      this.losersMatchPoints[7][9] = 0;
      this.losersMatchPoints[7][10] = 0;
      this.losersMatchPoints[7][11] = 1;
      this.losersMatchPoints[7][12] = 1;
      this.losersMatchPoints[7][13] = 1;
      this.losersMatchPoints[7][14] = 1;
      this.losersMatchPoints[7][15] = 1;
      this.losersMatchPoints[7][16] = 2;
      this.losersMatchPoints[7][17] = 2;
      this.losersMatchPoints[7][18] = 2;
      this.losersMatchPoints[7][19] = 2;
      this.losersMatchPoints[7][20] = 2;
      this.losersMatchPoints[7][21] = 2;
      this.losersMatchPoints[7][22] = 3;
      this.losersMatchPoints[7][23] = 3;
      this.losersMatchPoints[7][24] = 3;
      this.losersMatchPoints[7][25] = 3;
      this.losersMatchPoints[7][26] = 3;
      this.losersMatchPoints[7][27] = 4;
      this.losersMatchPoints[7][28] = 4;
      this.losersMatchPoints[7][29] = 4;
      this.losersMatchPoints[7][30] = 4;
      this.losersMatchPoints[7][31] = 4;
      this.losersMatchPoints[7][32] = 4;
      this.losersMatchPoints[7][33] = 5;
      this.losersMatchPoints[7][34] = 5;
      this.losersMatchPoints[7][35] = 5;
      this.losersMatchPoints[7][36] = 5;
      this.losersMatchPoints[7][37] = 5;
      this.losersMatchPoints[7][38] = 6;
      this.losersMatchPoints[7][39] = 6;
      this.losersMatchPoints[7][40] = 6;
      this.losersMatchPoints[7][41] = 6;
      this.losersMatchPoints[7][42] = 6;
      this.losersMatchPoints[7][43] = 6;
      this.losersMatchPoints[7][44] = 7;
      this.losersMatchPoints[7][45] = 7;
      this.losersMatchPoints[7][46] = 7;
      this.losersMatchPoints[7][47] = 7;
      this.losersMatchPoints[7][48] = 7;
      this.losersMatchPoints[7][49] = 7;
      this.losersMatchPoints[7][50] = 8;
      this.losersMatchPoints[7][51] = 8;
      this.losersMatchPoints[7][52] = 8;
      this.losersMatchPoints[7][53] = 8;
      this.losersMatchPoints[7][54] = 8;
      this.losersMatchPoints[8] = [];
      this.losersMatchPoints[8][0] = 0;
      this.losersMatchPoints[8][1] = 0;
      this.losersMatchPoints[8][2] = 0;
      this.losersMatchPoints[8][3] = 0;
      this.losersMatchPoints[8][4] = 0;
      this.losersMatchPoints[8][5] = 0;
      this.losersMatchPoints[8][6] = 0;
      this.losersMatchPoints[8][7] = 0;
      this.losersMatchPoints[8][8] = 0;
      this.losersMatchPoints[8][9] = 0;
      this.losersMatchPoints[8][10] = 0;
      this.losersMatchPoints[8][11] = 0;
      this.losersMatchPoints[8][12] = 0;
      this.losersMatchPoints[8][13] = 0;
      this.losersMatchPoints[8][14] = 1;
      this.losersMatchPoints[8][15] = 1;
      this.losersMatchPoints[8][16] = 1;
      this.losersMatchPoints[8][17] = 1;
      this.losersMatchPoints[8][18] = 1;
      this.losersMatchPoints[8][19] = 1;
      this.losersMatchPoints[8][20] = 2;
      this.losersMatchPoints[8][21] = 2;
      this.losersMatchPoints[8][22] = 2;
      this.losersMatchPoints[8][23] = 2;
      this.losersMatchPoints[8][24] = 2;
      this.losersMatchPoints[8][25] = 2;
      this.losersMatchPoints[8][26] = 2;
      this.losersMatchPoints[8][27] = 3;
      this.losersMatchPoints[8][28] = 3;
      this.losersMatchPoints[8][29] = 3;
      this.losersMatchPoints[8][30] = 3;
      this.losersMatchPoints[8][31] = 3;
      this.losersMatchPoints[8][32] = 3;
      this.losersMatchPoints[8][33] = 4;
      this.losersMatchPoints[8][34] = 4;
      this.losersMatchPoints[8][35] = 4;
      this.losersMatchPoints[8][36] = 4;
      this.losersMatchPoints[8][37] = 4;
      this.losersMatchPoints[8][38] = 4;
      this.losersMatchPoints[8][39] = 4;
      this.losersMatchPoints[8][40] = 5;
      this.losersMatchPoints[8][41] = 5;
      this.losersMatchPoints[8][42] = 5;
      this.losersMatchPoints[8][43] = 5;
      this.losersMatchPoints[8][44] = 5;
      this.losersMatchPoints[8][45] = 5;
      this.losersMatchPoints[8][46] = 6;
      this.losersMatchPoints[8][47] = 6;
      this.losersMatchPoints[8][48] = 6;
      this.losersMatchPoints[8][49] = 6;
      this.losersMatchPoints[8][50] = 6;
      this.losersMatchPoints[8][51] = 6;
      this.losersMatchPoints[8][52] = 6;
      this.losersMatchPoints[8][53] = 7;
      this.losersMatchPoints[8][54] = 7;
      this.losersMatchPoints[8][55] = 7;
      this.losersMatchPoints[8][56] = 7;
      this.losersMatchPoints[8][57] = 7;
      this.losersMatchPoints[8][58] = 7;
      this.losersMatchPoints[8][59] = 8;
      this.losersMatchPoints[8][60] = 8;
      this.losersMatchPoints[8][61] = 8;
      this.losersMatchPoints[8][62] = 8;
      this.losersMatchPoints[8][63] = 8;
      this.losersMatchPoints[8][64] = 8;
      this.losersMatchPoints[9] = [];
      this.losersMatchPoints[9][0] = 0;
      this.losersMatchPoints[9][1] = 0;
      this.losersMatchPoints[9][2] = 0;
      this.losersMatchPoints[9][3] = 0;
      this.losersMatchPoints[9][4] = 0;
      this.losersMatchPoints[9][5] = 0;
      this.losersMatchPoints[9][6] = 0;
      this.losersMatchPoints[9][7] = 0;
      this.losersMatchPoints[9][8] = 0;
      this.losersMatchPoints[9][9] = 0;
      this.losersMatchPoints[9][10] = 0;
      this.losersMatchPoints[9][11] = 0;
      this.losersMatchPoints[9][12] = 0;
      this.losersMatchPoints[9][13] = 0;
      this.losersMatchPoints[9][14] = 0;
      this.losersMatchPoints[9][15] = 0;
      this.losersMatchPoints[9][16] = 0;
      this.losersMatchPoints[9][17] = 0;
      this.losersMatchPoints[9][18] = 0;
      this.losersMatchPoints[9][19] = 1;
      this.losersMatchPoints[9][20] = 1;
      this.losersMatchPoints[9][21] = 1;
      this.losersMatchPoints[9][22] = 1;
      this.losersMatchPoints[9][23] = 1;
      this.losersMatchPoints[9][24] = 1;
      this.losersMatchPoints[9][25] = 2;
      this.losersMatchPoints[9][26] = 2;
      this.losersMatchPoints[9][27] = 2;
      this.losersMatchPoints[9][28] = 2;
      this.losersMatchPoints[9][29] = 2;
      this.losersMatchPoints[9][30] = 2;
      this.losersMatchPoints[9][31] = 2;
      this.losersMatchPoints[9][32] = 3;
      this.losersMatchPoints[9][33] = 3;
      this.losersMatchPoints[9][34] = 3;
      this.losersMatchPoints[9][35] = 3;
      this.losersMatchPoints[9][36] = 3;
      this.losersMatchPoints[9][37] = 3;
      this.losersMatchPoints[9][38] = 3;
      this.losersMatchPoints[9][39] = 4;
      this.losersMatchPoints[9][40] = 4;
      this.losersMatchPoints[9][41] = 4;
      this.losersMatchPoints[9][42] = 4;
      this.losersMatchPoints[9][43] = 4;
      this.losersMatchPoints[9][44] = 4;
      this.losersMatchPoints[9][45] = 4;
      this.losersMatchPoints[9][46] = 4;
      this.losersMatchPoints[9][47] = 5;
      this.losersMatchPoints[9][48] = 5;
      this.losersMatchPoints[9][49] = 5;
      this.losersMatchPoints[9][50] = 5;
      this.losersMatchPoints[9][51] = 5;
      this.losersMatchPoints[9][52] = 5;
      this.losersMatchPoints[9][53] = 5;
      this.losersMatchPoints[9][54] = 6;
      this.losersMatchPoints[9][55] = 6;
      this.losersMatchPoints[9][56] = 6;
      this.losersMatchPoints[9][57] = 6;
      this.losersMatchPoints[9][58] = 6;
      this.losersMatchPoints[9][59] = 6;
      this.losersMatchPoints[9][60] = 6;
      this.losersMatchPoints[9][61] = 7;
      this.losersMatchPoints[9][62] = 7;
      this.losersMatchPoints[9][63] = 7;
      this.losersMatchPoints[9][64] = 7;
      this.losersMatchPoints[9][65] = 7;
      this.losersMatchPoints[9][66] = 7;
      this.losersMatchPoints[9][67] = 7;
      this.losersMatchPoints[9][68] = 8;
      this.losersMatchPoints[9][69] = 8;
      this.losersMatchPoints[9][70] = 8;
      this.losersMatchPoints[9][71] = 8;
      this.losersMatchPoints[9][72] = 8;
      this.losersMatchPoints[9][73] = 8;
      return this.losersMatchPoints[9][74] = 8;
    };

    return Ranks;

  })($CS.Models.NineBall);

  $CS.Models.NineBall.Ranks = Ranks;

  Player = (function(_super) {

    __extends(Player, _super);

    Player.name = 'Player';

    Player.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    function Player() {
      _.extend(this, this.defaults);
      this.bind("change:name", function() {
        var name;
        return name = this.get("name");
      });
    }

    Player.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Player;

  })(Backbone.Model);

  $CS.Models.Player = Player;

  Post = (function(_super) {

    __extends(Post, _super);

    Post.name = 'Post';

    function Post() {
      return Post.__super__.constructor.apply(this, arguments);
    }

    Post.prototype.url = "" + $CS.API_ENDPOINT + "/posts";

    Post.prototype.toParams = function() {
      return $CS.Utils.QueryStringBuilder.stringify(this.attributes, "post");
    };

    Post.prototype.toJSON = function() {
      return {
        post: this.attributes
      };
    };

    return Post;

  })(Backbone.Model);

  Posts = (function(_super) {

    __extends(Posts, _super);

    Posts.name = 'Posts';

    function Posts() {
      return Posts.__super__.constructor.apply(this, arguments);
    }

    Posts.prototype.url = "" + $CS.API_ENDPOINT + "/posts";

    Posts.prototype.model = Post;

    return Posts;

  })(Backbone.Collection);

  $CS.Models.Post = Post;

  $CS.Models.Posts = Posts;

  Rank = (function(_super) {

    __extends(Rank, _super);

    Rank.name = 'Rank';

    Rank.prototype.defaults = {};

    function Rank() {
      _.extend(this, this.defaults);
    }

    return Rank;

  })(Backbone.Model);

  $CS.Models.Rank = Rank;

  Team = (function(_super) {

    __extends(Team, _super);

    Team.name = 'Team';

    Team.prototype.defaults = {};

    function Team() {
      _.extend(this, this.defaults);
    }

    return Team;

  })(Backbone.Model);

  $CS.Models.Team = Team;

  $CS.Helpers.Application = {
    createOrientiationModes: function() {
      var modes;
      modes = [Titanium.UI.PORTRAIT, Titanium.UI.UPSIDE_PORTRAIT, Titanium.UI.LANDSCAPE_LEFT, Titanium.UI.LANDSCAPE_RIGHT];
      return modes;
    }
  };

  DashboardController = (function() {

    DashboardController.name = 'DashboardController';

    DashboardController.prototype.opts = {};

    function DashboardController(options) {
      this.options = options;
      this.options = _.extend({}, this.opts, this.options);
      this.displayType = "grid";
      this.createWindows();
    }

    DashboardController.prototype.createWindows = function() {
      return this.dashboard = new $CS.Views.Dashboard(this.displayType);
    };

    DashboardController.prototype.open = function() {
      return this.dashboard.open();
    };

    return DashboardController;

  })();

  $CS.Controllers.DashboardController = DashboardController;

  $CS.Views.Play.create9BallGameView = function(options) {
    var view;
    view = Ti.UI.createView(options);
    return view;
  };

  PostsController = (function() {

    PostsController.name = 'PostsController';

    PostsController.prototype.opts = {};

    function PostsController(options) {
      this.options = options;
      this.options = _.extend({}, this.opts, this.options);
      this.postView = new $CS.Views.PostsView();
    }

    PostsController.prototype.open = function() {
      if (Ti.Platform.name !== "android") {
        Ti.UI.iPhone.showStatusBar();
        return this.postView.open({
          fullscreen: false
        });
      } else {
        return this.postView.open({
          fullscreen: true
        });
      }
    };

    return PostsController;

  })();

  $CS.Controllers.PostsController = PostsController;

  DashboardView = (function(_super) {

    __extends(DashboardView, _super);

    DashboardView.name = 'DashboardView';

    DashboardView.prototype.defaults = {};

    function DashboardView(displayType) {
      this.showList = __bind(this.showList, this);

      this.showGrid = __bind(this.showGrid, this);

      this.isList = __bind(this.isList, this);

      this.isGrid = __bind(this.isGrid, this);

      this.handle_btn_click = __bind(this.handle_btn_click, this);
      _.extend(this, this.defaults);
      this.displayType = displayType;
      Ti.UI.setBackgroundColor("#000000");
      $CS.Views.Dashboard.createMainWindow = this.createMainWindow;
      $CS.Views.Dashboard.createMainView = this.createMainView;
      $CS.Views.Dashboard.showGrid = this.showGrid;
      $CS.Views.Dashboard.showList = this.showList;
      $CS.Views.Dashboard.isGrid = this.isGrid;
      $CS.Views.Dashboard.isList = this.isList;
      this.setUp();
    }

    DashboardView.prototype.setUp = function() {
      this.titleBar = this.getTitleBar();
      this.viewType = this.getDisplayType(this.displayType);
      this.dashboardWindow = $.Window({
        title: 'Dashboard',
        id: 'dashboardWindow',
        orientationModes: $CS.Helpers.Application.createOrientiationModes
      });
      this.dashboardView = $.View({
        id: 'dashboardView'
      });
      this.dashboardContainer = $.View({
        backgroundImage: (Ti.Platform.name !== "android" ? "images/match/layout/bg-menus-iphone.png" : "images/match/layout/bg-menus-android.png"),
        backgroundColor: "transparent",
        top: 44,
        left: 0,
        height: $CS.Utilities.getPlatformHeight() - 44,
        width: $CS.Utilities.getPlatformWidth()
      });
      this.dashboardContainer.add(this.viewType);
      this.dashboardView.add(this.dashboardContainer);
      this.dashboardView.add(this.titleBar);
      this.dashboardWindow.add(this.dashboardView);
      return this.bindEvents();
    };

    DashboardView.prototype.bindEvents = function() {
      return this.dashboardWindow.addEventListener('click', this.handle_btn_click);
    };

    DashboardView.prototype.handle_btn_click = function(e) {
      return console.warn("button clicked: " + (JSON.stringify(e)));
    };

    DashboardView.prototype.getTitleBar = function() {
      var titleBar, titleBarClass;
      titleBarClass = new $CS.Views.Dashboard.TitleBarView(this.displayType);
      titleBar = titleBarClass.titleBar;
      return titleBar;
    };

    DashboardView.prototype.createMainWindow = function(options) {
      var window;
      if (options == null) {
        options = {};
      }
      window = Ti.UI.createWindow(options);
      return window;
    };

    DashboardView.prototype.createMainView = function(options) {
      var view;
      if (options == null) {
        options = {};
      }
      view = Ti.UI.createView(options);
      return view;
    };

    DashboardView.prototype.getDisplayType = function(type) {
      var gridViewClass, listViewClass;
      if (this.isGrid()) {
        gridViewClass = new $CS.Views.Dashboard.GridView();
        this.gridView = gridViewClass.gridView;
        return this.gridView;
      } else if (this.isList()) {
        listViewClass = new $CS.Views.Dashboard.ListView();
        this.listView = listViewClass.listView;
        return this.listView;
      }
    };

    DashboardView.prototype.open = function() {
      if (Ti.Platform.name !== "android") {
        Ti.UI.iPhone.showStatusBar();
        return this.dashboardWindow.open({
          fullscreen: false
        });
      } else {
        return this.dashboardWindow.open({
          fullscreen: true
        });
      }
    };

    DashboardView.prototype.isGrid = function() {
      return this.displayType === "grid";
    };

    DashboardView.prototype.isList = function() {
      return this.displayType === "list";
    };

    DashboardView.prototype.showGrid = function() {
      this.displayType = "grid";
      this.gridView.visible = true;
      return this.listView.visible = false;
    };

    DashboardView.prototype.showList = function() {
      this.displayType = "list";
      this.gridView.visible = false;
      return this.listView.visible = true;
    };

    return DashboardView;

  })(Template);

  $CS.Views.Dashboard = DashboardView;

  TitleBarView = (function(_super) {

    __extends(TitleBarView, _super);

    TitleBarView.name = 'TitleBarView';

    TitleBarView.prototype.defaults = {};

    function TitleBarView(displayType) {
      _.extend(this, this.defaults);
      this.setUp(displayType);
    }

    TitleBarView.prototype.setUp = function(displayType) {
      var dashboardLabel, gridButton, gridButtonLabel, listButton, listButtonLabel;
      this.titleBar = Titanium.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/layout/titlebar-matches.png",
        top: 0,
        left: 0,
        width: $CS.Utilities.getPlatformWidth(),
        height: 44,
        isNinePatch: false
      });
      dashboardLabel = Titanium.UI.createLabel({
        text: "Dashboard",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      gridButton = Titanium.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: $CS.Views.Dashboard.isGrid() ? "images/match/buttons/btn-dashboard-viewtype-selected.png" : "images/match/buttons/btn-dashboard-viewtype.png",
        top: 7,
        left: 8,
        width: 80,
        height: 30
      });
      gridButtonLabel = Titanium.UI.createLabel({
        text: "Grid View",
        color: "#ffffff",
        shadowColor: "#000000",
        left: 11,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      gridButton.add(gridButtonLabel);
      listButton = Titanium.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: $CS.Views.Dashboard.isList() ? "images/match/buttons/btn-dashboard-viewtype-selected.png" : "images/match/buttons/btn-dashboard-viewtype.png",
        top: 7,
        right: 8,
        width: 80,
        height: 30
      });
      listButtonLabel = Titanium.UI.createLabel({
        text: "List View",
        color: "#ffffff",
        shadowColor: "#000000",
        left: 11,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      listButton.add(listButtonLabel);
      gridButton.addEventListener("click", function() {
        $CS.Views.Dashboard.showGrid();
        gridButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
        });
        listButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
        });
        gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png";
        return listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png";
      });
      listButton.addEventListener("click", function() {
        $CS.Views.Dashboard.showList();
        gridButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype-selected.png"
        });
        listButton.animate({
          backgroundImage: "images/match/buttons/btn-dashboard-viewtype.png"
        });
        gridButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype.png";
        return listButton.backgroundImage = "images/match/buttons/btn-dashboard-viewtype-selected.png";
      });
      this.titleBar.add(gridButton);
      this.titleBar.add(listButton);
      this.titleBar.add(dashboardLabel);
      return this.titleBar;
    };

    return TitleBarView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.TitleBarView = TitleBarView;

  ActivityView = (function(_super) {

    __extends(ActivityView, _super);

    ActivityView.name = 'ActivityView';

    ActivityView.prototype.defaults = {};

    function ActivityView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    ActivityView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.activityWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.activityContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.activityScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.activityView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.activityLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.activityView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Activity",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.activityContainer.add(toolsMenuContainer);
      this.activityContainer.add(titleBar);
      this.activityContainer.add(this.activityView);
      this.activityWindow.add(this.activityContainer);
      this.dashboardButton.addEventListener("click", function() {
        _this.activityWindow.close();
        return _this.dashboardWindow.show();
      });
      ({
        showActivity: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.activityWindow.open({
              fullscreen: false
            });
          } else {
            return _this.activityWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showActivity();
    };

    return ActivityView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.ActivityView = ActivityView;

  EventsView = (function(_super) {

    __extends(EventsView, _super);

    EventsView.name = 'EventsView';

    EventsView.prototype.defaults = {};

    function EventsView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    EventsView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.eventsWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.eventsContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.eventsScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.eventsView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.eventsLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.eventsView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Events",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.eventsContainer.add(toolsMenuContainer);
      this.eventsContainer.add(titleBar);
      this.eventsContainer.add(this.eventsView);
      this.eventsWindow.add(this.eventsContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.eventsWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showEvents: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.eventsWindow.open({
              fullscreen: false
            });
          } else {
            return _this.eventsWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showEvents();
    };

    return EventsView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.EventsView = EventsView;

  GridView = (function(_super) {

    __extends(GridView, _super);

    GridView.name = 'GridView';

    GridView.prototype.defaults = {};

    function GridView() {
      var activityIcon, activityIconBackground, activityIconContainer, activityIconLabel, activityWindowHolder, eventsIcon, eventsIconBackground, eventsIconContainer, eventsIconLabel, eventsWindowHolder, liveIcon, liveIconBackground, liveIconContainer, liveIconLabel, liveWindowHolder, newsIcon, newsIconBackground, newsIconContainer, newsIconLabel, newsWindowHolder, playIcon, playIconBackground, playIconContainer, playIconLabel, playWindowHolder, profileIcon, profileIconBackground, profileIconContainer, profileIconLabel, profileWindowHolder, rulesIcon, rulesIconBackground, rulesIconContainer, rulesIconLabel, rulesWindowHolder, settingsIcon, settingsIconBackground, settingsIconContainer, settingsIconLabel, settingsWindowHolder, teamsIcon, teamsIconBackground, teamsIconContainer, teamsIconLabel, teamsWindowHolder;
      _.extend(this, this.defaults);
      playWindowHolder = null;
      teamsWindowHolder = null;
      activityWindowHolder = null;
      profileWindowHolder = null;
      newsWindowHolder = null;
      eventsWindowHolder = null;
      liveWindowHolder = null;
      rulesWindowHolder = null;
      settingsWindowHolder = null;
      this.gridView = Ti.UI.createView({
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        isNinePatch: false
      });
      playIconContainer = Ti.UI.createView({
        left: 13,
        top: 16,
        height: 102,
        width: 82
      });
      playIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      playIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-play-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      playIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Play",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      playIcon.addEventListener("click", function() {
        if (playWindowHolder == null) {
          playWindowHolder = matchSetup();
        } else {
          playWindowHolder.showMatchSetup();
        }
        return dashboardWindow.hide();
      });
      playIconBackground.add(playIcon);
      playIconContainer.add(playIconBackground);
      playIconContainer.add(playIconLabel);
      teamsIconContainer = Ti.UI.createView({
        left: 108,
        top: 16,
        height: 102,
        width: 82
      });
      teamsIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      teamsIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-leagues-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      teamsIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Teams",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      teamsIcon.addEventListener("click", function() {
        if (teamsWindowHolder == null) {
          teamsWindowHolder = teams();
        } else {
          teamsWindowHolder.showTeams();
        }
        return dashboardWindow.hide();
      });
      teamsIconBackground.add(teamsIcon);
      teamsIconContainer.add(teamsIconBackground);
      teamsIconContainer.add(teamsIconLabel);
      activityIconContainer = Ti.UI.createView({
        left: 203,
        top: 16,
        height: 102,
        width: 82
      });
      activityIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      activityIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-activity-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      activityIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Activity",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      activityIcon.addEventListener("click", function() {
        if (activityWindowHolder == null) {
          activityWindowHolder = activity();
        } else {
          activityWindowHolder.showActivity();
        }
        return dashboardWindow.hide();
      });
      activityIconBackground.add(activityIcon);
      activityIconContainer.add(activityIconBackground);
      activityIconContainer.add(activityIconLabel);
      profileIconContainer = Ti.UI.createView({
        left: 13,
        top: 137,
        height: 102,
        width: 82
      });
      profileIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      profileIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-profile-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      profileIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Profile",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      profileIcon.addEventListener("click", function() {
        if (profileWindowHolder == null) {
          profileWindowHolder = profile();
        } else {
          profileWindowHolder.showProfile();
        }
        return dashboardWindow.hide();
      });
      profileIconBackground.add(profileIcon);
      profileIconContainer.add(profileIconBackground);
      profileIconContainer.add(profileIconLabel);
      newsIconContainer = Ti.UI.createView({
        left: 108,
        top: 137,
        height: 102,
        width: 82
      });
      newsIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      newsIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-news-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      newsIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "News",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      newsIcon.addEventListener("click", function() {
        if (newsWindowHolder == null) {
          newsWindowHolder = news();
        } else {
          newsWindowHolder.showNews();
        }
        return dashboardWindow.hide();
      });
      newsIconBackground.add(newsIcon);
      newsIconContainer.add(newsIconBackground);
      newsIconContainer.add(newsIconLabel);
      eventsIconContainer = Ti.UI.createView({
        left: 203,
        top: 137,
        height: 102,
        width: 82
      });
      eventsIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      eventsIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-events-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      eventsIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Events",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      eventsIcon.addEventListener("click", function() {
        if (eventsWindowHolder == null) {
          eventsWindowHolder = events();
        } else {
          eventsWindowHolder.showEvents();
        }
        return dashboardWindow.hide();
      });
      eventsIconBackground.add(eventsIcon);
      eventsIconContainer.add(eventsIconBackground);
      eventsIconContainer.add(eventsIconLabel);
      liveIconContainer = Ti.UI.createView({
        left: 13,
        top: 255,
        height: 102,
        width: 82
      });
      liveIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      liveIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-live-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      liveIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Live",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      liveIcon.addEventListener("click", function() {
        if (liveWindowHolder == null) {
          liveWindowHolder = live();
        } else {
          liveWindowHolder.showLive();
        }
        return dashboardWindow.hide();
      });
      liveIconBackground.add(liveIcon);
      liveIconContainer.add(liveIconBackground);
      liveIconContainer.add(liveIconLabel);
      rulesIconContainer = Ti.UI.createView({
        left: 108,
        top: 255,
        height: 102,
        width: 82
      });
      rulesIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      rulesIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-rules-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      rulesIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Rules",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      rulesIcon.addEventListener("click", function() {
        if (rulesWindowHolder == null) {
          rulesWindowHolder = rules();
        } else {
          rulesWindowHolder.showRules();
        }
        return dashboardWindow.hide();
      });
      rulesIconBackground.add(rulesIcon);
      rulesIconContainer.add(rulesIconBackground);
      rulesIconContainer.add(rulesIconLabel);
      settingsIconContainer = Ti.UI.createView({
        left: 203,
        top: 255,
        height: 102,
        width: 82
      });
      settingsIconBackground = Ti.UI.createView({
        backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png",
        top: 0,
        left: 0,
        height: 83,
        width: 82
      });
      settingsIcon = Ti.UI.createView({
        backgroundImage: "images/match/buttons/btn-dashboard-settings-large.png",
        top: 5,
        left: 6,
        height: 71,
        width: 70
      });
      settingsIconLabel = Ti.UI.createLabel({
        color: "#ffffff",
        backgroundColor: "transparent",
        text: "Settings",
        top: 80,
        height: 20,
        width: 82,
        textAlign: "center",
        font: {
          fontSize: 14,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      settingsIcon.addEventListener("click", function() {
        if (settingsWindowHolder == null) {
          settingsWindowHolder = settings();
        } else {
          settingsWindowHolder.showSettings();
        }
        return dashboardWindow.hide();
      });
      settingsIconBackground.add(settingsIcon);
      settingsIconContainer.add(settingsIconBackground);
      settingsIconContainer.add(settingsIconLabel);
      this.gridView.add(playIconContainer);
      this.gridView.add(teamsIconContainer);
      this.gridView.add(activityIconContainer);
      this.gridView.add(profileIconContainer);
      this.gridView.add(newsIconContainer);
      this.gridView.add(eventsIconContainer);
      this.gridView.add(liveIconContainer);
      this.gridView.add(rulesIconContainer);
      this.gridView.add(settingsIconContainer);
    }

    return GridView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.GridView = GridView;

  ListView = (function(_super) {

    __extends(ListView, _super);

    ListView.name = 'ListView';

    ListView.prototype.defaults = {};

    function ListView() {
      _.extend(this, this.defaults);
      this.listView = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        isNinePatch: false
      });
    }

    return ListView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.ListView = ListView;

  LiveView = (function(_super) {

    __extends(LiveView, _super);

    LiveView.name = 'LiveView';

    LiveView.prototype.defaults = {};

    function LiveView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    LiveView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.liveWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.liveContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.liveScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.liveView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.liveLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.liveView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Live",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.liveContainer.add(toolsMenuContainer);
      this.liveContainer.add(titleBar);
      this.liveContainer.add(this.liveView);
      this.liveWindow.add(this.liveContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.liveWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showLive: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.liveWindow.open({
              fullscreen: false
            });
          } else {
            return _this.liveWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showLive();
    };

    return LiveView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.LiveView = LiveView;

  MenuView = (function(_super) {

    __extends(MenuView, _super);

    MenuView.name = 'MenuView';

    MenuView.prototype.defaults = {};

    function MenuView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    MenuView.prototype.setUp = function() {
      var titleBar, toolsMenuContainer;
      toolsMenuContainer = Ti.UI.createView({
        backgroundImage: (Ti.Platform.name !== "android" ? "images/match/layout/bg-menus-iphone.png" : "images/match/layout/bg-menus-android.png"),
        backgroundColor: "transparent",
        top: 44,
        left: 0,
        height: this.getPlatformHeight() - 44,
        width: this.getPlatformWidth()
      });
      titleBar = Ti.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/layout/titlebar-matches.png",
        top: 0,
        left: 0,
        width: this.getPlatformWidth(),
        height: 44,
        isNinePatch: false
      });
      this.dashboardButton = Ti.UI.createView({
        backgroundColor: "transparent",
        backgroundImage: "images/match/buttons/btn-tabmenu-backto-dashboard.png",
        top: 7,
        left: 8,
        width: 93,
        height: 30,
        isNinePatch: false
      });
      this.dashboardButtonLabel = Ti.UI.createLabel({
        text: "Dashboard",
        color: "#ffffff",
        shadowColor: "#000000",
        left: 13,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      return this.dashboardButton.add(this.dashboardButtonLabel);
    };

    return MenuView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.MenuView = MenuView;

  NewsView = (function(_super) {

    __extends(NewsView, _super);

    NewsView.name = 'NewsView';

    NewsView.prototype.defaults = {};

    function NewsView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    NewsView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.newsWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.newsContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.newsScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.newsView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.newsLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.newsView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "News",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.newsContainer.add(toolsMenuContainer);
      this.newsContainer.add(titleBar);
      this.newsContainer.add(this.newsView);
      this.newsWindow.add(this.newsContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.newsWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showNews: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.newsWindow.open({
              fullscreen: false
            });
          } else {
            return _this.newsWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showNews();
    };

    return NewsView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.NewsView = NewsView;

  ProfileView = (function(_super) {

    __extends(ProfileView, _super);

    ProfileView.name = 'ProfileView';

    ProfileView.prototype.defaults = {};

    function ProfileView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    ProfileView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.profileWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.profileContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.profileScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.profileView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.profileLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.profileView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Profile",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.profileContainer.add(toolsMenuContainer);
      this.profileContainer.add(titleBar);
      this.profileContainer.add(this.profileView);
      this.profileWindow.add(this.profileContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.profileWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showProfile: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.profileWindow.open({
              fullscreen: false
            });
          } else {
            return _this.profileWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showProfile();
    };

    return ProfileView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.ProfileView = ProfileView;

  RulesView = (function(_super) {

    __extends(RulesView, _super);

    RulesView.name = 'RulesView';

    RulesView.prototype.defaults = {};

    function RulesView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    RulesView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.rulesWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.rulesContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.rulesScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.rulesView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.rulesLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.rulesView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Rules",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.rulesContainer.add(toolsMenuContainer);
      this.rulesContainer.add(titleBar);
      this.rulesContainer.add(this.rulesView);
      this.rulesWindow.add(this.rulesContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.rulesWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showRules: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.rulesWindow.open({
              fullscreen: false
            });
          } else {
            return _this.rulesWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showRules();
    };

    return RulesView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.RulesView = RulesView;

  SettingsView = (function(_super) {

    __extends(SettingsView, _super);

    SettingsView.name = 'SettingsView';

    SettingsView.prototype.defaults = {};

    function SettingsView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    SettingsView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.settingsWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.settingsContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.settingsScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.settingsView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.settingsLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.settingsView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Settings",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.settingsContainer.add(toolsMenuContainer);
      this.settingsContainer.add(titleBar);
      this.settingsContainer.add(this.settingsView);
      this.settingsWindow.add(this.settingsContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.settingsWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showSettings: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.settingsWindow.open({
              fullscreen: false
            });
          } else {
            return _this.settingsWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showSettings();
    };

    return SettingsView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.SettingsView = SettingsView;

  TeamsView = (function(_super) {

    __extends(TeamsView, _super);

    TeamsView.name = 'TeamsView';

    TeamsView.prototype.defaults = {};

    function TeamsView() {
      _.extend(this, this.defaults);
      this.setUp();
    }

    TeamsView.prototype.setUp = function() {
      var toolbarLabel,
        _this = this;
      this.teamsWindow = Ti.UI.createWindow({
        orientationModes: [Ti.UI.PORTRAIT]
      });
      this.teamsContainer = Ti.UI.createView({
        backgroundColor: "#000000",
        top: 0,
        left: 0,
        height: this.getPlatformHeight(),
        width: this.getPlatformWidth()
      });
      this.teamsScrollView = Ti.UI.createScrollView({
        contentWidth: "auto",
        contentHeight: "auto",
        minZoomScale: 0,
        maxZoomScale: 10,
        backgroundColor: "transparent",
        top: 12,
        left: 12,
        height: 390,
        width: 295,
        showPagingControl: true
      });
      this.teamsView = Ti.UI.createView({
        height: 243,
        width: 243,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.comingSoon = Ti.UI.createView({
        backgroundImage: "images/match/layout/overlay-comingsoon.png",
        backgroundColor: "transparent",
        top: 20,
        height: 243,
        width: 243
      });
      this.teamsLabel = Ti.UI.createLabel({
        text: "test test test test ",
        top: 0,
        left: 0,
        color: "#ffffff",
        height: 1500,
        width: 285,
        font: {
          fontSize: 13,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      this.teamsView.add(this.comingSoon);
      toolbarLabel = Ti.UI.createLabel({
        text: "Teams",
        color: "#ffffff",
        shadowColor: "#000000",
        textAlign: "center",
        font: {
          fontSize: 20,
          fontWeight: "bold",
          fontFamily: "HelveticaNeue-Bold"
        }
      });
      titleBar.add(dashboardButton);
      titleBar.add(toolbarLabel);
      this.teamsContainer.add(toolsMenuContainer);
      this.teamsContainer.add(titleBar);
      this.teamsContainer.add(this.teamsView);
      this.teamsWindow.add(this.teamsContainer);
      this.dashboardButton.addEventListener("click", function() {
        this.teamsWindow.close();
        return this.dashboardWindow.show();
      });
      ({
        showTeams: function() {
          if (Ti.Platform.name !== "android") {
            Ti.UI.iPhone.showStatusBar();
            return _this.teamsWindow.open({
              fullscreen: false
            });
          } else {
            return _this.teamsWindow.open({
              fullscreen: true
            });
          }
        }
      });
      return showTeams();
    };

    return TeamsView;

  })($CS.Views.Dashboard);

  $CS.Views.Dashboard.TeamsView = TeamsView;

  $CS.Views.Login.createLoginWindow = function(options) {
    var button, window;
    if (options == null) {
      options = {};
    }
    window = Ti.UI.createWindow(options);
    button = Titanium.UI.createButton({
      title: 'I am a Button',
      height: 40,
      width: 200,
      top: 10
    });
    window.add(button);
    say = function(msg) {
      return alert(msg);
    };
    button.addEventListener('click', function() {
      return say('hello');
    });
    return window;
  };

  PostViewController = (function() {

    PostViewController.name = 'PostViewController';

    function PostViewController(post) {
      var data;
      this.post = post;
      Ti.UI.setBackgroundColor("#fff");
      this.postsWindow = Ti.UI.createWindow({
        title: 'Post',
        id: 'postWindow',
        top: 0,
        orientationModes: $CS.Helpers.Application.createOrientiationModes,
        exitOnClose: true
      });
      data = [
        {
          title: "Row 1"
        }, {
          title: "Row 2"
        }
      ];
      this.tableView = Titanium.UI.createTableView({
        data: data
      });
      data = [];
      data.push(this.createTitleRow());
      this.tableView.data = data;
      this.postsWindow.add(this.tableView);
      this.postsWindow.open();
    }

    PostViewController.prototype.createTitleRow = function() {
      var row,
        _this = this;
      row = Ti.UI.createTableViewRow({
        title: this.post.get('name')
      });
      this.post.bind('change:name', function(e) {
        return row.title = _this.post.get('name');
      });
      return row;
    };

    return PostViewController;

  })();

  $CS.Views.PostView = PostViewController;

  PostsViewController = (function() {

    PostsViewController.name = 'PostsViewController';

    function PostsViewController() {
      var _this = this;
      Ti.UI.setBackgroundColor("#fff");
      this.postsWindow = Ti.UI.createWindow({
        title: 'Posts',
        id: 'postsWindow',
        top: 0,
        orientationModes: $CS.Helpers.Application.createOrientiationModes
      });
      this.data = [
        {
          title: "Row 1"
        }, {
          title: "Row 2"
        }
      ];
      this.tableView = Titanium.UI.createTableView({
        data: this.data
      });
      every(5000, function() {
        return _this.reload();
      });
    }

    PostsViewController.prototype.reload = function() {
      var _this = this;
      this.posts = new $CS.Models.Posts();
      return this.posts.fetch({
        success: function() {
          return _this.prepareData(_this.posts.models);
        },
        error: function(e) {
          return console.error(JSON.stringify(e));
        }
      });
    };

    PostsViewController.prototype.prepareData = function(models) {
      this.tableView.data = _.map(models, function(model) {
        return {
          title: model.get('name'),
          hasChild: true
        };
      });
      this.postsWindow.add(this.tableView);
      return this.postsWindow.open();
    };

    PostsViewController.prototype.createTitleRow = function(model) {
      var row,
        _this = this;
      row = Ti.UI.createTableViewRow({
        title: model.get('name')
      });
      model.on('change:name', function(e) {
        return row.title = model.get('name');
      });
      return row;
    };

    return PostsViewController;

  })();

  $CS.Views.PostsView = PostsViewController;

  $CS.Views.Sample.createMainWindow = function(options) {
    var window;
    window = Ti.UI.createWindow(options);
    return window;
  };

  $CS.Views.Settings.createMainWindow = function(options) {
    var window;
    window = Ti.UI.createWindow(options);
    return window;
  };

}).call(this);
