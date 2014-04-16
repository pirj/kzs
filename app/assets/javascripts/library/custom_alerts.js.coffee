myCustomConfirmBox = (message, callback) ->
  modal = new ModalWindow
  console.log modal
  modal.confirm message, callback
  modal.destroy
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
      return

  false

$.rails.handleLink = (element) ->
  window.location = $.rails.href(element)
  false

$ ->
  $(document).off('click.rails', $.rails.linkClickSelector)
  # https://github.com/rails/jquery-ujs/blob/master/src/rails.js#L321
  $(document).delegate $.rails.linkClickSelector, "click.rails", (e) ->
    link = $(this)
    method = link.data("method")
    data = link.data("params")
    metaClick = e.metaKey or e.ctrlKey
    return $.rails.stopEverything(e)  unless $.rails.allowAction(link)
    $.rails.disableElement link  if not metaClick and link.is($.rails.linkDisableSelector)
    if link.data("remote") isnt `undefined`
      return true  if metaClick and (not method or method is "GET") and not data
      handleRemote = $.rails.handleRemote(link)

      # response from rails.handleRemote() will either be false or a deferred object promise.
      if handleRemote is false
        $.rails.enableElement link
      else
        handleRemote.error ->
          $.rails.enableElement link
          return

      false
    else if link.data("method")
      $.rails.handleMethod link
      false
    else
      $.rails.handleLink link
      false






