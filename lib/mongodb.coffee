MongodbView = require './mongodb-view'
{CompositeDisposable} = require 'atom'

module.exports = Mongodb =
  mongodbView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @mongodbView = new MongodbView(state.mongodbViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @mongodbView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mongodb:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @mongodbView.destroy()

  serialize: ->
    mongodbViewState: @mongodbView.serialize()

  toggle: ->
    console.log 'Mongodb was toggled 2!'
    dirList = document.querySelectorAll 'li.directory'
    checkMongo = (node) ->
      childNode for childNode in node.querySelectorAll("span.name") when childNode.getAttribute("name") == "mongod.lock"
    mongodbList = mongoNode for mongoNode in dirList when checkMongo mongoNode

    console.log dirList
    console.log "mongodb node list"
    console.log mongodbList

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
