module.exports = {
  activate() {},

  deactivate() {
    if (this.disposable) this.disposable.dispose()
  },

  consumeVim({Base}) {
    class Duplicate extends Base.getClass("Operator") {
      constructor(...args) {
        super(...args)
        this.trackChange = true
      }

      mutateSelection(selection) {
        this.editor.duplicateLines()
      }
    }
    Duplicate.commandPrefix = "vim-mode-plus-user"
    this.disposable = Duplicate.registerCommand()
  },
}
