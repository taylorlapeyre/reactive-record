# Let's define a model
class Repo extends ReactiveRecord
  url: "https://api.github.com/users/taylorlapeyre/repos"
  idAttribute: "id"

# ...and a view for that model
class RepoView extends View
  @content: (params) ->
    @div class: "awesomeness", =>
      @a href: params.url, =>
        @h3 params.title
      @p params.description

# Get some records..
Repo.all (repos) ->
  for repo in repos
    view = new RepoView
      url: repo.attributes.url
      title: repo.attributes.name
      description: repo.attributes.description

    # And render it!
    $('.container').append(view)
