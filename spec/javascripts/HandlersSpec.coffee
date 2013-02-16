describe "Handlers", =>
  el = null

  beforeEach =>
    el = {}

  afterEach =>
    Handlers.unregister_all()

  it "should be defined", ->
    expect(Handlers).toBeDefined()

  it "should register a handler", ->
    Handlers.register 'Foo', class
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
    Handlers.register 'Foo', class
    expect(el.handlers).not.toBeDefined()
    expect(-> Handlers.instantiate('Foo', el)).not.toThrow()
    expect(el.handlers).toBeDefined()

  it "should throw if the handler isn't known", ->
    expect(-> Handlers.instantiate('Foo', el)).toThrow()

  it "should destroy if the destroy function is available", ->
    Handlers.register 'Foo', class
      constructor: (el) ->
      destroy: ->

    Handlers.instantiate('Foo', el)
    spyOn(el.handlers[0], 'destroy')
    Handlers.destroy(el.handlers)
    expect(el.handlers[0].destroy).toHaveBeenCalled()

  it "should not throw if there is not a destructor", ->
    Handlers.register 'Foo', class
    Handlers.instantiate 'Foo', el
    expect(-> Handlers.destroy(el.handlers)).not.toThrow()

