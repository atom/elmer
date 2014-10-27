
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

  document.registerElement(elementName, registerArgs)
