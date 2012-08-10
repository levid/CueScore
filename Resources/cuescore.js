(function() {
  var API, AppSync, DashboardController, EightBall, Game, League, Match, Player, Post, PostViewController, Posts, PostsController, PostsViewController, Template, after, console, every, player, say,
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

    __extends(EightBall, _super);

    function EightBall() {
      return EightBall.__super__.constructor.apply(this, arguments);
    }

    EightBall.prototype.defaults = {
      stripes: 1,
      solids: 2,
      innings: 0,
      match_ended_callback: typeof callback !== "undefined" && callback !== null,
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
            eight_on_snap: false,
            break_and_run: false,
            timeouts_taken: 0,
            callback: typeof addToPlayerOne !== "undefined" && addToPlayerOne !== null,
            ball_type: null,
            has_won: false,
            score: []
          },
          two: {
            eight_on_snap: false,
            break_and_run: false,
            timeouts_taken: 0,
            callback: typeof addToPlayerOne !== "undefined" && addToPlayerOne !== null,
            ball_type: null,
            has_won: false,
            score: []
          }
        }
      ]
    };

    EightBall.prototype.initialize = function(addToPlayerOne, addToPlayerTwo, callback) {
      console.log("Welcome to this world");
      return this.bind("change:name", function() {
        var name;
        name = this.get("name");
        return console.log("Changed my name to " + name);
      });
    };

    EightBall.prototype.replaceNameAttr = function(name) {
      return this.set({
        name: name
      });
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

    EightBall.prototype.hitSafety = function() {
      this.getCurrentlyUpPlayer().addOneToSafeties();
      return this.nextPlayerIsUp();
    };

    EightBall.prototype.setPlayerWon = function(playerNum) {
      if (playerNum === 1) {
        this.player['one'].has_won = true;
        return this.playerp['one'].callback().games_won += 1;
      } else if (playerNum === 2) {
        this.player['two'].has_won = true;
        return this.player['two'].callback().games_won += 1;
      }
    };

    return EightBall;

  })(Game);

  $CS.Models.Game.EightBall = EightBall;

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

  player = new Player({
    name: "Thomas",
    age: 67,
    children: ["Ryan"]
  });

  player.replaceNameAttr("Stewie Griffin");

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
