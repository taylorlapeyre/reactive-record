# Let's define a model
class Repo extends ReactiveRecord
  url: "https://api.github.com/users/taylorlapeyre/repos"
  idAttribute: "id"


class RepoList extends View
  @content: (params) ->
    @div class: 'repolist', =>
      for repo in params.repos
        @subview "#{repo.get('name')}", new RepoView(repo.attributes)

# ..and a view for that model
class RepoView extends View
  @content: (params) ->
    @div class: 'repo', =>
      @a href: params.url, =>
        @h3 params.name
      @p params.description

# Get some records..
Repo.all (repos) ->
  view = new RepoList repos: repos

  # And slap it onto the page
  $('.container').append(view)
