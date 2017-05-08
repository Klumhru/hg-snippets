HgSnippetsView = require './hg-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = HgSnippets =
  hgSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @hgSnippetsView = new HgSnippetsView(state.hgSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @hgSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'hg-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @hgSnippetsView.destroy()

  serialize: ->
    hgSnippetsViewState: @hgSnippetsView.serialize()

  toggle: ->
    console.log 'HgSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
