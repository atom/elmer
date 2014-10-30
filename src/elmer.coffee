exports.registerElement = require './register-element'

require('./html-require').register()

# Include all the global polymer stuff. DIRTY.
unless HTMLTemplateElement.prototype.bindingDelegate?
  # This is required by the polymer stuff. It can be noop'd because
  # Object.observe is built into chrome.
  global.Platform =
    performMicrotaskCheckpoint: ->

  require 'Node-bind/src/NodeBind'
  require 'TemplateBinding/src/TemplateBinding'
  require 'observe-js'
  global.esprima = require('polymer-expressions/third_party/esprima/esprima').esprima
  {PolymerExpressions} = require 'polymer-expressions/src/polymer-expressions'

  HTMLTemplateElement.prototype.bindingDelegate = new PolymerExpressions
