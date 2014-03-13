class ReactiveRecord

  constructor: (attributes={}) ->
    @attributes = attributes

  @init: (attributes) ->
    new this(attributes)

  @find: (id, callback) ->
    $.ajax
      type: 'GET'
      url: "#{this::url}/#{id}"
      dataType: 'json'
      success: (data) =>
        callback(@init(data)) if callback?
      error: (xhr, status, error) ->
        console.error error

  @all: (callback) ->
    $.ajax
      type: 'GET'
      url: "#{this::url}"
      dataType: 'json'
      success: (data) =>
        callback(data.map(@init)) if callback?
      error: (xhr, status, error) ->
        console.error error

  @findBy: (attributes, callback) ->
    $.ajax
      type: 'GET'
      data: attributes
      url: "#{this::url}"
      dataType: 'json'
      success: (data) =>
        callback(data.map(@init)) if callback?
      error: (xhr, status, error) ->
        console.error error

  @create: (attributes, callback) ->
    $.ajax
      type: 'POST'
      data: attributes
      url: "#{this::url}"
      dataType: 'json'
      success: (data) =>
        callback(@init(data)) if callback?
      error: (xhr, status, error) ->
        console.error error

  save: (callback) ->
    $.ajax
      type: 'POST'
      data: @attributes
      url: "#{@url}/#{@attributes[@idAttribute]}"
      dataType: 'json'
      success: (data) =>
        @attributes = $.merge(@attributes, data)
        callback.bind(this)() if callback?
      error: (xhr, status, error) =>
        console.error error

  updateAttributes: (attributes, callback) ->
    $.ajax
      type: 'PUT'
      data: attributes
      url: "#{@url}/#{@attributes[@idAttribute]}"
      dataType: 'json'
      success: (data) =>
        @attributes = $.merge(@attributes, data)
        callback.bind(this)() if callback?
      error: (xhr, status, error) ->
        console.error error

  destroy: (callback) ->
    $.ajax
      type: 'DELETE'
      url: "#{@url}/#{@attributes[@idAttribute]}"
      dataType: 'json'
      success: (data) =>
        callback() if callback?
      error: (xhr, status, error) ->
        console.error error

class Language extends ReactiveRecord
  id: 'name'
  url: 'http://localhost:3000/api/languages'