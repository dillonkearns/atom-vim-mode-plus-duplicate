requireFrom = (pack, path) ->
  packPath = atom.packages.resolvePackagePath(pack)
  require "#{packPath}/lib/#{path}"

Base = requireFrom('vim-mode-plus', 'base')
Operator = Base.getClass('Operator')

class Duplicate extends Operator
  @commandPrefix: 'vim-mode-plus-user'
  hover: icon: ':flags:', emoji: ':flags:'
  trackChange: true

  mutateSelection: (selection) ->
    @editor.duplicateLines()

module.exports = {Duplicate}
