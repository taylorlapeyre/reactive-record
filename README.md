#### ReactiveRecord

This small coffeescript library attempts to create a way to access data from a server in a way similar to the way ActiveRecord in Rails works.

**Requirements**

- jQuery

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


myProduct.updateAttributes name: "Really Awesome", ->
  console.log this.attributes.name # => "Really Awesome"


Product.find 1, (product) ->
  console.log product


Product.all (products) ->
  for product in products
    console.log product


Product.findBy type: 'winner', (products) ->
  for product in products
    console.log product


Product.create name: "The Best", type: "winner" (product) ->
  console.log "#{this} was saved!"

myProduct.destroy()
```
