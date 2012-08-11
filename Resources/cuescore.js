(function() {
  var API, AppSync, DashboardController, EightBall, Game, League, LeagueMatch, Match, NineBall, Player, Post, PostViewController, Posts, PostsController, PostsViewController, PracticeMatch, Rank, Team, Template, TournamentMatch, Type, after, console, every, say,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $CS.App = {
    init: function() {
      var gameModel, postsController;
      console.log("test");
      gameModel = new $CS.Models.Game;
      return postsController = new $CS.Controllers.PostsController;
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
      var data, message, uri, xhr, _ref, _ref1, _ref2, _ref3;
      if (authenticated == null) {
        authenticated = true;
      }
      if ((_ref = options.method) == null) {
        options.method = 'GET';
      }
      if ((_ref1 = options.query) == null) {
        options.query = {};
      }
      if ((_ref2 = options.success) == null) {
        options.success = function() {
          return Ti.API.info;
        };
      }
      if ((_ref3 = options.error) == null) {
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

  Backbone.setDomLibrary(TiQuery);

  Template = (function(_super) {

    __extends(Template, _super);

    function Template(options) {
      this._configure(options || {});
      this.initialize.apply(this, arguments);
      this.delegateEvents();
    }

    Template.prototype.delegateEvents = function() {};

    return Template;

  })(Backbone.View);

  $CS.Window.Main = (function(_super) {

    __extends(Main, _super);

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

    function Game() {
      return Game.__super__.constructor.apply(this, arguments);
    }

    Game.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    Game.prototype.initialize = function() {
      console.log("Welcome to this world");
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    Game.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Game;

  })(Backbone.Model);

  $CS.Models.Game = Game;

  EightBall = (function(_super) {
    var getCurrentPlayerRemainingTimeouts;

    __extends(EightBall, _super);

    function EightBall() {
      return EightBall.__super__.constructor.apply(this, arguments);
    }

    EightBall.prototype.defaults = {
      stripes: 1,
      solids: 2,
      innings: 0,
      match_ended_callback: {},
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
      player: [
        {
          one: {
            eight_ball: null,
            eight_on_snap: false,
            break_and_run: false,
            timeouts_taken: 0,
            timeouts_allowed: null,
            callback: typeof addToPlayerOne !== "undefined" && addToPlayerOne !== null,
            ball_type: null,
            has_won: false,
            currently_up: false,
            score: []
          },
          two: {
            eight_ball: null,
            eight_on_snap: false,
            break_and_run: false,
            timeouts_taken: 0,
            timeouts_allowed: null,
            callback: typeof addToPlayerOne !== "undefined" && addToPlayerOne !== null,
            ball_type: null,
            has_won: false,
            currently_up: false,
            score: []
          }
        }
      ]
    };

    EightBall.prototype.initialize = function(addToPlayerOne, addToPlayerTwo, callback) {
      return this.match_ended_callback = callback != null;
    };

    EightBall.prototype.getCurrentlyUpPlayer = function() {
      if (this.player['one'].callback().isCurrentlyUp === true) {
        return this.player['one'].callback();
      }
      return this.player['two'].callback();
    };

    EightBall.prototype.getWinningPlayerName = function() {
      if (this.player['one'].has_won === true) {
        return this.player['one'].callback().getFirstNameWithInitials();
      } else {
        if (this.player['two'].has_won === true) {
          return this.player['two'].callback().getFirstNameWithInitials();
        }
      }
    };

    EightBall.prototype.getBallsHitInByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player['one'].ball_type === this.stripes) {
          return this.balls_hit_in.stripes.concat(this.player['one'].eight_ball);
        } else {
          if (this.player['one'].ball_type === this.solids) {
            return this.balls_hit_in.solids.concat(this.player['one'].eight_ball);
          }
        }
        [];
      }
      if (playerNum === 2) {
        if (this.player['two'].ball_type === this.stripes) {
          return this.balls_hit_in.stripes.concat(this.player['two'].eight_ball);
        } else {
          if (this.player['two'].ball_type === this.solids) {
            return this.balls_hit_in.solids.concat(this.player['two'].eight_ball);
          }
        }
        return [];
      }
    };

    EightBall.prototype.getGameScore = function() {
      return this.getBallsHitInByPlayer(1).length + "-" + this.getBallsHitInByPlayer(2).length;
    };

    EightBall.prototype.getBallsHitIn = function() {
      return this.balls_hit_in.solids.concat(this.balls_hit_in.stripes.concat(this.player['two'].eight_ball.concat(this.player['one'].eight_ball)));
    };

    getCurrentPlayerRemainingTimeouts = function() {
      if (this.player['one'].callback().currently_up === true) {
        return (this.player['one'].callback().timeouts_allowed - this.player['one'].timeouts_taken).toString();
      }
      return (this.player['two'].callback().timeouts_allowed - this.player['two'].timeouts_taken).toString();
    };

    EightBall.prototype.setPlayerWon = function(playerNum) {
      if (playerNum === 1) {
        this.player['one'].has_won = true;
        return this.player['one'].callback().games_won += 1;
      } else if (playerNum === 2) {
        this.player['two'].has_won = true;
        return this.player['two'].callback().games_won += 1;
      }
    };

    EightBall.prototype.setEightOnSnapByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player['one'].eight_on_snap !== true) {
          this.player['one'].callback().addToEightOnSnaps(1);
        }
        return this.player['one'].eight_on_snap = true;
      } else if (playerNum === 2) {
        if (this.player['two'].eight_on_snap !== true) {
          this.player['two'].callback().addToEightOnSnaps(1);
        }
        return this.player['two'].eight_on_snap = true;
      }
    };

    EightBall.prototype.setBreakAndRunByPlayer = function(playerNum) {
      if (playerNum === 1) {
        if (this.player['one'].break_and_run !== true) {
          this.player['one'].callback().addOneToBreakAndRuns();
        }
        return this.player['one'].break_and_run = true;
      } else if (playerNum === 2) {
        if (this.player['two'].break_and_run !== true) {
          this.player['two'].callback().addOneToBreakAndRuns();
        }
        return this.player['two'].break_and_run = true;
      }
    };

    EightBall.prototype.setBallTypeByPlayer = function(playerNum, type) {
      if (playerNum === 1 && type === "stripes") {
        this.player['one'].ball_type = this.stripes;
        this.player['two'].ball_type = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "stripes") {
        this.player['two'].ball_type = this.stripes;
        this.player['one'].ball_type = this.solids;
        return this.checkForWinner();
      } else if (playerNum === 1 && type === "solids") {
        this.player['one'].ball_type = this.solids;
        this.player['two'].ball_type = this.stripes;
        return this.checkForWinner();
      } else if (playerNum === 2 && type === "solids") {
        this.player['two'].ball_type = this.solids;
        this.player['one'].ball_type = this.stripes;
        return this.checkForWinner();
      }
    };

    EightBall.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    EightBall.prototype.hitSafety = function() {
      this.getCurrentlyUpPlayer().addOneToSafeties();
      return this.nextPlayerIsUp();
    };

    EightBall.prototype.hitScratchOnEight = function() {
      this.scratch_on_eight = true;
      this.ended = true;
      if (this.player['one'].callback().currently_up === true) {
        this.player['two'].has_won = true;
        this.player['one'].callback().currently_up = false;
        this.player['two'].callback().currently_up = true;
      } else {
        this.player['one'].has_won = true;
        this.player['two'].callback().currently_up = false;
        this.player['one'].callback().currently_up = true;
      }
      return this.match_ended_callback();
    };

    EightBall.prototype.addToNumberOfInnings = function(num) {
      return this.number_of_innings += num;
    };

    EightBall.prototype.takeTimeout = function() {
      if (this.getCurrentPlayerRemainingTimeouts() > 0) {
        if (this.player['one'].callback().currently_up === true) {
          return this.player['one'].timeouts_taken += 1;
        } else {
          return this.player['two'].timeouts_taken += 1;
        }
      }
    };

    EightBall.prototype.breakIsOver = function() {
      return this.on_break = false;
    };

    EightBall.prototype.game_end = function() {
      return this.ended = true;
    };

    EightBall.prototype.checkForWinner = function() {
      if (this.getBallsHitIn().exists(8)) {
        this.ended = true;
      }
      if (this.ended === true) {
        if (this.breakingPlayerStillHitting === true && (this.solidBallsHitIn.length === 7 || this.stripedBallsHitIn.length === 7)) {
          if (this.player['one'].callback().currently_up === true) {
            this.setBreakAndRunByPlayer(1);
            if (this.balls_hit_in.solids.length === 7) {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            } else {
              this.player['one'].ball_type = this.stripes;
              this.player['two'].ball_type = this.solids;
            }
          } else if (this.player['two'].callback().currently_up === true) {
            this.setBreakAndRunByPlayer(2);
            if (this.balls_hit_in.solids.length === 7) {
              this.player['two'].ball_type = this.solids;
              this.player['one'].ball_type = this.stripes;
            } else {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            }
          }
        }
        if (this.player['one'].eightBall.exists(8) && this.on_break === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8) {
            this.setPlayerWon(2);
          } else {
            this.setPlayerWon(1);
          }
        } else if (this.player['two'].eightBall.exists(8) && this.on_break === false) {
          if (this.getBallsHitInByPlayer(1).length !== 8) {
            this.setPlayerWon(1);
          } else {
            this.setPlayerWon(2);
          }
        } else {
          if (this.player['one'].callback().currently_up === true) {
            this.setPlayerWon(1);
          } else {
            if (this.player['two'].callback().currently_up === true) {
              this.setPlayerWon(2);
            }
          }
        }
        return this.match_ended_callback();
      }
    };

    EightBall.prototype.scoreBall = function(ballNumber) {
      if (!this.getBallsHitIn().exists(ballNumber)) {
        this.last_ball_hit_in = ballNumber;
        if (ballNumber > 0 && ballNumber < 8) {
          this.balls_hit_in.solids.push(ballNumber);
        } else if (ballNumber > 8 && ballNumber < 16) {
          this.balls_hit_in.stripes.push(ballNumber);
        } else {
          if (this.player['one'].callback().currently_up === true) {
            this.player['one'].eight_ball.push(ballNumber);
          } else {
            if (this.player['two'].callback().currently_up === true) {
              this.player['two'].eight_ball.push(ballNumber);
            }
          }
          if (this.on_break === true) {
            if (this.balls_hit_in.solids.length !== 7 && this.balls_hit_in.stripes.length !== 7) {
              if (this.player['one'].callback().currently_up === true) {
                this.setEightOnSnapByPlayer(1);
              } else {
                if (this.player['two'].callback().currently_up === true) {
                  this.setEightOnSnapByPlayer(2);
                }
              }
            }
          } else {
            if (this.balls_hit_in.solids.length !== 7 && this.balls_hit_in.stripes.length !== 7) {
              this.early_eight = true;
              if (this.player['one'].callback().currently_up === true) {
                this.player['one'].callback().currently_up = false;
                this.player['two'].callback().currently_up = true;
              } else if (this.player['two'].callback().currently_up === true) {
                this.player['one'].callback().currently_up = true;
                this.player['two'].callback().currently_up = false;
              }
            }
          }
        }
        return this.checkForWinner();
      }
    };

    EightBall.prototype.nextPlayerIsUp = function() {
      if (this.on_break !== true || ((this.player['two'].callback().currently_up === true || this.player['one'].callback().currently_up === true) && this.getBallsHitIn().length === 0)) {
        if (this.player['one'].callback().currently_up === true) {
          this.player['two'].callback().currently_up = true;
          this.player['one'].callback().currently_up = false;
          if (this.player['one'].ball_type == null) {
            if (this.balls_hit_in.solids.length > 0 && this.balls_hit_in.stripes.length === 0) {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            } else if (this.balls_hit_in.solids.length === 0 && this.balls_hit_in.stripes.length > 0) {
              this.player['one'].ball_type = this.stripes;
              this.player['two'].ball_type = this.solids;
            }
          }
        } else if (this.PlayerTwoCallback().CurrentlyUp === true) {
          this.player['two'].callback().currently_up = false;
          this.player['one'].callback().currently_up = true;
          this.addToNumberOfInnings(1);
          if (this.player['two'].ball_type == null) {
            if (this.balls_hit_in.solids.length === 0 && this.balls_hit_in.stripes.length > 0) {
              this.player['one'].ball_type = this.solids;
              this.player['two'].ball_type = this.stripes;
            } else if (this.balls_hit_in.solids.length > 0 && this.balls_hit_in.stripes.length === 0) {
              this.player['one'].ball_type = this.stripes;
              this.player['two'].ball_type = this.solids;
            }
          }
        } else {
          this.player['one'].callback().currently_up = true;
        }
        this.breaking_player_still_shooting = false;
      }
      return this.on_break = false;
    };

    EightBall.prototype.toJSON = function() {
      return {
        PlayerOneTimeoutsTaken: this.player['one'].timeouts_taken,
        PlayerTwoTimeoutsTaken: this.player['two'].timeouts_taken,
        PlayerOneEightOnSnap: this.player['one'].eight_on_snap,
        PlayerOneBreakAndRun: this.player['one'].break_and_run,
        PlayerTwoEightOnSnap: this.player['two'].eight_on_snap,
        PlayerTwoBreakAndRun: this.player['two'].break_and_run,
        PlayerOneBallType: this.player['one'].ball_type,
        PlayerTwoBallType: this.player['two'].ball_type,
        PlayerOneEightBall: this.player['one'].eight_ball,
        PlayerTwoEightBall: this.player['two'].eight_ball,
        PlayerOneWon: this.player['one'].has_won,
        PlayerTwoWon: this.player['two'].has_won,
        NumberOfInnings: this.number_of_innings,
        EarlyEight: this.early_eight,
        ScratchOnEight: this.scratch_on_eight,
        BreakingPlayerStillShooting: this.breaking_player_still_shooting,
        StripedBallsHitIn: this.balls_hit_in.stripes,
        SolidBallsHitIn: this.balls_hit_in.solids,
        LastBallHitIn: this.last_ball_hit_in,
        OnBreak: this.on_break,
        Ended: this.ended
      };
    };

    EightBall.prototype.fromJSON = function(gameJSON) {
      this.player['one'].timeouts_taken = gameJSON.PlayerOneTimeoutsTaken;
      this.player['two'].timeouts_taken = gameJSON.PlayerTwoTimeoutsTaken;
      this.player['one'].eight_on_snap = gameJSON.PlayerOneEightOnSnap;
      this.player['one'].break_and_run = gameJSON.PlayerOneBreakAndRun;
      this.player['two'].eight_on_snap = gameJSON.PlayerTwoEightOnSnap;
      this.player['two'].break_and_run = gameJSON.PlayerTwoBreakAndRun;
      this.player['one'].ball_type = gameJSON.PlayerOneBallType;
      this.player['two'].ball_type = gameJSON.PlayerTwoBallType;
      this.player['one'].eight_ball = gameJSON.PlayerOneEightBall;
      this.player['two'].eight_ball = gameJSON.PlayerTwoEightBall;
      this.player['one'].has_won = gameJSON.PlayerOneWon;
      this.player['two'].has_won = gameJSON.PlayerTwoWon;
      this.number_of_innints = gameJSON.NumberOfInnings;
      this.breaking_player_still_shooting = gameJSON.BreakingPlayerStillHitting;
      this.balls_hit_in.solids = gameJSON.SolidBallsHitIn;
      this.balls_hit_in.stripes = gameJSON.StripedBallsHitIn;
      this.last_ball_hit_in = gameJSON.LastBallHitIn;
      this.on_break = gameJSON.OnBreak;
      return this.ended = gameJSON.Ended;
    };

    return EightBall;

  })(Game);

  $CS.Models.Game.EightBall = EightBall;

  NineBall = (function(_super) {

    __extends(NineBall, _super);

    function NineBall() {
      return NineBall.__super__.constructor.apply(this, arguments);
    }

    NineBall.prototype.defaults = {};

    NineBall.prototype.initialize = function(addToPlayerOne, addToPlayerTwo, callback) {
      return console.log(this);
    };

    return NineBall;

  })(Game);

  $CS.Models.Game.NineBall = NineBall;

  League = (function(_super) {

    __extends(League, _super);

    function League() {
      return League.__super__.constructor.apply(this, arguments);
    }

    League.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    League.prototype.initialize = function() {
      console.log("Welcome to this world");
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    League.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return League;

  })(Backbone.Model);

  $CS.Models.League = League;

  Match = (function(_super) {

    __extends(Match, _super);

    function Match() {
      return Match.__super__.constructor.apply(this, arguments);
    }

    Match.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    Match.prototype.initialize = function() {
      console.log("Welcome to this world");
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    Match.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Match;

  })(Backbone.Model);

  $CS.Models.Match = Match;

  EightBall = (function(_super) {

    __extends(EightBall, _super);

    function EightBall() {
      return EightBall.__super__.constructor.apply(this, arguments);
    }

    EightBall.prototype.defaults = {
      player: [
        {
          one: {},
          two: {}
        }
      ],
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

    EightBall.prototype.initialize = function(player1, player2, player1Rank, player2Rank, player1Number, player2Number, player1TeamNumber, player2TeamNumber) {
      player['one'] = new Player('EightBall', player1, player1Rank, player1Number, player1TeamNumber);
      player['two'] = new Player('EightBall', player2, player2Rank, player2Number, player2TeamNumber);
      if ((this.player['one'].rank != null) && (this.player['two'].rank != null)) {
        this.player['one'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(player1Rank, player2Rank);
        this.player['two'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(player2Rank, player1Rank);
      }
      return this.current_game = this.getNewGame();
    };

    EightBall.prototype.getNewGame = function() {
      return new $CS.Models.Game.EightBall(function() {
        return this.player['one'];
      }, function() {
        return this.player['two'];
      }, function() {
        if (this.getRemainingGamesNeededToWinByPlayer(1) === 0) {
          this.player_one_won = true;
          return this.ended = true;
        } else if (this.getRemainingGamesNeededToWinByPlayer(2) === 0) {
          this.player_two_won = true;
          return this.ended = true;
        }
      });
    };

    EightBall.prototype.getTotalInnings = function() {
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

    EightBall.prototype.getTotalSafeties = function() {
      return this.player['one'].getSafeties() + " to " + this.player['two'].getSafeties();
    };

    EightBall.prototype.getCurrentGameNumber = function() {
      return (this.completed_games.length + 1).toString();
    };

    EightBall.prototype.getMatchPointsByTeamNumber = function(teamNumber) {
      if (this.player['one'].team_number === teamNumber) {
        return this.getMatchPointsByPlayer(1);
      } else {
        if (this.player['two'].team_number === teamNumber) {
          return this.getMatchPointsByPlayer(2);
        }
      }
      return 0;
    };

    EightBall.prototype.getWinningPlayer = function() {
      if ((this.getGamesWonByPlayer(1) / this.player['one'].games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player['two'].games_needed_to_win)) {
        return this.player['one'];
      }
      return this.player['two'];
    };

    EightBall.prototype.getRemainingGamesNeededToWinByPlayer = function(playerNum) {
      if (playerNum === 1) {
        return (this.player['one'].games_needed_to_win - this.getGamesWonByPlayer(1)).toString();
      } else if (playerNum === 2) {
        return (this.player['two'].games_needed_to_win - this.getGamesWonByPlayer(2)).toString();
      }
    };

    EightBall.prototype.getGamesWonByPlayer = function(playerNum) {
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
        while (i <= (this.CompletedGames.length - 1)) {
          if (this.CompletedGames[i].player['two'].has_won === true) {
            gamesWon = gamesWon + 1;
          }
          i++;
        }
      }
      return gamesWon;
    };

    EightBall.prototype.getMatchPointsByPlayer = function(playerNum) {
      if ((this.getGamesWonByPlayer(1) / this.player['one'].games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player['two'].games_needed_to_win)) {
        return 1;
      }
      return 0;
    };

    EightBall.prototype.getMatchPoints = function() {
      if (this.getMatchPointsByPlayer(1) === this.getMatchPointsByPlayer(2)) {
        return "TIE";
      }
      return this.getMatchPointsByPlayer(1) + "-" + this.getMatchPointsByPlayer(2);
    };

    EightBall.prototype.setSuddenDeathMode = function() {
      this.sudden_death = true;
      this.player['one'].games_needed_to_win = 1;
      return this.player['two'].games_needed_to_win = 1;
    };

    EightBall.prototype.scoreNumberedBall = function(ballNumber) {
      this.are_players_switching = false;
      this.current_game.scoreBall(ballNumber);
      if (this.isPlayerWinning(1) === true) {
        this.player_number_winning = 1;
      } else {
        this.player_number_winning = 2;
      }
      return this.checkForWin();
    };

    EightBall.prototype.shotMissed = function() {
      this.current_game.nextPlayerIsUp();
      if (this.current_game.breaking_player_still_shooting === false) {
        return this.are_players_switching = true;
      }
    };

    EightBall.prototype.hitSafety = function() {
      return this.current_game.hitSafety();
    };

    EightBall.prototype.checkForWin = function() {};

    EightBall.prototype.startNewGame = function() {
      if (this.current_game.ended === true) {
        this.completed_games.push(this.current_game);
        return this.current_game = this.getNewGame();
      }
    };

    EightBall.prototype.resetPlayerRankStats = function() {
      this.player['one'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(this.player['one'].rank, this.player['two'].rank);
      this.player['two'].games_needed_to_win = new $CS.Models.Ranks.EightBall().getGamesNeedToWin(this.player['two'].rank, this.player['one'].rank);
      this.player['one'].resetPlayerRankStats();
      return this.player['two'].resetPlayerRankStats();
    };

    EightBall.prototype.isPlayerWinning = function(playerNum) {
      if (playerNum === 1) {
        if ((this.getGamesWonByPlayer(1) / this.player['one'].games_needed_to_win) > (this.getGamesWonByPlayer(2) / this.player['two'].games_needed_to_win)) {
          return true;
        }
        return false;
      } else if (playerNum === 2) {
        if ((this.getGamesWonByPlayer(1) / this.player['one'].games_needed_to_win) < (this.getGamesWonByPlayer(2) / this.player['two'].games_needed_to_win)) {
          return true;
        }
        return false;
      }
    };

    EightBall.prototype.toJSON = function() {
      return {
        player_one: this.player['one'].toJSON(),
        player_two: this.player['two'].toJSON(),
        player_one_games_won: this.getGamesWonByPlayer(1),
        player_two_games_won: this.getGamesWonByPlayer(2),
        current_game: this.current_game.toJSON(),
        completed_games: this.completedGamesToJSON(),
        sudden_death: this.sudden_death,
        forfeit: this.forfeit,
        ended: this.ended,
        original_id: this.original_id,
        league_match_id: this.league_match_id
      };
    };

    EightBall.prototype.completedGamesToJSON = function() {
      var arrayToReturn, i;
      arrayToReturn = [];
      i = 0;
      while (i <= this.completed_games.length - 1) {
        arrayToReturn[i] = this.completed_games[i].toJSON();
        i++;
      }
      return arrayToReturn;
    };

    EightBall.prototype.fromJSON = function(json) {
      var currentGame;
      this.player['one'] = this.playerFromJSON(json.player_one);
      this.player['two'] = this.playerFromJSON(json.player_two);
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

    EightBall.prototype.playerFromJSON = function(json) {
      var player;
      player = new EightBallPlayer();
      player.fromJSON(new function() {
        return json;
      });
      return player;
    };

    EightBall.prototype.completedGamesFromJSON = function(json) {
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

    return EightBall;

  })(Game);

  $CS.Models.Game.EightBall = EightBall;

  Type = (function(_super) {

    __extends(Type, _super);

    function Type() {
      return Type.__super__.constructor.apply(this, arguments);
    }

    Type.prototype.defaults = {};

    Type.prototype.initialize = function() {
      return console.log(this);
    };

    return Type;

  })(Match);

  $CS.Models.Match.Type = Type;

  LeagueMatch = (function(_super) {

    __extends(LeagueMatch, _super);

    function LeagueMatch() {
      return LeagueMatch.__super__.constructor.apply(this, arguments);
    }

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

    LeagueMatch.prototype.initialize = function(GameType, HomeTeamNumber, AwayTeamNumber, HomeTeamName, AwayTeamName, StartTime, TableType) {
      this.game_type = "EightBall";
      this.home_team.number = HomeTeamNumber != null;
      this.home_team.name = HomeTeamName != null;
      this.away_team.number = AwayTeamNumber != null;
      this.away_team.name = AwayTeamName != null;
      this.start_time = StartTime != null;
      this.table_type = TableType != null;
      return DataService.saveLeagueMatch(this, function(id) {
        return this.league_match_id = id;
      });
    };

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

  })(Type);

  $CS.Models.Match.Type.LeagueMatch = LeagueMatch;

  PracticeMatch = (function(_super) {

    __extends(PracticeMatch, _super);

    function PracticeMatch() {
      return PracticeMatch.__super__.constructor.apply(this, arguments);
    }

    PracticeMatch.prototype.defaults = {};

    PracticeMatch.prototype.initialize = function() {
      return console.log(this);
    };

    return PracticeMatch;

  })(Type);

  $CS.Models.Match.Type.PracticeMatch = PracticeMatch;

  TournamentMatch = (function(_super) {

    __extends(TournamentMatch, _super);

    function TournamentMatch() {
      return TournamentMatch.__super__.constructor.apply(this, arguments);
    }

    TournamentMatch.prototype.defaults = {};

    TournamentMatch.prototype.initialize = function() {
      return console.log(this);
    };

    return TournamentMatch;

  })(Type);

  $CS.Models.Match.Type.TournamentMatch = TournamentMatch;

  Player = (function(_super) {

    __extends(Player, _super);

    function Player() {
      return Player.__super__.constructor.apply(this, arguments);
    }

    Player.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    Player.prototype.initialize = function() {
      console.log("Welcome to this world");
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    Player.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Player;

  })(Backbone.Model);

  $CS.Models.Player = Player;

  EightBall = (function(_super) {

    __extends(EightBall, _super);

    function EightBall() {
      return EightBall.__super__.constructor.apply(this, arguments);
    }

    EightBall.prototype.defaults = {
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

    EightBall.prototype.initialize = function(name, rank, number, teamNumber) {
      this.name = name != null;
      this.rank = rank != null;
      this.number = number != null;
      this.team_number = teamNumber != null;
      return this.timeouts_allowed = $CS.Models.Rank.EightBall().getTimeouts(rank != null);
    };

    EightBall.prototype.getGamesNeededToWin = function() {
      return this.games_needed_to_win.toString();
    };

    EightBall.prototype.getRemainingBallCount = function() {
      return (this.ball_count - this.score).toString();
    };

    EightBall.prototype.getFirstNameWithInitials = function() {
      var nameToReturn, spaceIndex;
      spaceIndex = this.name.indexOf(" ");
      if (spaceIndex === -1) {
        return this.name;
      }
      nameToReturn = this.name.substr(0, spaceIndex);
      return nameToReturn + " " + this.name[spaceIndex + 1] + ".";
    };

    EightBall.prototype.getSafeties = function() {
      return this.safeties.toString();
    };

    EightBall.prototype.getGamesWon = function() {
      return this.games_won.toString();
    };

    EightBall.prototype.getRatioScore = function() {
      return this.score / this.ball_count;
    };

    EightBall.prototype.getEightOnSnaps = function() {
      return this.eight_on_snaps.toString();
    };

    EightBall.prototype.getBreakAndRuns = function() {
      return this.break_and_runs.toString();
    };

    EightBall.prototype.resetPlayerRankStats = function() {
      return this.timeouts_allowed = $CS.Models.Rank.EightBall().getTimeouts(this.rank);
    };

    EightBall.prototype.addOneToGamesWon = function() {
      return this.games_won += 1;
    };

    EightBall.prototype.addOneToSafeties = function() {
      return this.safeties += 1;
    };

    EightBall.prototype.hasWon = function() {
      return this.score >= this.ball_count;
    };

    EightBall.prototype.addOneToEightOnSnaps = function() {
      return this.eight_on_snaps += 1;
    };

    EightBall.prototype.addOneToBreakAndRuns = function() {
      return this.break_and_runs += 1;
    };

    EightBall.prototype.toJSON = function() {
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

    EightBall.prototype.fromJSON = function(playerJSON) {
      this.name = playerJSON.name;
      this.tank = playerJSON.rank;
      this.number = playerJSON.number;
      this.team_number = playerJSON.team_number;
      this.games_won = playerJSON.games_won;
      this.safeties = playerJSON.safeties;
      this.eight_on_snaps = playerJSON.eight_on_snaps;
      this.break_and_runs = playerJSON.break_and_runs;
      this.currently_up = playerJSON.currently_up;
      return this.resetPlayerRankStats();
    };

    return EightBall;

  })(Player);

  $CS.Models.Player.EightBall = EightBall;

  NineBall = (function(_super) {

    __extends(NineBall, _super);

    function NineBall() {
      return NineBall.__super__.constructor.apply(this, arguments);
    }

    NineBall.prototype.defaults = {};

    NineBall.prototype.initialize = function(name, rank, number, teamNumber) {
      return console.log(this);
    };

    return NineBall;

  })(Player);

  $CS.Models.Player.NineBall = NineBall;

  Post = (function(_super) {

    __extends(Post, _super);

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

    function Rank() {
      return Rank.__super__.constructor.apply(this, arguments);
    }

    Rank.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    Rank.prototype.initialize = function() {
      console.log("Welcome to this world");
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    Rank.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

    return Rank;

  })(Backbone.Model);

  $CS.Models.Rank = Rank;

  EightBall = (function(_super) {

    __extends(EightBall, _super);

    function EightBall() {
      return EightBall.__super__.constructor.apply(this, arguments);
    }

    EightBall.prototype.defaults = {
      games_to_win: []
    };

    EightBall.prototype.initialize = function() {
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

    EightBall.prototype.getGamesNeedToWin = function(myRank, opponentRank) {
      var gamesNeeded;
      if (myRank > 1 && myRank < 8 && opponentRank > 1 && opponentRank < 8) {
        gamesNeeded = this.games_to_win[myRank][opponentRank];
        return gamesNeeded;
      }
      return 0;
    };

    EightBall.prototype.getTimeouts = function(rank) {
      if (rank < 4) {
        return 2;
      } else {
        if (rank >= 4 && rank <= 9) {
          return 1;
        }
      }
      return 0;
    };

    return EightBall;

  })(Rank);

  $CS.Models.Rank.EightBall = EightBall;

  NineBall = (function(_super) {

    __extends(NineBall, _super);

    function NineBall() {
      return NineBall.__super__.constructor.apply(this, arguments);
    }

    NineBall.prototype.defaults = {
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

    NineBall.prototype.initialize = function() {
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

    NineBall.prototype.getBallCount = function(rank) {
      return parseInt(this.ball_counts[rank], 10);
    };

    NineBall.prototype.getLosingPlayersMatchPoints = function(loserRank, loserScore) {
      var losingMatchPoints;
      losingMatchPoints = this.losersMatchPoints[loserRank][loserScore];
      return losingMatchPoints;
    };

    NineBall.prototype.getWinningPlayersMatchPoints = function(loserRank, loserScore) {
      var losingMatchPoints, winningMatchPoints;
      losingMatchPoints = this.losersMatchPoints[loserRank][loserScore];
      winningMatchPoints = 20 - this.losersMatchPoints[loserRank][loserScore];
      return winningMatchPoints;
    };

    NineBall.prototype.getTimeouts = function(rank) {
      if (rank < 4) {
        return 2;
      } else {
        if (rank >= 4 && rank <= 9) {
          return 1;
        }
      }
      return 0;
    };

    return NineBall;

  })(Rank);

  $CS.Models.Rank.NineBall = NineBall;

  Team = (function(_super) {

    __extends(Team, _super);

    function Team() {
      return Team.__super__.constructor.apply(this, arguments);
    }

    Team.prototype.defaults = {
      name: "Fetus",
      age: 0,
      children: []
    };

    Team.prototype.initialize = function() {
      console.log("Welcome to this world");
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    Team.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
    };

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
    var isGrid, isList, showGrid, showList,
      _this = this;

    DashboardController.prototype.opts = {};

    function DashboardController(options) {
      this.options = options;
      this.handle_btn_click = __bind(this.handle_btn_click, this);

      this.options = _.extend({}, this.opts, this.options);
      Ti.UI.setBackgroundColor("#000000");
      this.displayType = "grid";
      this.loadDependencies();
      this.createWindows();
    }

    DashboardController.prototype.createWindows = function() {
      this.dashboardWindow = $CS.Views.Dashboard.createMainWindow({
        title: 'Dashboard',
        id: 'dashboardWindow',
        orientationModes: $CS.Helpers.Application.createOrientiationModes
      });
      this.dashboardView = $CS.Views.Dashboard.createMainView({
        id: 'dashboardView'
      });
      this.dashboardWindow.addEventListener('click', this.handle_btn_click);
      this.dashboardContainerClass = new root.DashboardContainer;
      this.dashboardContainer = this.dashboardContainerClass.dashboardContainer;
      this.gridViewClass = new root.GridView;
      this.gridView = this.gridViewClass.gridView;
      this.dashboardContainer.add(this.gridView);
      this.dashboardView.add(this.dashboardContainer);
      this.dashboardView.add(this.dashboardContainerClass.titleBar);
      return this.dashboardWindow.add(this.dashboardView);
    };

    DashboardController.prototype.open = function() {
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

    DashboardController.prototype.handle_btn_click = function(e) {
      return console.warn("button clicked: " + (JSON.stringify(e)));
    };

    DashboardController.prototype.loadDependencies = function() {
      Ti.include("/js/Common.js");
      Ti.include("/js/pages/matchSetup.js");
      Ti.include("/js/pages/match.js");
      Ti.include("/js/pages/toolViews/teams.js");
      Ti.include("/js/pages/toolViews/activity.js");
      Ti.include("/js/pages/toolViews/profile.js");
      Ti.include("/js/pages/toolViews/news.js");
      Ti.include("/js/pages/toolViews/events.js");
      Ti.include("/js/pages/toolViews/live.js");
      Ti.include("/js/pages/toolViews/rules.js");
      Ti.include("/js/pages/toolViews/settings.js");
      Ti.include("/js/pages/dashboardViews/dashboardCommonView.js");
      Ti.include("/js/pages/dashboardViews/gridView.js");
      return Ti.include("/js/pages/dashboardViews/listView.js");
    };

    isGrid = function() {
      return DashboardController.displayType === "grid";
    };

    isList = function() {
      return DashboardController.displayType === "list";
    };

    showGrid = function() {
      DashboardController.displayType = "grid";
      DashboardController.gridView.visible = true;
      return listView.visible = false;
    };

    showList = function() {
      DashboardController.displayType = "list";
      DashboardController.gridView.visible = false;
      return listView.visible = true;
    };

    return DashboardController;

  }).call(this);

  $CS.Controllers.DashboardController = DashboardController;

  $CS.Views.Play.create9BallGameView = function(options) {
    var view;
    view = Ti.UI.createView(options);
    return view;
  };

  PostsController = (function() {

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

  $CS.Views.Dashboard.createMainWindow = function(options) {
    var window;
    if (options == null) {
      options = {};
    }
    window = Ti.UI.createWindow(options);
    return window;
  };

  $CS.Views.Dashboard.createMainView = function(options) {
    var view;
    if (options == null) {
      options = {};
    }
    view = Ti.UI.createView(options);
    return view;
  };

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
