# Let's define a model
class Repo extends ReactiveRecord
  url: "https://api.github.com/users/taylorlapeyre/repos"
  idAttribute: "id"

# ..and a view for that model
class RepoView extends View
  @content: (params) ->
    @div class: 'repo', =>
      @a href: params.url, =>
        @h3 params.name
      @p params.description

# modular is good
class RepoList extends View
  @content: (params) ->
    @div class: 'repolist', =>
      for repo in params.repos
        @subview "#{repo.attributes.name}", new RepoView(repo.attributes)

# Get some records..
Repo.all (repos) ->
  view = new RepoList repos: repos

  # And slap it onto the page
  $('.container').append(view)
