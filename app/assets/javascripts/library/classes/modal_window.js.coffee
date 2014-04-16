

class window.ModalWindow
  defaults:
    container: '.js-modal-window'
    txt_container: '.js-modal-window-txt'
    confirm_btn: '.js-modal-window-confirm-btn'
    cancel_btn: '.js-modal-window-cancel-btn'

    is_debug: true

  constructor: (params) ->
    @.d = new ConsoleDebug @.defaults.is_debug
    @.d.init(@.$container = $(@.defaults.container))
    @.d.init(@.$txt_container = $(@.defaults.txt_container))

#    if params.hasOwnProperty('confirm')
#      @.init_confirm()
#    console.log params


  show_modal: ->
    @.$container.addClass('md-show')


  confirm: (message, callback) ->
    if message
      @.show_modal()
      @.$txt_container.html(message)
      @.$container.one('click', @.defaults.confirm_btn, ->
        callback()
      )

  destroy: ->
    @.$container.off('click', @.defaults.confirm_btn)
    @.$container.off('click', @.defaults.cancel_btn)
    delete @
