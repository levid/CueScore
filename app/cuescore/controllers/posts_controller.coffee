class PostsController
  opts: {}
  
  constructor: (@options) ->
    @options = _.extend({}, @opts, @options)
    
    @postView = new $CS.Views.PostsView()

  open: () ->
    unless Ti.Platform.name is "android"
      Ti.UI.iPhone.showStatusBar()
      @postView.open 
        fullscreen: false
    else
      @postView.open 
        fullscreen: true

$CS.Controllers.PostsController = PostsController