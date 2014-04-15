$(document).ready ->
  myCustomConfirmBox = (message, callback) ->
    bootbox.confirm message, (confirmed) ->
      console.log confirmed
      callback()  if confirmed
      return
    return


  $.rails.allowAction = (element) ->
    message = element.data("confirm")
    answer = false
    callback = undefined
    return true  unless message
    if $.rails.fire(element, "confirm")
      myCustomConfirmBox message, ->
        console.log 'eval callback'
        callback = $.rails.fire(element, "confirm:complete", [answer])
        if callback
          oldAllowAction = $.rails.allowAction
          $.rails.allowAction = ->
            true
          element.trigger 'click.rails'
          $.rails.allowAction = oldAllowAction

          window.location.href = $.rails.href(element)
        return

    false

  return
