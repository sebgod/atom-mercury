LanguageMercuryView = require './language-mercury-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageMercury =
  languageMercuryView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageMercuryView = new LanguageMercuryView(state.languageMercuryViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageMercuryView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-mercury:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageMercuryView.destroy()

  serialize: ->
    languageMercuryViewState: @languageMercuryView.serialize()

  toggle: ->
    console.log 'LanguageMercury was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
