{CompositeDisposable} = require 'atom'

module.exports =
  activate: ->
    @subscriptions = new CompositeDisposable

  deactivate: ->
    @subscriptions?.dispose()
    @subscriptions = {}
    cachedTags = null

  subscribe: (args...) ->
    @subscriptions.add args...

  consumeVim: ->
    {Duplicate} = require "./duplicate"
    @subscribe(
      Duplicate.registerCommand()
    )
