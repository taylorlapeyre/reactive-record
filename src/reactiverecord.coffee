class window.ReactiveRecord

  constructor: (attributes={}) ->
    @attributes = attributes

  @http: (options) ->
    req = new XMLHttpRequest()
    req.withCredentials = options.credentials

    req.onreadystatechange = ->
      if req.readyState == 4
        if req.status == 200
          options.ok(JSON.parse(req.responseText))
        else
          options.error(req)
    req.open options.method, options.url, true
    req.send options.data

  merge: (obj1, obj2) ->
    obj3 = {};
    for var attrname in obj1)
      obj3[attrname] = obj1[attrname]
    for var attrname in obj2
      obj3[attrname] = obj2[attrname]
    obj3

  @new: (attributes) ->
    new this(attributes)

  @find: (id, callback) ->
    @http
      method: 'GET'
      url: "#{this::url}/#{id}"
      ok: (data) =>
        callback(@new(data)) if callback?
      error: (xhr, status, error) ->
        console.error error

  @all: (callback) ->
    @http
      method: 'GET'
      url: "#{this::url}"
      ok: (data) =>
        if callback?
          callback data.map (obj) =>
            @new(obj)
      error: (xhr, status, error) ->
        console.error error

  @where: (attributes, callback) ->
    @http
      method: 'GET'
      data: attributes
      url: "#{this::url}"
      ok: =>
        if callback?
          callback data.map (obj) =>
            @new(obj)
      error: (xhr, status, error) ->
        console.error error

  @create: (attributes, callback) ->
    @http
      method: 'POST'
      data: attributes
      url: "#{this::url}"
      ok: (data) =>
        callback(@new(data)) if callback?
      error: (xhr, status, error) ->
        console.error error

  save: (callback) ->
    this::http
      method: 'POST'
      data: @attributes
      url: "#{@url}/#{@attributes[@idAttribute]}"
      ok: (data) =>
        @attributes = @merge(@attributes, data)
        callback.bind(this)() if callback?
      error: (xhr, status, error) ->
        console.error error

  update: (attributes, callback) =>
    this::http
      method: 'PUT'
      data: attributes
      url: "#{@url}/#{@attributes[@idAttribute]}"
      ok: (data) =>
        @attributes = @merge(@attributes, data)
        callback.bind(this)() if callback?
      error: (xhr, status, error) ->
        console.error error

  destroy: (callback) ->
    this::http
      method: 'DELETE'
      url: "#{@url}/#{@attributes[@idAttribute]}"
      ok: (data) =>
        callback() if callback?
      error: (xhr, status, error) ->
        console.error error

  get: (attributeName) ->
    @attributes[attributeName]
