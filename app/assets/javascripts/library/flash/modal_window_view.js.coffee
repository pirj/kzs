# Модальное окно
# варианты отрисовки/работы
# confirm - окно с двумя кнопками «согласен» и «отмена»

class window.ModalWindowView
  defaults:
    container: '.js-modal-window'
    txt_container: '.js-modal-window-txt'
    confirm_btn: '.js-modal-window-confirm-btn'
    cancel_btn: '.js-modal-window-cancel-btn'

    css:
      active: 'm-show'
    is_debug: false

  constructor: (params) ->
    @.d = new ConsoleDebug @.defaults.is_debug
    @.d.init(@.$container = $(@.defaults.container))
    @.d.init(@.$txt_container = $(@.defaults.txt_container))

    @.$container.on('click', @defaults.cancel_btn, => @.cancel_confirm())

    @.keypress_listener = new window.keypress.Listener()
    @.keypress_listener.simple_combo("esc", => @.cancel_confirm())

  show_modal: ->
    @.$container.addClass(@.defaults.css.active)

  cancel_confirm: ->
    @.$container.removeClass(@.defaults.css.active)
    @.destroy

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
    @.keypress_listener.stop_listening()
    @.keypress_listener.unregister_combo('esc')
    delete @
