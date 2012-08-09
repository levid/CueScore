(function() {
  var DashboardController, Post, PostViewController, Posts, PostsController, PostsViewController,
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

  $CS.Models.Game = (function() {

    function Game(owner, course, playingFor, scoringFormat) {
      this.owner = owner;
      this.course = course;
      this.playingFor = playingFor != null ? playingFor : 'brag';
      this.scoringFormat = scoringFormat != null ? scoringFormat : 'low_net';
      console.log("game model");
    }

    Game.prototype.serialize = function() {};

    Game.prototype.deserialize = function(data) {};

    Game.prototype.save = function() {};

    Game.prototype.resume = function() {};

    Game.prototype.dataForSubmit = function() {};

    Game.prototype.submit = function(error) {};

    return Game;

  })();

  Post = (function(_super) {

    __extends(Post, _super);

    function Post() {
      return Post.__super__.constructor.apply(this, arguments);
    }

    Post.prototype.url = "http://localhost:3009/posts";

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

    Posts.prototype.url = "http://localhost:3009/posts";

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
        orientationModes: $CS.Helpers.Application.createOrientiationModes,
        exitOnClose: true
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
    var button, say, window;
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
        orientationModes: $CS.Helpers.Application.createOrientiationModes,
        exitOnClose: true
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
