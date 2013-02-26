describe "Handlers", =>
  el = null

  beforeEach =>
    el = {}

  afterEach =>
    Handlers.unregisterAll()

  it "should be defined", ->
    expect(Handlers).toBeDefined()

  it "should register a handler", ->
    class Foo
    Handlers.register 'Foo', Foo
    expect(Handlers.handlers['Foo']).toBeDefined()

  describe  "multiple handlers", ->
    beforeEach ->
      Handlers.register 'Foo', class
      Handlers.register 'Bar', class

    afterEach ->
      expect(Handlers.handlers['Foo']).toBeDefined()
      expect(Handlers.handlers['Bar']).toBeDefined()

    it "should instantiate them", ->
      expect(-> Handlers.instantiate('Foo, Bar', el)).not.toThrow()

    it "should allow spaces", ->
      expect(-> Handlers.instantiate('Foo, Bar', el)).not.toThrow()

  it "should attach to an element", ->
    class Foo
    Handlers.register 'Foo', Foo
    expect(el.handlers).not.toBeDefined()
    expect(-> Handlers.instantiate('Foo', el)).not.toThrow()
    expect(el.handlers).toBeDefined()

  it "should throw if the handler isn't known", ->
    expect(-> Handlers.instantiate('Foo', el)).toThrow()

  it "should destroy if the destroy function is available", ->
    class Foo
      constructor: (el) ->
      destroy: ->

    Handlers.register 'Foo', Foo

    Handlers.instantiate('Foo', el)
    spyOn(el.handlers[0], 'destroy')
    Handlers.destroy(el.handlers)
    expect(el.handlers[0].destroy).toHaveBeenCalled()

  it "should not throw if there is not a destructor", ->
    class Foo
    Handlers.register 'Foo', Foo
    Handlers.instantiate 'Foo', el
    expect(-> Handlers.destroy(el.handlers)).not.toThrow()

