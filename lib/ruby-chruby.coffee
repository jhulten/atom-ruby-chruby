RubyChrubyView = require './ruby-chruby-view'
{CompositeDisposable} = require 'atom'

module.exports = RubyChruby =
  rubyChrubyView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @rubyChrubyView = new RubyChrubyView(state.rubyChrubyViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @rubyChrubyView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ruby-chruby:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rubyChrubyView.destroy()

  serialize: ->
    rubyChrubyViewState: @rubyChrubyView.serialize()

  toggle: ->
    console.log 'RubyChruby was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
