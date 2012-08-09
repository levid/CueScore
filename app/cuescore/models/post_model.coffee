class Post extends Backbone.Model
  url: "#{$CS.API_ENDPOINT}/posts"

  toParams: ->
    # assuming you've stored an instance of the previous QueryStringBuilder class...
    $CS.Utils.QueryStringBuilder.stringify(this.attributes, "post")
    
  toJSON: ->
    { post: @attributes }

class Posts extends Backbone.Collection
  url: "#{$CS.API_ENDPOINT}/posts"
  model: Post

$CS.Models.Post = Post
$CS.Models.Posts = Posts