##### Atom and all repositories under Atom will be archived on December 15, 2022. Learn more in our [official announcement](https://github.blog/2022-06-08-sunsetting-atom/)
 # elmer

Experimental view system for atom. Uses [polymer](polymer-project.org) [template binding](https://github.com/Polymer/TemplateBinding) project.

See [template-explore](https://github.com/benogle/template-explore) for a usage example.

## Basic Example

Model:

```coffee
class TemplateExploreModel
  buttonMessage: 'Clicked'
  buttonClicks: 0

  clicked: -> @buttonClicks++
```

Custom element

```coffee
{registerElement} = require 'elmer'

TemplateExploreModel = require './template-explore-model'
Template = require '../templates/template-explore.html'

module.exports =
TemplateExploreElement = registerElement 'template-explore',
  modelConstructor: TemplateExploreModel
  createdCallback: ->
    @appendChild(Template.clone())
    @rootTemplate = @querySelector('template')
    @classList.add 'tool-panel', 'panel-right', 'padded'

    @addEventListener 'click', (e) =>
      @model.clicked() if e.target.matches('button')

  getModel: -> @model
  setModel: (@model) ->
    @rootTemplate.model = @model
```

HTML Template:

```html
<template bind="{{}}">
  <div>
    {{ buttonMessage }}
    {{ buttonClicks == 0 ? 'never' : buttonClicks }}
    <button class="btn">Click Me</button>
  </div>
</template>

```

Adding your new model/view as a right panel:

```coffee
@model = new TemplateExploreModel
@panel = atom.workspace.addRightPanel item: @model
```
