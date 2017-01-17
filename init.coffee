# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"


# START https://github.com/atom/atom/issues/9544#issuecomment-254378382
disableGitRefreshOnFocus = ->
  atom.project.repositories.forEach (repo) ->
    if repo and repo.subscriptions and repo.subscriptions.disposables and repo.subscriptions.disposables.size
        Array.from(repo.subscriptions.disposables).forEach (item) ->
          content = item.disposalAction + ''
          if content.indexOf('focus') > 1
            item.dispose()
          return
  return

atom.project.emitter.on "did-change-paths", disableGitRefreshOnFocus
disableGitRefreshOnFocus()


atom.commands.add 'atom-text-editor', 'custom:refresh-git-status', ->
    atom.project.repositories.forEach (repo) ->
      repo.refreshStatus()
# END https://github.com/atom/atom/issues/9544#issuecomment-254378382
