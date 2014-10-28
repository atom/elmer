
# Public:
module.exports =
registerElement = (elementName, elementPrototype) ->
  tagToExtend = null
  classToExtend = null

  if typeof elementPrototype.extends is 'string'
    tagToExtend = elementPrototype.extends
  else if elementPrototype.extends?
    classToExtend = elementPrototype.extends

  classToExtend ?= HTMLElement

  prototype = Object.create(classToExtend.prototype)
  prototype[key] = value for key, value of elementPrototype
  registerArgs = {prototype}
  registerArgs.extends = tagToExtend if tagToExtend?

  viewClass = document.registerElement(elementName, registerArgs)

  if elementPrototype.modelConstructor? and atom?.views?.addViewProvider?
    atom.views.addViewProvider
      modelConstructor: elementPrototype.modelConstructor
      viewConstructor: viewClass

  viewClass
