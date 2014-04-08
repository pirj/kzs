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
   agree_btn: '.js-document-conform-agree-btn'
   deny_btn: '.js-document-conform-deny-btn'
   conformation_form: '.js-document-conform-modal-form'
   conform_type: '.js-document-conform-type'
   conform_txt: '.js-document-conform-txt'

   debug: '.js-document-debug'

  constructor: ->
    @.$debug = $(@.params.debug)
    @.send_without_validate = false # переменная для определения,можем ли мы без валидации отправить форму на сервер

    @.init(@.$agree_btn = $(@.params.agree_btn))
    @.init(@.$deny_btn = $(@.params.deny_btn))
    @.init(@.$conformation_form = $(@.params.conformation_form))
    @.init(@.$conformation_form_submit = $(@.params.conformation_form).find('input[type=submit]'))
    @.init(@.$conform_type = $(@.params.conform_type))
    @.init(@.$conform_txt = $(@.params.conform_txt))


    @.$agree_btn.on('click', (e) =>
      e.preventDefault()
      @.agree()
      return false
    )

    @.$deny_btn.on('click', (e) =>
      e.preventDefault()
      @.deny()
      return false
    )

    # обрабатываем ввод букв в окне с комментарием
    @.$conform_txt.on('keyup', (e) =>
      clearTimeout(@.timer_id)
      @.timer_id = setTimeout( =>
        if @.can_send_form()
          @.debug 'can send conform set to TRUE'
          @.$conformation_form_submit.prop('disabled', '')
        clearTimeout(@.timer_id)
      , 300)
    )
    @.init_ajax_create_conform()
    @.debug 'conforming view created'

  # пишем в результат инициализаций
  init: (obj) ->
    if obj.length
      str = "<p class='text-success'>#{obj.selector} init</p>"
    else
      str = "<p class='text-danger'>#{obj.selector} non init</p>"
    @.$debug.html(@.$debug.html() + str)

  # пишем в дебаг
  debug: (str) ->
    @.$debug.html(@.$debug.html() + "<p>#{str}</p>")


  # обработка клика по кнопке «согласен»
  agree: () ->
    @.debug 'agree clicked'
    @.send_without_validate = true
    @.$conform_type.val(true)
    @.$conformation_form_submit.prop('disabled', '')


  # обработка клика по кнопке «не очень согласен»
  deny: () ->
    @.debug 'deny clicked'
    @.$conform_type.val(false)
    # если комментарий пустой,то дизэйблим кнопку сабмита формы
    unless @.can_send_form()
      @.$conformation_form_submit.prop('disabled', 'disabled')


  # вешаем событие и прерывание отправки формы на сервер с вариантом голосования
  init_ajax_create_conform: ->
    @.debug 'ajax conform inited'
    @.$conformation_form.on('ajax:before', =>
      @.debug 'before ajax send form'
      # если комментарий
      if @.can_send_form() || @.send_without_validate
        @.debug 'can send conform'
        return true
      else
        @.debug 'can not send conform'
        return false
    )


  # проверяет можно ли отправить форму.
  # возвращаем false если комментарий пустой
  # возвращаем true если есть хотя бы 1 символ в комментарии
  can_send_form: ->
    @.$conform_txt.val().length*true

