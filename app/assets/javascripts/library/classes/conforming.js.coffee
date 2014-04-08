# класс для работы согласований документов
# ограничения
# — на странице только одно голосование (для данного человека)
#
# сценарии
# — вначале видим кнопку без голосования
# — если нажали голосовать, то показываем попап для ввода мнения (меняем заголовки там)
# — если в попапе нажали «отмена», то сбрасываем мнение в нейтральное
# — после подтверждения попапа не даем голосовать
# — после успешного голосования показываем текст в общем списке

class window.ConformingView
  params:
   conform_btn: '.js-document-conform-btn'
   modal: '.js-document-conform-modal'
   modal_form: '.js-document-conform-modal-form'

   conform_type: '.js-document-conform-type'
   conform_txt: '.js-document-conform-txt'
   can_send_conform: false # можно ли отослать форму на сервер

   debug: '.js-document-debug'

  constructor: ->
    @.$conform_btn = $(@.params.conform_btn)
    @.$modal = $(@.params.modal)
    @.$modal_form = $(@.params.modal_form)

    @.$conform_type = $(@.conform_type)
    @.$conform_txt = $(@.conform_txt)

    @.$debug = $(@.params.debug)

    @.$conform_btn.on('click', (e) =>
      e.preventDefault()
      @.conform()
      return false
    )

    @.init_modal()
    @.init_ajax_create_conform()
    @.debug 'conforming view created'

  # пишем в дебаг
  debug: (str) ->
    @.$debug.html(@.$debug.html() + "<p>#{str}</p>")


  # обработка клика по кнопке голосования
  conform: () ->
    @.toggle_modal()
    @.enable_conform_validations()


  # управляем видимостью всплывающего окна с текстом под комментарий
  toggle_modal: ->
    @.debug 'toggle modal'

  # скрываем модальное

  # инициализируем модальное окно и события на него
  init_modal: ->
    # кнопка крестик
    # кнопка отмена

  # вешаем событие и прерывание отправки формы на сервер с вариантом голосования
  init_ajax_create_conform: ->
    @.$modal_form.on('ajax:beforeSend', =>
      console.log 'hello'
      @.debug 'ajax send form'
      return false
      # если стоит запрет на отправку,то выходим из колбэка
      # TODO-justvitalius: лучше сделать вызов метода,который будет возвращать true или false
#      if @.can_send_conform == false
#        return true
#      return false
    )

  # выносим решение можно ли отправить форму на сервер
  

  # управляем валидациями на создание голоса
  enable_conform_validations: ->
    if @.$conform_txt.text().length
      @.can_send_conform == true
      @.debug 'can send conform'
    else
      @.debug 'can not senf conform'

