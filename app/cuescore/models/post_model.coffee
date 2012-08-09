class Post extends Backbone.Model
  url: "http://localhost:3009/posts"

  toParams: ->
    # assuming you've stored an instance of the previous QueryStringBuilder class...
    $CS.Utils.QueryStringBuilder.stringify(this.attributes, "post")
    
  toJSON: ->
    { post: @attributes }

class Posts extends Backbone.Collection
  url: "http://localhost:3009/posts"
  model: Post

$CS.Models.Post = Post
$CS.Models.Posts = Posts