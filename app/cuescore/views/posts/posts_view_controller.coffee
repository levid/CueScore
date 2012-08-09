class PostsViewController
  # assumming an existing @tableView and @window
  constructor: () ->
    Ti.UI.setBackgroundColor "#fff"
    
    # create @window and @tableView
    @postsWindow = Ti.UI.createWindow
      title:            'Posts'
      id:               'postsWindow'
      top:               0
      orientationModes: $CS.Helpers.Application.createOrientiationModes
      exitOnClose:      true
    
    @data = [
      title: "Row 1"
    ,
      title: "Row 2"
    ]
    
    @tableView = Titanium.UI.createTableView(data: @data)
    
    every 5000, () =>
      @reload()
      
  reload: ->
    @posts = new $CS.Models.Posts()
    @posts.fetch
      success: =>
        @prepareData(@posts.models)
      error: (e) =>
        console.error JSON.stringify(e)
        
  prepareData: (models) ->
    # _.each models, (model) =>
      # @data.push @createTitleRow(model)
# 
    # @tableView.data = @data
    
    @tableView.data = _.map models, (model) ->
      { title: model.get('name'), hasChild: true }

    @postsWindow.add @tableView
    @postsWindow.open()
    
  createTitleRow: (model) ->
    row = Ti.UI.createTableViewRow
      title: model.get('name')
    model.on 'change:name', (e) =>
      row.title = model.get('name')
    row
      
$CS.Views.PostsView = PostsViewController