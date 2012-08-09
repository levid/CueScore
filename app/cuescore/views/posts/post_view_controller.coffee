class PostViewController
  constructor: (@post) ->
    Ti.UI.setBackgroundColor "#fff"
    
    # create @window and @tableView
    @postsWindow = Ti.UI.createWindow
      title:            'Post'
      id:               'postWindow'
      top: 0
      orientationModes: $CS.Helpers.Application.createOrientiationModes
      exitOnClose:      true
    
    data = [
      title: "Row 1"
    ,
      title: "Row 2"
    ]
    
    @tableView = Titanium.UI.createTableView(data: data)

    data = []
    data.push @createTitleRow()
    # data.push @createBodyRow()
    # data.push @createAuthorRow()

    @tableView.data = data
    
    @postsWindow.add @tableView
    @postsWindow.open()


  createTitleRow: ->
    row = Ti.UI.createTableViewRow
      title: @post.get('name')

    @post.bind 'change:name', (e) =>
      row.title = @post.get('name')

    row
    

$CS.Views.PostView = PostViewController