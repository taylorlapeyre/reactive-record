var ReactiveRecord;

ReactiveRecord = (function() {
  function ReactiveRecord(attributes) {
    if (attributes == null) {
      attributes = {};
    }
    this.attributes = attributes;
  }

  ReactiveRecord.init = function(attributes) {
    return new this(attributes);
  };

  ReactiveRecord.find = function(id, callback) {
    return $.ajax({
      type: 'GET',
      url: "" + this.prototype.url + "/" + id,
      dataType: 'json',
      success: (function(_this) {
        return function(data) {
          if (callback != null) {
            return callback(_this.init(data));
          }
        };
      })(this),
      error: function(xhr, status, error) {
        return console.error(error);
      }
    });
  };

  ReactiveRecord.all = function(callback) {
    return $.ajax({
      type: 'GET',
      url: "" + this.prototype.url,
      dataType: 'json',
      success: (function(_this) {
        return function(data) {
          if (callback != null) {
            return callback(data.map(_this.init));
          }
        };
      })(this),
      error: function(xhr, status, error) {
        return console.error(error);
      }
    });
  };

  ReactiveRecord.findBy = function(attributes, callback) {
    return $.ajax({
      type: 'GET',
      data: attributes,
      url: "" + this.prototype.url,
      dataType: 'json',
      success: (function(_this) {
        return function(data) {
          if (callback != null) {
            return callback(data.map(_this.init));
          }
        };
      })(this),
      error: function(xhr, status, error) {
        return console.error(error);
      }
    });
  };

  ReactiveRecord.create = function(attributes, callback) {
    return $.ajax({
      type: 'POST',
      data: attributes,
      url: "" + this.prototype.url,
      dataType: 'json',
      success: (function(_this) {
        return function(data) {
          if (callback != null) {
            return callback(_this.init(data));
          }
        };
      })(this),
      error: function(xhr, status, error) {
        return console.error(error);
      }
    });
  };

  ReactiveRecord.prototype.save = function(callback) {
    return $.ajax({
      type: 'POST',
      data: this.attributes,
      url: "" + this.url + "/" + this.attributes[this.idAttribute],
      dataType: 'json',
      success: (function(_this) {
        return function(data) {
          _this.attributes = $.merge(_this.attributes, data);
          if (callback != null) {
            return callback.bind(_this)();
          }
        };
      })(this),
      error: (function(_this) {
        return function(xhr, status, error) {
          return console.error(error);
        };
      })(this)
    });
  };

  ReactiveRecord.prototype.update = function(attributes, callback) {
    return $.ajax({
      type: 'PUT',
      data: attributes,
      url: "" + this.url + "/" + this.attributes[this.idAttribute],
      dataType: 'json',
      success: (function(_this) {
        return function(data) {
          _this.attributes = $.merge(_this.attributes, data);
          if (callback != null) {
            return callback.bind(_this)();
          }
        };
      })(this),
      error: function(xhr, status, error) {
        return console.error(error);
      }
    });
  };

  ReactiveRecord.prototype.destroy = function(callback) {
    return $.ajax({
      type: 'DELETE',
      url: "" + this.url + "/" + this.attributes[this.idAttribute],
      dataType: 'json',
      success: (function(_this) {
        return function(data) {
          if (callback != null) {
            return callback();
          }
        };
      })(this),
      error: function(xhr, status, error) {
        return console.error(error);
      }
    });
  };

  return ReactiveRecord;

})();
