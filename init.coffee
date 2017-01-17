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


(->
  ###*
  # https://github.com/atom/atom/issues/9544#issuecomment-233538078
  # Unsubscribe from the gitrefresh event for every repo in the current project
  # A fix for issue: https://github.com/atom/atom/issues/9544
  ###

  disableGitRefresh = ->
    atom.project.repositories.forEach (repo) ->
      if repo and repo.subscriptions and repo.subscriptions.disposables and repo.subscriptions.disposables.size
        repo.subscriptions.dispose()
      return
    return

  # run every minute in case you change project or add a new folder
  window.setInterval disableGitRefresh, 60000
  return
).call this
