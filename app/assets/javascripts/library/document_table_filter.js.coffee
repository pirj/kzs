window.app.table_filter =
  container: '.js-table-filter'
  table:
    btn: '.js-table-filter-activate-btn'

  form:
    container: '.js-table-filter-form'
    clear_btn: '.js-document-filter-clear-btn'



  # переключаем видимость у формы, с которой работаем
  # здесь у метода выставлем -> чтобы контекст был данный объект
  # elem — кнопка, к которой привязана поисковая часть формы
  toggle_form: (elem) ->
    $target = @.find_form(elem)
    # скрывем все формы кроме текущей и переключаем статус текущей
    $(@.form.container).not($target).hide()
    $($target).toggle()
    @.init_plugins()

  # ищем форму, связанную с заголовком формы (elem)
  find_form: (elem) ->
    target = $(elem).data('target')
    $(@.container).find(@.form.container).filter("[data-target='#{target}']")


  # управляем стилями кнопок переключения поисковых форм
  toggle_activate_btns_style: (elem) ->
    $(@.table.btn).not(elem).removeClass('label-success')
    $(elem).toggleClass('label-success')

  # очищаем инпуты внутри формы
  clear_inputs: (form) ->
    $form = $(form)
    $form.find('input, select, textarea').not('input[type=submit]').val('')


  # инициализация плагинов chosen и других
  init_plugins: ->
    $(@.container).find('.js-chosen').filter(':visible').chosen(global.chosen)
    $(@.container).find('.js-chosen-search').filter(':visible').chosen(global.chosen_search)



$ ->
  F = app.table_filter

  # клик по кнопке «имя фильтра»
  $(document).on('click', F.table.btn, (e) =>
    e.preventDefault()
    $target = $(e.target).closest('.js-table-filter-activate-btn')
    F.toggle_form($target)
    F.toggle_activate_btns_style($target)
  )

  # клик по кнопке «очистить»
  $(document).on('click', F.form.clear_btn, (e) =>
    e.preventDefault()

    $target = $(e.target).closest(F.form.clear_btn)
    $form = $target.closest('.js-table-filter-form')

    F.toggle_form($target)
    F.clear_inputs($form)
    F.toggle_activate_btns_style($target)

    $form.find('input[type=submit]').trigger('click')
  )
