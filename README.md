# Handlers-js [![Build Status](https://travis-ci.org/erichmenge/handlers-js.png?branch=master)](https://travis-ci.org/erichmenge/handlers-js)

Handlers-js provides an easy to use, dead simple, unobtrusive Javascript modularization through the Rails asset pipeline.

What's that mean? That means all you need to do is register your handler, and then call it with `data-handler="MyHandler"` on your HTML tags.

## Features

* Works "out of the box" with Turbolinks
* Easy setup with pjax
* Isolation. Code isn't executed where it doesn't belong. No worrying about code leaking by binding to different classes and element IDs.
* Consistent patterns.

## Installation

Add this line to your application's Gemfile:

    gem 'handlers-js'

And then execute:

    $ bundle

## Usage

CoffeeScript is provided via the asset pipeline. A single class called `Handlers` is created.
Your asset manifest should look something like this:

```javascript
//= require turbolinks
//= require handlers
//= require_tree .
```

**IMPORTANT** If you're using Turbolinks, make sure it is included first so that Handlers-js knows about it.

Now, simply create your CoffeeScript files like so:

```coffee
class TypeAhead
  constructor: (el) ->
    url       = $(el).data('typeahead-url')
    property  = $(el).data('typeahead-property')
    value     = $(el).data('typeahead-value')

    $(el).typeahead
      source: (typeahead, query) ->
        $.ajax
          dataType: 'json'
          url: url + query
          success: (data) ->
            typeahead.process(data)
      property: property
      onselect: (val) ->
        $(el).val(val.name)
        $(el).closest('form').submit()

  destroy: ->
    doSomeCleanup()

Handlers.register 'TypeAhead', TypeAhead
```

Then, in your HTML:

```html
<span data-handler="TypeAhead" data-typeahead-url="..." data-typeahead-property="..." data-typeahead-value="...">
  ...
</span>
```

Need to use more than one Handler on a particular element? No problem. They are comma separated.

```html
<span data-handler="TypeAhead,SomethingSpecial" ...></span>
```

### If you're not using Turbolinks

If you're not using Turbolinks, fear not. Handlers are still easy to use.

Handlers responds to three triggers:

* handlers:pageChanged  - pageChanged should be triggered when the page is loaded for the first time, this will load any handler found on the page.
* handlers:pageUpdating - This should be triggered when the page is changing, it must be passed the scope it should perform on
* handlers:pageUpdated  - This should be triggered when the page change is complete, it must be passed the scope it should perform on

A pjax example:

```coffeescript

$(document).on 'pjax:start', ->
  $(document).trigger 'handlers:pageUpdating', '[data-pjax-container]'

$(document).on 'pjax:end', ->
  $(document).trigger 'handlers:pageUpdated', '[data-pjax-container]'

$ ->
  $(document).trigger 'handlers:pageChanged'
```

Not using any AJAX + Pushstate library but still want the benefit of modular Javascript? Simply put this in a CoffeeScript file:

```coffeescript
$ ->
  $(document).trigger 'handlers:pageChanged'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
