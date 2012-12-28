describe 'Triggers', =>
  beforeEach =>
    $('body').append('<span style="display: none"; id="foospan" data-handler="Foo"></span>')
    Handlers.register 'Foo', class
      constructor: (el) ->
        @el = $(el)
        $(el).html('filled')
      destroy: ->
        @el.html("destroyed")

  afterEach =>
    $('#foospan').remove()
    Handlers.unregister_all

  describe 'When the page changes', ->
    it 'should trigger the event', ->
      $(document).trigger 'handlers:pageChanged'
      expect($('#foospan').html()).toEqual "filled"

  describe 'When page is updated', ->
    it 'should trigger the event', ->
      $(document).trigger 'handlers:pageUpdated', 'body'
      expect($('#foospan').html()).toEqual "filled"

    it 'should maintain scope', ->
      $('#foospan').html('')
      $('body').append(
        '<span style="display: none"; id="onlyscope">
          <span style="display: none"; id="scopedspan" data-handler="Foo"></span>
        </span>'
      )
      $(document).trigger 'handlers:pageUpdated', '#onlyscope'
      expect($('#foospan').html()).toEqual ""
      expect($('#scopedspan').html()).toEqual "filled"

  describe 'When page is changing', ->
    it 'should destroy', ->
      $(document).trigger('handlers:pageChanged')
      $(document).trigger('handlers:pageUpdating', 'body')
      expect($('#foospan').html()).toEqual "destroyed"

    it 'should maintain scope', ->
      $('body').append(
        '<span style="display: none"; id="onlyscope">
          <span style="display: none"; id="scopedspan" data-handler="Foo"></span>
        </span>'
      )
      $(document).trigger('handlers:pageChanged')
      $(document).trigger('handlers:pageUpdating', '#onlyscope')
      expect($('#foospan').html()).toEqual "filled"
      expect($('#scopedspan').html()).toEqual "destroyed"
