# Let's define a model
class Repo extends ReactiveRecord
  url: "https://api.github.com/users/taylorlapeyre/repos"
  idAttribute: "id"

class PageView extends View
  @content: (params) ->
    @div class: 'main', =>
      @header =>
        @h1 "Taylor Lapeyre's Repositories on GitHub"
        @subview 'repoList', new RepoList(params)

class RepoList extends View
  @content: (params) ->
    @div class: 'repolist', =>
      for repo in params.repos
        @subview repo.get('name'), new RepoView(repo.attributes)

class RepoView extends View
  @content: (params) ->
    @div class: 'repo', =>
      @a href: params.url, =>
        @h3 params.name
      @p params.description

Repo.all (repos) ->
  view = new PageView repos: repos
  $('.container').append(view)
