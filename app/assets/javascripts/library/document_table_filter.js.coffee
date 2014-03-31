window.app.table_filter =
  container: '.js-table-filter'
  table:
    btn: '.js-table-filter-activate-btn'

  form:
    container: '.js-table-filter-form'
    clear_btn: '.js-document-filter-clear-btn'

  status_bar:
    container: '.js-table-filter-status-bar'
    clear_btn: '.js-table-filter-status-bar-clear-btn'
    change_btn: '.js-table-filter-status-bar-change-btn'



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
    $target = $(e.target).closest(F.table.btn)
    F.toggle_form($target)
    F.toggle_activate_btns_style($target)
  )

  # клик по кнопке «очистить»
  $(document).on('click', F.form.clear_btn, (e) =>
    e.preventDefault()

    $target = $(e.target).closest(F.form.clear_btn)
    $form = $target.closest(F.form.container)

    F.clear_inputs($form)
    $form.find('input[type=submit]').trigger('click')
  )

  # клик по кнопке «сбросить» направленной на весь фильтр
  $(document).on('click', F.status_bar.clear_btn, (e) =>
    e.preventDefault()

    $forms = $(F.form.container)

    F.clear_inputs($forms)
    $forms.first().find('input[type=submit]').trigger('click')
  )
