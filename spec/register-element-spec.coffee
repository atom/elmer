registerElement = require '../src/register-element'

describe "registerElement", ->
  registerSpy = null

  beforeEach ->
    registerSpy = spyOn(document, 'registerElement')

  it "registers an element with the specified tag name extends from HTMLElement", ->
    registerSpy.andReturn('ok')
    expect(registerElement('my-tag', {one: 'two', three: ->})).toBe 'ok'

    args = registerSpy.mostRecentCall.args
    expect(args[0]).toBe 'my-tag'
    expect(args[1].prototype.one).toBe 'two'
    expect(args[1].prototype.cloneNode).toBeDefined()

  describe "when the extends key is a string", ->
    it "uses the extends key in document.registerElement and extends the prototype from HTMLElement", ->
      registerSpy.andReturn('ok')
      expect(registerElement('my-tag', {one: 'two', extends: 'div'})).toBe 'ok'

      args = registerSpy.mostRecentCall.args
      expect(args[0]).toBe 'my-tag'
      expect(args[1].extends).toBe 'div'
      expect(args[1].prototype.one).toBe 'two'
      expect(args[1].prototype.cloneNode).toBeDefined()

  describe "when the extends key is an object", ->
    it "extends from the prototype of the specified object", ->
      class SomeClass
        someClassMethod: ->

      registerSpy.andReturn('ok')
      expect(registerElement('my-tag', {one: 'two', extends: SomeClass})).toBe 'ok'

      args = registerSpy.mostRecentCall.args
      expect(args[0]).toBe 'my-tag'
      expect(args[1].extends).toBeUndefined()
      expect(args[1].prototype.one).toBe 'two'
      expect(args[1].prototype.someClassMethod).toBeDefined()
      expect(args[1].prototype.cloneNode).toBeUndefined()

  describe "when a modelConstructor is passed in", ->
    beforeEach ->
      spyOn atom.workspace, 'addViewProvider'

    it "registers the new element as a view provider on atom.workspace", ->
      registerSpy.andReturn('view')
      class Model
        constructor: ->

      expect(registerElement('my-tag', {one: 'two', modelConstructor: Model})).toBe 'view'

      args = registerSpy.mostRecentCall.args
      expect(args[0]).toBe 'my-tag'
      expect(args[1].extends).toBeUndefined()
      expect(args[1].prototype.one).toBe 'two'
      expect(args[1].prototype.cloneNode).toBeDefined()

      expect(atom.workspace.addViewProvider).toHaveBeenCalledWith
        modelConstructor: Model
        viewConstructor: 'view'
