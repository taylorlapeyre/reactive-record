#### ReactiveRecord

This small coffeescript library attempts to create a way to access data from a server in a way similar to the way ActiveRecord in Rails works. It would go swimmingly with [SpacePen](https://github.com/atom/space-pen).

It handles a bunch of heavy lifting for you, but it's extremely simple right now.

**Requirements**

- jQuery
- Some sort of RESTful api endpoint somewhere

**Usage**

```coffeescript
class Product extends ReactiveRecord
  # Required settings for ReactiveRecord classes
  url: 'http://myserver.com/api/products'
  idAttribute: 'id'

myProduct = Product.init(id: 1, name: "Awesome")

# All callbacks are optional

myProduct.save ->
  console.log "Saved ", this


myProduct.update name: "Really Awesome", ->
  console.log this.get('name') # => "Really Awesome"


Product.find 1, (product) ->
  console.log product


Product.all (products) ->
  for product in products
    console.log product


Product.where type: 'winner', (products) ->
  for product in products
    console.log product


Product.create name: "The Best", type: "winner", (product) ->
  console.log "#{this} was saved!"

myProduct.destroy()
```

**Contributing**

Get set up:

```shell
$ cd reactiverecord
$ npm install
$ npm start
```

- Fork this repository
- Clone and make your changes
- Push to your remote fork
- Submit a pull request with a description of why you made the change
