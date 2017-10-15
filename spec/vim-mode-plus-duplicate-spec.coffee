requireFrom = (pack, path) ->
  packPath = atom.packages.resolvePackagePath(pack)
  require "#{packPath}/#{path}"

{getVimState} = requireFrom 'vim-mode-plus', 'spec/spec-helper'

describe "vim-mode-plus-duplicate", ->
  [set, ensure, keystroke, editor, editorElement, vimState] = []

  beforeEach ->
    waitsForPromise ->
      activationPromise = atom.packages.activatePackage('vim-mode-plus-duplicate')
      atom.workspace.open().then (editor) ->
        atom.commands.dispatch(editor.element, "vim-mode-plus-user:duplicate")
      activationPromise

    getVimState (state, vimEditor) ->
      vimState = state
      {editor, editorElement} = vimState
      {set, ensure, keystroke} = vimEditor

  describe "duplicate", ->

    it "duplicates a text-object", ->
      set
        text: """
              Line 1
              Line 2
              Line 3

              New paragraph
              """
        cursor: [0, 0]
      ensure 'y d a p',
        text: """
              Line 1
              Line 2
              Line 3

              Line 1
              Line 2
              Line 3

              New paragraph
              """, mode: "normal", cursor: [0, 0]

    it "duplicates a line", ->
      set
        text: """
              Line 1
              Line 2
              Line 3

              New paragraph
              """
        cursor: [1, 0]
      ensure 'y d d',
        text: """
              Line 1
              Line 2
              Line 2
              Line 3

              New paragraph
              """, mode: "normal", cursor: [1, 0]
