// Generated by CoffeeScript 1.3.1
(function() {
  var PostsViewController;

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

}).call(this);