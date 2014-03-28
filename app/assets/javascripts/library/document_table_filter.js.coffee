window.app.table_filter =
  container: '.js-table-filter'
  table:
    btn: '.js-table-filter-activate-btn'

  form:
    container: '.js-table-filter-form'
    clear_btn: '.js-document-filter-clear-btn'



  # здесь у метода выставлем -> чтобы контекст был данный объект
  # elem — кнопка, к которой привязана поисковая часть формы
  toggle_form: (elem) ->
    $elem = $(elem)
    target = $elem.data('target')
    $target = $(@.container).find(@.form.container).filter("[data-target='#{target}']")
    # скрывем все формы кроме текущей и переключаем статус текущей
    $(@.form.container).not($target).hide()
    $($target).toggle()
    @.init_plugins()

  # управляем стилями кнопок переключения поисковых форм
  toggle_activate_btns_style: (elem) ->
    $(@.table.btn).not(elem).removeClass('label-success')
    $(elem).toggleClass('label-success')


  init_plugins: ->
    $(@.container).find('.js-chosen').chosen(global.chosen)
    $(@.container).find('.js-chosen-search').chosen(global.chosen_search)



$ ->
  F = app.table_filter

  $(document).on('click', F.table.btn, (e) =>
    e.preventDefault()
    $target = $(e.target).closest('.js-table-filter-activate-btn')
    F.toggle_form($target)
    F.toggle_activate_btns_style($target)
  )

  $(document).on('click', F.form.clear_btn, (e) =>
    e.preventDefault()
    $target = $(e.target).closest('.js-table-filter-activate-btn')
    F.toggle_form($target)
    F.toggle_activate_btns_style($target)
  )
